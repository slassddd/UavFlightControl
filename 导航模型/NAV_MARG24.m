classdef NAV_MARG24 < fusion.internal.INSFilterEKF
%   This class is for internal use only. It may be removed in the future. 
%

%   Copyright 2018-2019 The MathWorks, Inc.


%#codegen

    properties
        % Multiplicative Process Noises
        
        %GyroscopeNoise Multiplicative process noise variance from the gyroscope (rad/s)^2 
        %   Specify the process noise variance of the gyroscope input to
        %   the fusion algorithm. The gyroscope noise is specified in
        %   units of (rad/s)^2. The default value of this property is 1e-9
        %   (rad/s)^2.
        GyroscopeNoise = [1e-9 1e-9 1e-9]
        
        %AccelerometerNoise Multiplicative process noise variance from the accelerometer (m/s^2)^2 
        %   Specify the process noise variance of the accelerometer input
        %   to the fusion algorithm. The accelerometer noise is specified
        %   in units of (m/s^2)^2. The default value of this property is
        %   1e-4 (m/s^2)^2.
        AccelerometerNoise = [1e-4 1e-4 1e-4]
        
        %GyroscopeBiasNoise Multiplicative process noise variance from the gyroscope bias (rad/s)^2 
        %   Specify the process noise variance of the bias in the gyroscope
        %   input to the fusion algorithm. The gyroscope bias noise is
        %   specified in units of (rad/s)^2. The default value of this
        %   property is 1e-10 (rad/s)^2.
        GyroscopeBiasNoise = [1e-10 1e-10 1e-10]
        
        %AccelerometerBiasNoise Multiplicative process noise variance from the accelerometer bias (m/s^2)^2 
        %   Specify the process noise variance of the bias in the
        %   accelerometer input to the fusion algorithm. The accelerometer
        %   bias noise is specified in units of (m/s^2)^2. The default
        %   value of this property is 1e-4 (m/s^2)^2.
        AccelerometerBiasNoise = [1e-4 1e-4 1e-4]

        % Additive Process Noises

        %GeomagneticVectorNoise Additive process noise for geomagnetic vector (uT^2) 
        %   Specify the process noise variance of the geomagnetic vector
        %   state estimate. The geomagnetic vector noise is specified in
        %   units of uT^2. The default value of this property is 1e-6 uT^2
        GeomagneticVectorNoise = [1e-6 1e-6 1e-6]

        %MagnetometerBiasNoise Additive process noise for magnetometer bias (uT^2)
        %   Specify the process noise variance of the magnetometer offset bias
        %   state estimate. The magnetometer offset bias noise is specified in
        %   units of uT^2. The default value of this property is 0.1 uT^2
        MagnetometerBiasNoise = [0.1 0.1 0.1]
        
        % SLASSDDD 风速
        WindspeedNoise = [.2 .2].^2;
    end
    
        % State and Error Covariance 
        
    properties (Dependent)    
        %State State vector of the internal extended Kalman Filter 
        %   Specify the initial value of the extended Kalman filter state
        %   vector. The state values represent:
        %       State                           Units        Index
        %   Orientation (quaternion parts)                   S(1:4)
        %   Position (NAV)                      m            S(5:7)
        %   Velocity (NAV)                      m/s          S(8:10)
        %   Delta Angle Bias (XYZ)              rad/s        S(11:13)
        %   Delta Velocity Bias (XYZ)           m/s          S(14:16)
        %   Geomagnetic Field Vector (NAV)      uT           S(17:19)
        %   Magnetometer Bias (XYZ)             uT           S(20:22)
        %   Wind speed (NE)                     m/s          S(23:24)
        State;
    end
    
    properties
        %StateCovariance State error covariance for the internal extended Kalman Filter
        %   Specify the initial value of the error covariance matrix. The
        %   error covariance matrix is a 24-by-24 element matrix. The
        %   default value of this property is eye(24)*1e-6
        StateCovariance = defaultCov();
    end
    
    properties (Hidden)
        OtherAdditiveNoise = 1e-9;
    end
    
    properties (Hidden, Constant)
        NumStates = 24;
    end
    
    properties (Access = private, Constant)
        MAG_FIELD_INDEX = 17;
    end
    
    properties (Access = protected)
        pGyroInteg
        pAccelInteg
        
        pState = defaultState(fusion.internal.frames.ReferenceFrame.getDefault);
    end

    methods
        function obj = NAV_MARG24(varargin)
            matlabshared.fusionutils.internal.setProperties(obj, nargin, varargin{:});
            
            % Set the state if the user specifies it, to ensure the initial
            % value is correct, regardless of the reference frame.
            for i = 1:2:numel(varargin)-1
                if strcmp(varargin{i}, 'State')
                    obj.State = varargin{i+1};
                end
            end
            
            obj.pGyroInteg = fusion.internal.TrapezoidalIntegrator(...
                'InitialValue', [0 0 0]);
            rf = rfconfig(obj.ReferenceFrame);
            grav = zeros(1,3);
            grav(rf.GravityIndex) = -rf.GravitySign*rf.GravityAxisSign*gravms2();
            obj.pAccelInteg = fusion.internal.TrapezoidalIntegrator(...
                'InitialValue', grav);
        end    
    end
    
    methods % Public API
        function predict(obj, accFrame, gyroFrame)
        %PREDICT predict forward state estimates
        %   predict(FUSE, ACC, GYRO) fuses accelerometer and gyroscope
        %   data to update the state estimate. The inputs are: 
        %
        %       FUSE    - insfilterMARG object
        %       ACC     - N-by-3 matrix of accelerometer readings in m/s^2 
        %       GYRO    - N-by-3 matrix of gyroscope readings in rad/s
        
            validateattributes(accFrame, {'double', 'single'}, ...
                {'2d', 'ncols', 3, 'nonempty', 'real'}, '', ...
                'acceleration');
            validateattributes(gyroFrame, {'double', 'single'}, ...
                {'2d', 'ncols', 3, 'nonempty', 'real'}, '', ...
                'angularVelocity');
            n = size(accFrame,1);
            coder.internal.assert(size(gyroFrame,1) == n, ...
                'shared_positioning:insfilter:RowMismatch');
          
            rf = rfconfig(obj.ReferenceFrame);
            % Invert the accelerometer signal if linear acceleration is
            % negative in the reference frame.
            accFrame = rf.LinAccelSign.*accFrame; 
            xk = obj.State;
            dt = 1./obj.IMUSampleRate;
            P = obj.StateCovariance;
            
            addProcNoise = additiveProcessNoiseFcn(obj);
            multNoise = procNoiseCov(obj);
            for ii=1:n
                accel = accFrame(ii,:);
                gyro = gyroFrame(ii,:);
              
                dang = integrateGyro(obj, gyro);
                dvel = integrateAccel(obj, accel);
                % Extended Kalman Filter predict algorithm
                
                xnext = obj.stateTransFcn(xk, dang, dvel, dt);
                dfdx = obj.stateTransJacobianFcn(xk, dang, dvel, dt);
                dwdx = obj.processNoiseJacobianFcn(xk, multNoise);
                Pnext = dfdx * P * (dfdx.') + dwdx  + addProcNoise;
                    
                xk = xnext;
                P = Pnext;
            end
            obj.StateCovariance = P;
            obj.State = xk;
        end
        
        
        function [res, resCov] = residualgps(obj, gpsPos, RposIn, vel, RvelIn)
        %RESIDUALGPS Residuals and residual covariance from GPS 
        %   [RES, RESCOV] = residualgps(FUSE, LLA, RPOS) uses GPS position
        %   data to compute residuals and residual covariance.
        %
        %   [RES, RESCOV] = residualgps(FUSE, LLA, RPOS, VEL, RVEL) uses
        %   GPS position and velocity data to compute residuals and
        %   residual covariance. The inputs are:
        %       
        %       FUSE    - insfilterMARG object
        %       LLA     - 1-by-3 vector of latitude, longitude and altitude 
        %       RPOS    - scalar, 1-by-3, or 3-by-3 covariance of the
        %                 NAV position measurement error in m^2
        %       VEL     - 1-by-3 vector of NAV velocities in units of m/s
        %       RVEL    - scalar, 1-by-3, or 3-by-3 covariance of the
        %                 NAV velocity measurement error in (m/s)^2
        %
        %   The outputs are:
        %       RES            - 1-by-6 position and velocity residuals in 
        %                        meters (m) and m/s, respectively
        %       RESCOV         - 6-by-6 residual covariance
        %
        %   Example:
        %
        %       % Reject measurements that have a normalized residual above
        %       % a specified threshold.
        %       outlierThreshold = 3;
        %       filt = insfilterMARG;
        %       llaMeas = [1 1 1];
        %       Rlla = 0.1;
        %       velMeas = [1 1 1];
        %       Rvel = 0.1;
        %       [res, resCov] = residualgps(filt, llaMeas, Rlla, ...
        %           velMeas, Rvel);
        %       normRes = res ./ sqrt( diag(resCov).' );
        %       if all(abs(normRes) <= outlierThreshold)
        %           fusegps(filt, llaMeas, Rlla, velMeas, Rvel);
        %       else
        %           fprintf('Outlier detected and disregarded.\n');
        %       end
        %
        %   See also fusegps.
        
            validateMeasurement(gpsPos, 'latitude-longitude-altitude');
            Rpos = validateExpandNoise(obj, RposIn, 3, 'Rpos');
            if (nargin == 3)
                
                x = obj.State;
                
                rf = rfconfig(obj.ReferenceFrame);
                z = rf.lla2frame(gpsPos, obj.ReferenceLocation).';
                h = measurementGPSPosition(obj, x);
                H = measurementJacobianGPSPosition(obj, x);
                
                [res, resCov] = privInnov(obj, obj.StateCovariance, ...
                    h, H, z, Rpos);
            else
                validateattributes(vel, {'double', 'single'}, ...
                    {'2d', 'ncols', 3, 'nrows', 1, 'nonempty', 'real'}, '', ...
                    'velocity');

                Rvel = obj.validateExpandNoise(RvelIn,  3, ...
                    'Rvel');

                x = obj.State;
                
                measNoise = blkdiag(Rpos, Rvel);
                rf = rfconfig(obj.ReferenceFrame);
                pos = rf.lla2frame(gpsPos, obj.ReferenceLocation);            
                z = [pos, vel].';
                h = gpsMeasFcn(obj, x);
                H = gpsMeasJacobianFcn(obj, x);
                
                [res, resCov] = privInnov(obj, obj.StateCovariance, ...
                    h, H, z, measNoise);
            end
        end
        
        function [res, resCov] = fusegps(obj, lla, Rpos, vel, Rvel)
        %FUSEGPS Correct state estimates using GPS 
        %   [RES, RESCOV] = fusegps(FUSE, LLA, RPOS) fuses GPS position
        %   data to correct the state estimate.
        %
        %   [RES, RESCOV] = fusegps(FUSE, LLA, RPOS, VEL, RVEL)
        %   fuses GPS position and velocity data to correct the state 
        %   estimate. The inputs are:
        %       
        %       FUSE    - insfilterMARG object
        %       LLA     - 1-by-3 vector of latitude, longitude and altitude 
        %       RPOS    - scalar, 1-by-3, or 3-by-3 covariance of the
        %                 NAV position measurement error in m^2
        %       VEL     - 1-by-3 vector of NAV velocities in units of m/s
        %       RVEL    - scalar, 1-by-3, or 3-by-3 covariance of the
        %                 NAV velocity measurement error in (m/s)^2
        %
        %   The outputs are:
        %       RES              - 1-by-6 position and velocity residuals
        %                          in meters (m) and m/s, respectively
        %       RESCOV           - 6-by-6 residual covariance
        %
        %   See also residualgps.

            validateMeasurement(lla, 'latitude-longitude-altitude');
            Rposmat = obj.validateExpandNoise(Rpos,  3, ...
                'Rpos'); 
            if (nargin == 3)
                [res, resCov] = fusegpsPosition(obj, lla, Rposmat);
            else
                validateattributes(vel, {'double', 'single'}, ...
                    {'2d', 'ncols', 3, 'nrows', 1, 'nonempty', 'real'}, '', ...
                    'velocity');

                Rvelmat = obj.validateExpandNoise(Rvel,  3, ...
                    'Rvel'); 

                measNoise = blkdiag(Rposmat, Rvelmat);
                rf = rfconfig(obj.ReferenceFrame);
                pos = rf.lla2frame(lla, obj.ReferenceLocation);            
                z = [pos, vel].';
                [res, resCov] = basicCorrect(obj, z, @gpsMeasFcn, measNoise, ...
                    @gpsMeasJacobianFcn);

            end
        end
        
        function [res, resCov] = residualmag(obj, mag, Rmag)
        %RESIDUALMAG Residuals and residual covariance from magnetometer
        %   [RES, RESCOV] = residualmag(FUSE, MAG, RMAG) uses magnetometer
        %   data to compute residuals and residual covariance. The inputs
        %   are:
        %       
        %       FUSE      - insfilterMARG object
        %       MAG       - 1-by-3 vector of magnetic field measurements
        %                   in uT. 
        %       RMAG      - scalar, 1-by-3, or 3-by-3 covariance of the
        %                   magnetometer measurement error in uT^2
        %
        %   The outputs are:
        %       RES       - 1-by-3 residuals in uT
        %       RESCOV    - 3-by-3 residual covariance
        %
        %   Example:
        %
        %       % Reject measurements that have a normalized residual above
        %       % a specified threshold.
        %       outlierThreshold = 3;
        %       filt = insfilterMARG;
        %       meas = [0 0 0];
        %       R = 0.1;
        %       [res, resCov] = residualmag(filt, meas, R);
        %       normRes = res ./ sqrt( diag(resCov).' );
        %       if all(abs(normRes) <= outlierThreshold)
        %           fusemag(filt, meas, R);
        %       else
        %           fprintf('Outlier detected and disregarded.\n');
        %       end
        %
        %   See also fusemag.
        
            validateattributes(mag, {'double', 'single'}, ...
                {'2d', 'ncols', 3, 'nrows', 1, 'nonempty', 'real'}, '', ...
                'magneticField');
            
            Rmagmat = obj.validateExpandNoise(Rmag, 3, ...
                'Rmag');
            
            z = mag(:);
            
            x = obj.State;
            
            [res, resCov] = privInnov(obj, obj.StateCovariance, ...
                magMeasFcn(obj, x), magMeasJacobianFcn(obj, x), z, Rmagmat);
            
        end

        function [res, resCov] = fusemag(obj, mag, Rmag)
        %FUSEMAG Correct state estimates using magnetometer
        %   [RES, RESCOV] = fusemag(FUSE, MAG, RMAG) fuses magnetometer
        %   data to correct the state estimate. The inputs are:
        %       
        %       FUSE      - insfilterMARG object
        %       MAG       - 1-by-3 vector of magnetic field measurements
        %                   in uT. 
        %       RMAG      - scalar, 1-by-3, or 3-by-3 covariance of the
        %                   magnetometer measurement error in uT^2
        %
        %   The outputs are:
        %       RES             - 1-by-3 residuals in uT
        %       RESCOV          - 3-by-3 residual covariance
        %
        %   See also residualmag.

            validateattributes(mag, {'double', 'single'}, ...
                {'2d', 'ncols', 3, 'nrows', 1, 'nonempty', 'real'}, '', ...
                'magneticField');

            Rmagmat = obj.validateExpandNoise(Rmag, 3, ...
                'Rmag'); 

           z = mag(:);
           [res, resCov] = basicCorrect(obj, z, @magMeasFcn, Rmagmat, ...
                @magMeasJacobianFcn);
        end
        
        function [res, resCov] = fuseTAS(obj, tas, Rtas)
        %FUSETAS Correct state estimates using Airspeed beam
        %   [RES, RESCOV] = fuseTAS(FUSE, MAG, RMAG) fuses TAS
        %   data to correct the state estimate. The inputs are:
        %       
        %       FUSE      - insfilterMARG object
        %       TAS       - 1-by-1 vector of TAS
        %                   in m/s. 
        %       RTAS      - scalar, 1-by-1 covariance of the
        %                   TAS measurement error in (m/s)^2
        %
        %   The outputs are:
        %       RES             - 1-by-1 residuals in m/s
        %       RESCOV          - 1-by-1 residual covariance
        %
        %   See also residualmag.

            validateattributes(tas, {'double', 'single'}, ...
                {'2d', 'ncols', 1, 'nrows', 1, 'nonempty', 'real'}, '', ...
                'magneticField');

            Rtasmat = obj.validateExpandNoise(Rtas, 1, ...
                'Rmag'); 

           z = tas(:);
           [res, resCov] = basicCorrect(obj, z, @tasMeasFcn, Rtasmat, ...
                @tasMeasJacobianFcn);
        end        
        
        function reset(obj)
        %RESET reset the internal states
        %   RESET(FUSE) resets the State, StateCovariance, and internal
        %   integrators to their default values.

            obj.privReset;
        end
        
        function stateinfo(obj) %#ok<MANU>
        %STATEINFO Display state vector information
        %   STATEINFO(FUSE) displays the meaning of each index of the State 
        %   property and the associated units. 

            stateCellArr = {'States', 'Orientation (quaternion parts)', ...
                'Position (NAV)', 'Velocity (NAV)', ...
                'Delta Angle Bias (XYZ)' 'Delta Velocity Bias (XYZ)', ...
                'Geomagnetic Field Vector (NAV)', 'Magnetometer Bias (XYZ)',...
                'Wind speed (NE)'};
            uT = [char(181) 'T'];
            unitCellArr = {'Units', '', 'm', 'm/s', 'rad', 'm/s', uT, uT, 'm/s'};
            indexCellArr = {'Index', '1:4', '5:7', '8:10', '11:13', ...
                '14:16', '17:19', '20:22','23:24'};
            
            states = char(stateCellArr(:));
            units = char(unitCellArr(:));
            indices = char(indexCellArr(:));
            spaces = repmat('    ',size(states, 1), 1);
            infoStr = [states, spaces, units, spaces, indices];
            
            fprintf('\n');
            for i = 1:size(infoStr, 1)
                fprintf(infoStr(i,:));
                fprintf('\n');
            end
            fprintf('\n');
        end
    end

    methods % Public API - sets and gets
       function set.GyroscopeNoise(obj,val)
            validateattributes(val, {'numeric'}, ...
                {'finite', 'real', 'positive', '2d', ...
                'nonnan', 'nonempty', 'nonsparse'}, ...
                '', 'GyroscopeNoise' );
           
            % Enforce scalar or 3-element vector inputs.
            n = numel(val);
            coder.internal.assert((n == 1) || (n == 3), ... 
                'shared_positioning:insfilter:OneorThreeElements', 'GyroscopeNoise');

            obj.GyroscopeNoise(:) = val(:).';
       end

       function set.AccelerometerNoise(obj,val)
            validateattributes(val, {'numeric'}, ...
                {'finite', 'real', 'positive', '2d', ...
                'nonnan', 'nonempty', 'nonsparse'}, ...
                '', 'AccelerometerNoise' );
           
            % Enforce scalar or 3-element vector inputs.
            n = numel(val);
            coder.internal.assert((n == 1) || (n == 3), ... 
                'shared_positioning:insfilter:OneorThreeElements', 'AccelerometerNoise');

            obj.AccelerometerNoise(:) = val(:).';
       end

       function set.GyroscopeBiasNoise(obj,val)
            validateattributes(val, {'numeric'}, ...
                {'finite', 'real', 'positive', '2d', ...
                'nonnan', 'nonempty', 'nonsparse'}, ...
                '', 'GyroscopeBiasNoise' );
           
            % Enforce scalar or 3-element vector inputs.
            n = numel(val);
            coder.internal.assert((n == 1) || (n == 3), ... 
                'shared_positioning:insfilter:OneorThreeElements', 'GyroscopeBiasNoise');

            obj.GyroscopeBiasNoise(:) = val(:).';
       end

       function set.AccelerometerBiasNoise(obj,val)
            validateattributes(val, {'numeric'}, ...
                {'finite', 'real', 'positive', '2d', ...
                'nonnan', 'nonempty', 'nonsparse'}, ...
                '', 'AccelerometerBiasNoise' );
           
            % Enforce scalar or 3-element vector inputs.
            n = numel(val);
            coder.internal.assert((n == 1) || (n == 3), ... 
                'shared_positioning:insfilter:OneorThreeElements', 'AccelerometerBiasNoise');

            obj.AccelerometerBiasNoise(:) = val(:).';
       end

       function set.GeomagneticVectorNoise(obj,val)
            validateattributes(val, {'numeric'}, ...
                {'finite', 'real', 'positive', '2d', ...
                'nonnan', 'nonempty', 'nonsparse'}, ...
                '', 'GeomagneticVectorNoise' );
           
            % Enforce scalar or 3-element vector inputs.
            n = numel(val);
            coder.internal.assert((n == 1) || (n == 3), ... 
                'shared_positioning:insfilter:OneorThreeElements', 'GeomagneticVectorNoise');

            obj.GeomagneticVectorNoise(:) = val(:).';
       end

       function set.MagnetometerBiasNoise(obj,val)
            validateattributes(val, {'numeric'}, ...
                {'finite', 'real', 'positive', '2d', ...
                'nonnan', 'nonempty', 'nonsparse'}, ...
                '', 'MagnetometerBiasNoise' );
           
            % Enforce scalar or 3-element vector inputs.
            n = numel(val);
            coder.internal.assert((n == 1) || (n == 3), ... 
                'shared_positioning:insfilter:OneorThreeElements', 'MagnetometerBiasNoise');

            obj.MagnetometerBiasNoise(:) = val(:).';
       end
       % SLASSDDD
       function set.WindspeedNoise(obj,val)
            validateattributes(val, {'numeric'}, ...
                {'finite', 'real', 'positive', '2d', ...
                'nonnan', 'nonempty', 'nonsparse'}, ...
                '', 'MagnetometerBiasNoise' );
           
            % Enforce scalar or 2-element vector inputs.
            n = numel(val);
            coder.internal.assert((n == 1) || (n == 2), ... 
                'shared_positioning:insfilter:OneorThreeElements', 'MagnetometerBiasNoise');

            obj.WindspeedNoise(:) = val(:).';
       end
       
       function val = get.State(obj)
           rf = rfconfig(obj.ReferenceFrame);
           val = obj.pState;
           mfIdx = obj.MAG_FIELD_INDEX;
           val(mfIdx+2) = -rf.ZAxisUpSign*val(mfIdx+2);
           magN = val(mfIdx);
           magE = val(mfIdx+1);
           val((mfIdx-1)+rf.NorthIndex) = magN;
           val((mfIdx-1)+rf.EastIndex) = magE;
       end
       
       function set.State(obj, val)
           validateattributes(val, {'numeric'}, ...
               {'finite', 'real', 'vector', ...
               'numel', 24, ...
               'nonnan', 'nonempty', 'nonsparse'}, ...
               '', 'State' );
           rf = rfconfig(obj.ReferenceFrame);
           mfIdx = obj.MAG_FIELD_INDEX;
           val(mfIdx+2) = -rf.ZAxisUpSign*val(mfIdx+2);
           magX = val(mfIdx);
           magY = val(mfIdx+1);
           val((mfIdx-1)+rf.NorthIndex) = magX;
           val((mfIdx-1)+rf.EastIndex) = magY;
           obj.pState = val(:);
       end
       
       function set.StateCovariance(obj, val)
            validateattributes(val, {'numeric'}, ...
               {'finite', 'real', '2d', ...
               'ncols', 24, 'nrows', 24 ...
               'nonnan', 'nonempty', 'nonsparse'}, ...
               '', 'StateCovariance' );
            obj.StateCovariance = val;
       end
        
    end
    
    methods (Access = protected)
        function orient = getOrientation(obj)
            orient = quaternion(obj.State(1:4).');
        end
        
        function pos = getPosition(obj)
            pos = obj.State(5:7).';
        end

        function vel = getVelocity(obj)
            vel = obj.State(8:10).';
        end
        
        function dang = integrateGyro(obj, gyro)
        % Gyroscope integration to delta angles
            dang = obj.pGyroInteg(gyro, obj.IMUSampleRate);
        end
        
        function dvel = integrateAccel(obj, acc)
        % Accelerometer integration to delta velocity
            dvel = obj.pAccelInteg(acc, obj.IMUSampleRate);      
        end
    
        function privReset(obj)
            % Reset private and public states
            obj.State = defaultState(obj.ReferenceFrame);
            obj.StateCovariance = defaultCov();
            reset(obj.pGyroInteg);
            reset(obj.pAccelInteg);
        end
        
        function w = procNoiseCov(obj)
            % Process Noises
            w = 0.5*(1./obj.IMUSampleRate.^2).* ...
                [obj.GyroscopeNoise, obj.AccelerometerNoise];
        end
        
        function Qs = additiveProcessNoiseFcn(obj)
            % Additive process noise used to compute StateErrorCovariance in
            % predict. 

            scale = 0.5*(1./obj.IMUSampleRate.^2); 
            dAngBiasSigma = scale .* obj.GyroscopeBiasNoise; 
            dVelBiasSigma = scale .* obj.AccelerometerBiasNoise; 
            
            magEarthSigma = obj.GeomagneticVectorNoise;
            magBodySigma  = obj.MagnetometerBiasNoise;
            windSpeedSigma = obj.WindspeedNoise;
            
            Qs = diag([obj.OtherAdditiveNoise.*ones(1,10), dAngBiasSigma, dVelBiasSigma,  magEarthSigma, magBodySigma, windSpeedSigma]);
        end

        function [innov, iCov] = basicCorrect(obj, z, measFcn, measNoise, measJacobianFcn)
            % Basic EKF correct 

            xk = obj.State;
            h = measFcn(obj, xk);
            dhdx = measJacobianFcn(obj, xk);
            P = obj.StateCovariance;
            [xest, P, innov, iCov] = correctEqn(obj, xk, P, h, dhdx, z, measNoise);
            % SLASSDDD
            for i = [14,15,16]
                maxdV = 4; % m/s
                if i == 14
                    maxdV = 2;
                end
                limits = maxdV/obj.IMUSampleRate;
                xest(i) = min(limits,xest(i)); % 设定上限
                xest(i) = max(-limits,xest(i)); % 设定下限
            end
            % 
            obj.StateCovariance = P;
            obj.State = xest;             
        end

        function x = stateTransFcn(obj, x, dang, dvel, dt)
        %STATETRANSFCN new filter states based on current and IMU data
        %   Predict forward the state estimate one time sample, based on control
        %   inputs : 
        %       new delta angles (integrated gyroscope readings), and 
        %       new delta velocities (integrated accelerometer readings).

            q0 = x(1);
            q1 = x(2);
            q2 = x(3);
            q3 = x(4);    
            pn = x(5);
            pe = x(6);
            pd = x(7);
            vn = x(8);
            ve = x(9);
            vd = x(10);
            dax_b = x(11);
            day_b = x(12);
            daz_b = x(13);
            dvx_b = x(14);
            dvy_b = x(15);
            dvz_b = x(16);
            magNavX = x(17);
            magNavY = x(18);
            magNavZ = x(19);
            magX = x(20);
            magY = x(21);
            magZ = x(22);
            
            rf = rfconfig(obj.ReferenceFrame);
            grav = zeros(1,3, 'like', dvel);
            grav(rf.GravityIndex) = rf.GravitySign*rf.GravityAxisSign*gravms2();
            gnavx = grav(1);
            gnavy = grav(2);
            gnavz = grav(3);

            dvx = dvel(1);
            dvy = dvel(2);
            dvz = dvel(3);
            
            % State update equation
            % Orientation is updated below. This line updates, velocity, position,
            % sensor biases and the geomagnetic vector.
            %
            % x(1:4) - pre-allocated placeholders of the current quaternion parts.
            %
            % x(5:7) - position update equation. The new position is 
            %    the current position + the effect of current velocity
            %
            % x(8:10) - velocity update equation. The new velocity is 
            %    the current velocity + the gravity vector's effect +
            %        (current delta velocity - delta velocity sensor bias), rotated
            %        to the global frame 
            %
            % x(11:22) - the new delta angle bias, delta velocity bias, geomagnetic field vector,
            %    and magnetometer bias are the same as the current estimate.
            %
            % In all of the above, a "plus white noise" is assumed by the Extended
            % Kalman Filter formulation. So, for example, the new delta angle bias
            % is the previous delta angle bias plus white noise.
            %
           
%             %WISH change the velocity equations to use rotateframe(q, dvel - dvelbias)
%             x = [
%                 q0 % preallocate
%                 q1 % preallocate
%                 q2 % preallocate
%                 q3 % preallocate
%                 pn + dt*vn
%                 pe + dt*ve
%                 pd + dt*vd
%                 vn + dt*gnavx + (dvx - dvx_b)*(q0^2 + q1^2 - q2^2 - q3^2) - (dvy - dvy_b)*(2*q0*q3 - 2*q1*q2) + (dvz - dvz_b)*(2*q0*q2 + 2*q1*q3)
%                 ve + dt*gnavy + (dvy - dvy_b)*(q0^2 - q1^2 + q2^2 - q3^2) + (dvx - dvx_b)*(2*q0*q3 + 2*q1*q2) - (dvz - dvz_b)*(2*q0*q1 - 2*q2*q3)
%                 vd + dt*gnavz + (dvz - dvz_b)*(q0^2 - q1^2 - q2^2 + q3^2) - (dvx - dvx_b)*(2*q0*q2 - 2*q1*q3) + (dvy - dvy_b)*(2*q0*q1 + 2*q2*q3)
%                 dax_b
%                 day_b
%                 daz_b
%                 dvx_b
%                 dvy_b
%                 dvz_b
%                 magNavX
%                 magNavY
%                 magNavZ
%                 magX
%                 magY
%                 magZ];
%             
%             % Compute x(1:4) using quaternion math.
%             %   Subtract the delta angle bias from the delta angle. Treat the
%             %   corrected delta angle as a rotation vector. Convert the rotation
%             %   vector to a quaternion and compute an updated orientation, forcing
%             %   the result to be a unit quaternion with a positive angle of
%             %   rotation.
%             qinit = quaternion(q0,q1,q2,q3);
%             x(1:4) = compact(normalize(posangle(qinit * quaternion(dang - [dax_b, day_b, daz_b], 'rotvec')))); 
%             %% 对比x和xx的结果一致性
%             dax = dang(1);
%             day = dang(2);
%             daz = dang(3);
%             xx = [q0 - q1*(dax/2 - dax_b/2) - q2*(day/2 - day_b/2) - q3*(daz/2 - daz_b/2);
%                   q1 + q0*(dax/2 - dax_b/2) - q3*(day/2 - day_b/2) + q2*(daz/2 - daz_b/2);
%                   q2 + q3*(dax/2 - dax_b/2) + q0*(day/2 - day_b/2) - q1*(daz/2 - daz_b/2);
%                   q3 - q2*(dax/2 - dax_b/2) + q1*(day/2 - day_b/2) + q0*(daz/2 - daz_b/2);];
%               
            %% SLASSDDD
            dax = dang(1);
            day = dang(2);
            daz = dang(3);    
            vwn = x(23);
            vwe = x(24);
            x = [...
                q0 - q1*(dax/2 - dax_b/2) - q2*(day/2 - day_b/2) - q3*(daz/2 - daz_b/2)
                q1 + q0*(dax/2 - dax_b/2) - q3*(day/2 - day_b/2) + q2*(daz/2 - daz_b/2)
                q2 + q3*(dax/2 - dax_b/2) + q0*(day/2 - day_b/2) - q1*(daz/2 - daz_b/2)
                q3 - q2*(dax/2 - dax_b/2) + q1*(day/2 - day_b/2) + q0*(daz/2 - daz_b/2)
                pn + dt*vn
                pe + dt*ve
                pd + dt*vd
                vn + dt*gnavx + (dvx - dvx_b)*(q0^2 + q1^2 - q2^2 - q3^2) - (dvy - dvy_b)*(2*q0*q3 - 2*q1*q2) + (dvz - dvz_b)*(2*q0*q2 + 2*q1*q3)
                ve + dt*gnavy + (dvy - dvy_b)*(q0^2 - q1^2 + q2^2 - q3^2) + (dvx - dvx_b)*(2*q0*q3 + 2*q1*q2) - (dvz - dvz_b)*(2*q0*q1 - 2*q2*q3)
                vd + dt*gnavz + (dvz - dvz_b)*(q0^2 - q1^2 - q2^2 + q3^2) - (dvx - dvx_b)*(2*q0*q2 - 2*q1*q3) + (dvy - dvy_b)*(2*q0*q1 + 2*q2*q3)
                dax_b
                day_b
                daz_b
                dvx_b
                dvy_b
                dvz_b
                magNavX
                magNavY
                magNavZ
                magX
                magY
                magZ
                vwn
                vwe];
        end

        function dfdx = stateTransJacobianFcn(obj, x, dang, dvel, dt) %#ok<INUSL>
        % STATETRANSJACOBIANFCN Jacobian of process equations
        %   Compute the Jacobian matrix dfdx of the state transition function f(x)
        %   with respect to state x.

            q0 = x(1);
            q1 = x(2);
            q2 = x(3);
            q3 = x(4);
            dax_b = x(11);
            day_b = x(12);
            daz_b = x(13);
            dvx_b = x(14);
            dvy_b = x(15);
            dvz_b = x(16);
            
            
            dax = dang(1);
            day = dang(2);
            daz = dang(3);
            
            dvx = dvel(1);
            dvy = dvel(2);
            dvz = dvel(3);
            
            % The matrix here is the Jacobian of the equations in stateTransFcn(). 
            % The orientation quaternion update portion uses an approximation of
            % the quaternion incremental rotation update equation. The state
            % equation of the quaternion update (ignoring positive angle and
            % normalization requirements) is 
            %   q_next = q_current * q_increment
            %
            %   where q_increment = quaternion( deltaAngle, 'rotvec')
            %
            % A quaternion is computed from a rotation vector as :
            %   q = (cos(ang)^2 + sin(ang)^2 *( ax(1) *i + ax(2)*j + ax(3)*k)
            % for axis 1-by-3 axis 'ax' and angle of rotation 'ang'.
            %
            % Using a small angle approximation, 
            %   cos(ang)^2 == 1
            % Using the Maclaurin expansion and truncating after the first term:
            %   sin(ang)^2 * ax(n) == 1/2 * ax(n)
            % So the rotation vector to quaternion approximation used in the
            % Jacobian calculation below is:
            %   q_increment = quaternion(0, ax(1)/2, ax(2)/2, ax(3)/2)
            
            
%             dfdx = [...
%                                                             1,                                              dax_b/2 - dax/2,                                              day_b/2 - day/2,                                              daz_b/2 - daz/2, 0, 0, 0,  0,  0,  0,  q1/2,  q2/2,  q3/2,                           0,                           0,                           0, 0, 0, 0, 0, 0, 0
%                                                    dax/2 - dax_b/2,                                                            1,                                              daz/2 - daz_b/2,                                              day_b/2 - day/2, 0, 0, 0,  0,  0,  0, -q0/2,  q3/2, -q2/2,                           0,                           0,                           0, 0, 0, 0, 0, 0, 0
%                                                    day/2 - day_b/2,                                              daz_b/2 - daz/2,                                                            1,                                              dax/2 - dax_b/2, 0, 0, 0,  0,  0,  0, -q3/2, -q0/2,  q1/2,                           0,                           0,                           0, 0, 0, 0, 0, 0, 0
%                                                    daz/2 - daz_b/2,                                              day/2 - day_b/2,                                              dax_b/2 - dax/2,                                                            1, 0, 0, 0,  0,  0,  0,  q2/2, -q1/2, -q0/2,                           0,                           0,                           0, 0, 0, 0, 0, 0, 0
%                                                                  0,                                                            0,                                                            0,                                                            0, 1, 0, 0, dt,  0,  0,     0,     0,     0,                           0,                           0,                           0, 0, 0, 0, 0, 0, 0
%                                                                  0,                                                            0,                                                            0,                                                            0, 0, 1, 0,  0, dt,  0,     0,     0,     0,                           0,                           0,                           0, 0, 0, 0, 0, 0, 0
%                                                                  0,                                                            0,                                                            0,                                                            0, 0, 0, 1,  0,  0, dt,     0,     0,     0,                           0,                           0,                           0, 0, 0, 0, 0, 0, 0
%       2*q0*(dvx - dvx_b) - 2*q3*(dvy - dvy_b) + 2*q2*(dvz - dvz_b), 2*q1*(dvx - dvx_b) + 2*q2*(dvy - dvy_b) + 2*q3*(dvz - dvz_b), 2*q1*(dvy - dvy_b) - 2*q2*(dvx - dvx_b) + 2*q0*(dvz - dvz_b), 2*q1*(dvz - dvz_b) - 2*q0*(dvy - dvy_b) - 2*q3*(dvx - dvx_b), 0, 0, 0,  1,  0,  0,     0,     0,     0, - q0^2 - q1^2 + q2^2 + q3^2,           2*q0*q3 - 2*q1*q2,         - 2*q0*q2 - 2*q1*q3, 0, 0, 0, 0, 0, 0
%       2*q3*(dvx - dvx_b) + 2*q0*(dvy - dvy_b) - 2*q1*(dvz - dvz_b), 2*q2*(dvx - dvx_b) - 2*q1*(dvy - dvy_b) - 2*q0*(dvz - dvz_b), 2*q1*(dvx - dvx_b) + 2*q2*(dvy - dvy_b) + 2*q3*(dvz - dvz_b), 2*q0*(dvx - dvx_b) - 2*q3*(dvy - dvy_b) + 2*q2*(dvz - dvz_b), 0, 0, 0,  0,  1,  0,     0,     0,     0,         - 2*q0*q3 - 2*q1*q2, - q0^2 + q1^2 - q2^2 + q3^2,           2*q0*q1 - 2*q2*q3, 0, 0, 0, 0, 0, 0
%       2*q1*(dvy - dvy_b) - 2*q2*(dvx - dvx_b) + 2*q0*(dvz - dvz_b), 2*q3*(dvx - dvx_b) + 2*q0*(dvy - dvy_b) - 2*q1*(dvz - dvz_b), 2*q3*(dvy - dvy_b) - 2*q0*(dvx - dvx_b) - 2*q2*(dvz - dvz_b), 2*q1*(dvx - dvx_b) + 2*q2*(dvy - dvy_b) + 2*q3*(dvz - dvz_b), 0, 0, 0,  0,  0,  1,     0,     0,     0,           2*q0*q2 - 2*q1*q3,         - 2*q0*q1 - 2*q2*q3, - q0^2 + q1^2 + q2^2 - q3^2, 0, 0, 0, 0, 0, 0
%                                                                  0,                                                            0,                                                            0,                                                            0, 0, 0, 0,  0,  0,  0,     1,     0,     0,                           0,                           0,                           0, 0, 0, 0, 0, 0, 0
%                                                                  0,                                                            0,                                                            0,                                                            0, 0, 0, 0,  0,  0,  0,     0,     1,     0,                           0,                           0,                           0, 0, 0, 0, 0, 0, 0
%                                                                  0,                                                            0,                                                            0,                                                            0, 0, 0, 0,  0,  0,  0,     0,     0,     1,                           0,                           0,                           0, 0, 0, 0, 0, 0, 0
%                                                                  0,                                                            0,                                                            0,                                                            0, 0, 0, 0,  0,  0,  0,     0,     0,     0,                           1,                           0,                           0, 0, 0, 0, 0, 0, 0
%                                                                  0,                                                            0,                                                            0,                                                            0, 0, 0, 0,  0,  0,  0,     0,     0,     0,                           0,                           1,                           0, 0, 0, 0, 0, 0, 0
%                                                                  0,                                                            0,                                                            0,                                                            0, 0, 0, 0,  0,  0,  0,     0,     0,     0,                           0,                           0,                           1, 0, 0, 0, 0, 0, 0
%                                                                  0,                                                            0,                                                            0,                                                            0, 0, 0, 0,  0,  0,  0,     0,     0,     0,                           0,                           0,                           0, 1, 0, 0, 0, 0, 0
%                                                                  0,                                                            0,                                                            0,                                                            0, 0, 0, 0,  0,  0,  0,     0,     0,     0,                           0,                           0,                           0, 0, 1, 0, 0, 0, 0
%                                                                  0,                                                            0,                                                            0,                                                            0, 0, 0, 0,  0,  0,  0,     0,     0,     0,                           0,                           0,                           0, 0, 0, 1, 0, 0, 0
%                                                                  0,                                                            0,                                                            0,                                                            0, 0, 0, 0,  0,  0,  0,     0,     0,     0,                           0,                           0,                           0, 0, 0, 0, 1, 0, 0
%                                                                  0,                                                            0,                                                            0,                                                            0, 0, 0, 0,  0,  0,  0,     0,     0,     0,                           0,                           0,                           0, 0, 0, 0, 0, 1, 0
%                                                                  0,                                                            0,                                                            0,                                                            0, 0, 0, 0,  0,  0,  0,     0,     0,     0,                           0,                           0,                           0, 0, 0, 0, 0, 0, 1];
%          
            dfdx = [...
                [                                                            1,                                              dax_b/2 - dax/2,                                              day_b/2 - day/2,                                              daz_b/2 - daz/2, 0, 0, 0,  0,  0,  0,  q1/2,  q2/2,  q3/2,                           0,                           0,                           0, 0, 0, 0, 0, 0, 0, 0, 0]
                [                                              dax/2 - dax_b/2,                                                            1,                                              daz/2 - daz_b/2,                                              day_b/2 - day/2, 0, 0, 0,  0,  0,  0, -q0/2,  q3/2, -q2/2,                           0,                           0,                           0, 0, 0, 0, 0, 0, 0, 0, 0]
                [                                              day/2 - day_b/2,                                              daz_b/2 - daz/2,                                                            1,                                              dax/2 - dax_b/2, 0, 0, 0,  0,  0,  0, -q3/2, -q0/2,  q1/2,                           0,                           0,                           0, 0, 0, 0, 0, 0, 0, 0, 0]
                [                                              daz/2 - daz_b/2,                                              day/2 - day_b/2,                                              dax_b/2 - dax/2,                                                            1, 0, 0, 0,  0,  0,  0,  q2/2, -q1/2, -q0/2,                           0,                           0,                           0, 0, 0, 0, 0, 0, 0, 0, 0]
                [                                                            0,                                                            0,                                                            0,                                                            0, 1, 0, 0, dt,  0,  0,     0,     0,     0,                           0,                           0,                           0, 0, 0, 0, 0, 0, 0, 0, 0]
                [                                                            0,                                                            0,                                                            0,                                                            0, 0, 1, 0,  0, dt,  0,     0,     0,     0,                           0,                           0,                           0, 0, 0, 0, 0, 0, 0, 0, 0]
                [                                                            0,                                                            0,                                                            0,                                                            0, 0, 0, 1,  0,  0, dt,     0,     0,     0,                           0,                           0,                           0, 0, 0, 0, 0, 0, 0, 0, 0]
                [ 2*q0*(dvx - dvx_b) - 2*q3*(dvy - dvy_b) + 2*q2*(dvz - dvz_b), 2*q1*(dvx - dvx_b) + 2*q2*(dvy - dvy_b) + 2*q3*(dvz - dvz_b), 2*q1*(dvy - dvy_b) - 2*q2*(dvx - dvx_b) + 2*q0*(dvz - dvz_b), 2*q1*(dvz - dvz_b) - 2*q0*(dvy - dvy_b) - 2*q3*(dvx - dvx_b), 0, 0, 0,  1,  0,  0,     0,     0,     0, - q0^2 - q1^2 + q2^2 + q3^2,           2*q0*q3 - 2*q1*q2,         - 2*q0*q2 - 2*q1*q3, 0, 0, 0, 0, 0, 0, 0, 0]
                [ 2*q3*(dvx - dvx_b) + 2*q0*(dvy - dvy_b) - 2*q1*(dvz - dvz_b), 2*q2*(dvx - dvx_b) - 2*q1*(dvy - dvy_b) - 2*q0*(dvz - dvz_b), 2*q1*(dvx - dvx_b) + 2*q2*(dvy - dvy_b) + 2*q3*(dvz - dvz_b), 2*q0*(dvx - dvx_b) - 2*q3*(dvy - dvy_b) + 2*q2*(dvz - dvz_b), 0, 0, 0,  0,  1,  0,     0,     0,     0,         - 2*q0*q3 - 2*q1*q2, - q0^2 + q1^2 - q2^2 + q3^2,           2*q0*q1 - 2*q2*q3, 0, 0, 0, 0, 0, 0, 0, 0]
                [ 2*q1*(dvy - dvy_b) - 2*q2*(dvx - dvx_b) + 2*q0*(dvz - dvz_b), 2*q3*(dvx - dvx_b) + 2*q0*(dvy - dvy_b) - 2*q1*(dvz - dvz_b), 2*q3*(dvy - dvy_b) - 2*q0*(dvx - dvx_b) - 2*q2*(dvz - dvz_b), 2*q1*(dvx - dvx_b) + 2*q2*(dvy - dvy_b) + 2*q3*(dvz - dvz_b), 0, 0, 0,  0,  0,  1,     0,     0,     0,           2*q0*q2 - 2*q1*q3,         - 2*q0*q1 - 2*q2*q3, - q0^2 + q1^2 + q2^2 - q3^2, 0, 0, 0, 0, 0, 0, 0, 0]
                [                                                            0,                                                            0,                                                            0,                                                            0, 0, 0, 0,  0,  0,  0,     1,     0,     0,                           0,                           0,                           0, 0, 0, 0, 0, 0, 0, 0, 0]
                [                                                            0,                                                            0,                                                            0,                                                            0, 0, 0, 0,  0,  0,  0,     0,     1,     0,                           0,                           0,                           0, 0, 0, 0, 0, 0, 0, 0, 0]
                [                                                            0,                                                            0,                                                            0,                                                            0, 0, 0, 0,  0,  0,  0,     0,     0,     1,                           0,                           0,                           0, 0, 0, 0, 0, 0, 0, 0, 0]
                [                                                            0,                                                            0,                                                            0,                                                            0, 0, 0, 0,  0,  0,  0,     0,     0,     0,                           1,                           0,                           0, 0, 0, 0, 0, 0, 0, 0, 0]
                [                                                            0,                                                            0,                                                            0,                                                            0, 0, 0, 0,  0,  0,  0,     0,     0,     0,                           0,                           1,                           0, 0, 0, 0, 0, 0, 0, 0, 0]
                [                                                            0,                                                            0,                                                            0,                                                            0, 0, 0, 0,  0,  0,  0,     0,     0,     0,                           0,                           0,                           1, 0, 0, 0, 0, 0, 0, 0, 0]
                [                                                            0,                                                            0,                                                            0,                                                            0, 0, 0, 0,  0,  0,  0,     0,     0,     0,                           0,                           0,                           0, 1, 0, 0, 0, 0, 0, 0, 0]
                [                                                            0,                                                            0,                                                            0,                                                            0, 0, 0, 0,  0,  0,  0,     0,     0,     0,                           0,                           0,                           0, 0, 1, 0, 0, 0, 0, 0, 0]
                [                                                            0,                                                            0,                                                            0,                                                            0, 0, 0, 0,  0,  0,  0,     0,     0,     0,                           0,                           0,                           0, 0, 0, 1, 0, 0, 0, 0, 0]
                [                                                            0,                                                            0,                                                            0,                                                            0, 0, 0, 0,  0,  0,  0,     0,     0,     0,                           0,                           0,                           0, 0, 0, 0, 1, 0, 0, 0, 0]
                [                                                            0,                                                            0,                                                            0,                                                            0, 0, 0, 0,  0,  0,  0,     0,     0,     0,                           0,                           0,                           0, 0, 0, 0, 0, 1, 0, 0, 0]
                [                                                            0,                                                            0,                                                            0,                                                            0, 0, 0, 0,  0,  0,  0,     0,     0,     0,                           0,                           0,                           0, 0, 0, 0, 0, 0, 1, 0, 0]
                [                                                            0,                                                            0,                                                            0,                                                            0, 0, 0, 0,  0,  0,  0,     0,     0,     0,                           0,                           0,                           0, 0, 0, 0, 0, 0, 0, 1, 0]
                [                                                            0,                                                            0,                                                            0,                                                            0, 0, 0, 0,  0,  0,  0,     0,     0,     0,                           0,                           0,                           0, 0, 0, 0, 0, 0, 0, 0, 1]];
            
          
        end

        function dwdx = processNoiseJacobianFcn(obj, x,w)%#ok<INUSL>
        %PROCESSNOISEJACOBIANFCN Compute jacobian for multiplicative process noise
        %   The process noise Jacobian dwdx for state vector x and multiplicative
        %   process noise w is L* W * (L.') where 
        %       L = jacobian of update function f with respect to drive inputs 
        %       W = covariance matrix of multiplicative process noise w.
            daxCov = w(1);
            dayCov = w(2);
            dazCov = w(3);
            dvxCov = w(4);
            dvyCov = w(5);
            dvzCov = w(6);
            
            
            q0 = x(1);
            q1 = x(2);
            q2 = x(3);
            q3 = x(4);
    
            
%             dwdx = [ ...
%                 (daxCov*q1^2)/4 + (dayCov*q2^2)/4 + (dazCov*q3^2)/4, (dayCov*q2*q3)/4 - (daxCov*q0*q1)/4 - (dazCov*q2*q3)/4, (dazCov*q1*q3)/4 - (dayCov*q0*q2)/4 - (daxCov*q1*q3)/4, (daxCov*q1*q2)/4 - (dayCov*q1*q2)/4 - (dazCov*q0*q3)/4, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
%       (dayCov*q2*q3)/4 - (daxCov*q0*q1)/4 - (dazCov*q2*q3)/4,    (daxCov*q0^2)/4 + (dazCov*q2^2)/4 + (dayCov*q3^2)/4, (daxCov*q0*q3)/4 - (dayCov*q0*q3)/4 - (dazCov*q1*q2)/4, (dazCov*q0*q2)/4 - (dayCov*q1*q3)/4 - (daxCov*q0*q2)/4, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
%       (dazCov*q1*q3)/4 - (dayCov*q0*q2)/4 - (daxCov*q1*q3)/4, (daxCov*q0*q3)/4 - (dayCov*q0*q3)/4 - (dazCov*q1*q2)/4,    (dayCov*q0^2)/4 + (dazCov*q1^2)/4 + (daxCov*q3^2)/4, (dayCov*q0*q1)/4 - (daxCov*q2*q3)/4 - (dazCov*q0*q1)/4, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
%       (daxCov*q1*q2)/4 - (dayCov*q1*q2)/4 - (dazCov*q0*q3)/4, (dazCov*q0*q2)/4 - (dayCov*q1*q3)/4 - (daxCov*q0*q2)/4, (dayCov*q0*q1)/4 - (daxCov*q2*q3)/4 - (dazCov*q0*q1)/4,    (dazCov*q0^2)/4 + (dayCov*q1^2)/4 + (daxCov*q2^2)/4, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
%                                                            0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
%                                                            0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
%                                                            0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
%                                                            0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                               dvyCov*(2*q0*q3 - 2*q1*q2)^2 + dvzCov*(2*q0*q2 + 2*q1*q3)^2 + dvxCov*(q0^2 + q1^2 - q2^2 - q3^2)^2, dvxCov*(2*q0*q3 + 2*q1*q2)*(q0^2 + q1^2 - q2^2 - q3^2) - dvyCov*(2*q0*q3 - 2*q1*q2)*(q0^2 - q1^2 + q2^2 - q3^2) - dvzCov*(2*q0*q1 - 2*q2*q3)*(2*q0*q2 + 2*q1*q3), dvzCov*(2*q0*q2 + 2*q1*q3)*(q0^2 - q1^2 - q2^2 + q3^2) - dvxCov*(2*q0*q2 - 2*q1*q3)*(q0^2 + q1^2 - q2^2 - q3^2) - dvyCov*(2*q0*q1 + 2*q2*q3)*(2*q0*q3 - 2*q1*q2), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
%                                                            0,                                                      0,                                                      0,                                                      0, 0, 0, 0, dvxCov*(2*q0*q3 + 2*q1*q2)*(q0^2 + q1^2 - q2^2 - q3^2) - dvyCov*(2*q0*q3 - 2*q1*q2)*(q0^2 - q1^2 + q2^2 - q3^2) - dvzCov*(2*q0*q1 - 2*q2*q3)*(2*q0*q2 + 2*q1*q3),                                                               dvxCov*(2*q0*q3 + 2*q1*q2)^2 + dvzCov*(2*q0*q1 - 2*q2*q3)^2 + dvyCov*(q0^2 - q1^2 + q2^2 - q3^2)^2, dvyCov*(2*q0*q1 + 2*q2*q3)*(q0^2 - q1^2 + q2^2 - q3^2) - dvzCov*(2*q0*q1 - 2*q2*q3)*(q0^2 - q1^2 - q2^2 + q3^2) - dvxCov*(2*q0*q2 - 2*q1*q3)*(2*q0*q3 + 2*q1*q2), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
%                                                            0,                                                      0,                                                      0,                                                      0, 0, 0, 0, dvzCov*(2*q0*q2 + 2*q1*q3)*(q0^2 - q1^2 - q2^2 + q3^2) - dvxCov*(2*q0*q2 - 2*q1*q3)*(q0^2 + q1^2 - q2^2 - q3^2) - dvyCov*(2*q0*q1 + 2*q2*q3)*(2*q0*q3 - 2*q1*q2), dvyCov*(2*q0*q1 + 2*q2*q3)*(q0^2 - q1^2 + q2^2 - q3^2) - dvzCov*(2*q0*q1 - 2*q2*q3)*(q0^2 - q1^2 - q2^2 + q3^2) - dvxCov*(2*q0*q2 - 2*q1*q3)*(2*q0*q3 + 2*q1*q2),                                                               dvxCov*(2*q0*q2 - 2*q1*q3)^2 + dvyCov*(2*q0*q1 + 2*q2*q3)^2 + dvzCov*(q0^2 - q1^2 - q2^2 + q3^2)^2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
%                                                            0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
%                                                            0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
%                                                            0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
%                                                            0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
%                                                            0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
%                                                            0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
%                                                            0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
%                                                            0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
%                                                            0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
%                                                            0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
%                                                            0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
%                                                            0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
            dwdx = [ ...
                [    (daxCov*q1^2)/4 + (dayCov*q2^2)/4 + (dazCov*q3^2)/4, (dayCov*q2*q3)/4 - (daxCov*q0*q1)/4 - (dazCov*q2*q3)/4, (dazCov*q1*q3)/4 - (dayCov*q0*q2)/4 - (daxCov*q1*q3)/4, (daxCov*q1*q2)/4 - (dayCov*q1*q2)/4 - (dazCov*q0*q3)/4, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [ (dayCov*q2*q3)/4 - (daxCov*q0*q1)/4 - (dazCov*q2*q3)/4,    (daxCov*q0^2)/4 + (dazCov*q2^2)/4 + (dayCov*q3^2)/4, (daxCov*q0*q3)/4 - (dayCov*q0*q3)/4 - (dazCov*q1*q2)/4, (dazCov*q0*q2)/4 - (dayCov*q1*q3)/4 - (daxCov*q0*q2)/4, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [ (dazCov*q1*q3)/4 - (dayCov*q0*q2)/4 - (daxCov*q1*q3)/4, (daxCov*q0*q3)/4 - (dayCov*q0*q3)/4 - (dazCov*q1*q2)/4,    (dayCov*q0^2)/4 + (dazCov*q1^2)/4 + (daxCov*q3^2)/4, (dayCov*q0*q1)/4 - (daxCov*q2*q3)/4 - (dazCov*q0*q1)/4, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [ (daxCov*q1*q2)/4 - (dayCov*q1*q2)/4 - (dazCov*q0*q3)/4, (dazCov*q0*q2)/4 - (dayCov*q1*q3)/4 - (daxCov*q0*q2)/4, (dayCov*q0*q1)/4 - (daxCov*q2*q3)/4 - (dazCov*q0*q1)/4,    (dazCov*q0^2)/4 + (dayCov*q1^2)/4 + (daxCov*q2^2)/4, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [                                                      0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [                                                      0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [                                                      0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [                                                      0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                               dvyCov*(2*q0*q3 - 2*q1*q2)^2 + dvzCov*(2*q0*q2 + 2*q1*q3)^2 + dvxCov*(q0^2 + q1^2 - q2^2 - q3^2)^2, dvxCov*(2*q0*q3 + 2*q1*q2)*(q0^2 + q1^2 - q2^2 - q3^2) - dvyCov*(2*q0*q3 - 2*q1*q2)*(q0^2 - q1^2 + q2^2 - q3^2) - dvzCov*(2*q0*q1 - 2*q2*q3)*(2*q0*q2 + 2*q1*q3), dvzCov*(2*q0*q2 + 2*q1*q3)*(q0^2 - q1^2 - q2^2 + q3^2) - dvxCov*(2*q0*q2 - 2*q1*q3)*(q0^2 + q1^2 - q2^2 - q3^2) - dvyCov*(2*q0*q1 + 2*q2*q3)*(2*q0*q3 - 2*q1*q2), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [                                                      0,                                                      0,                                                      0,                                                      0, 0, 0, 0, dvxCov*(2*q0*q3 + 2*q1*q2)*(q0^2 + q1^2 - q2^2 - q3^2) - dvyCov*(2*q0*q3 - 2*q1*q2)*(q0^2 - q1^2 + q2^2 - q3^2) - dvzCov*(2*q0*q1 - 2*q2*q3)*(2*q0*q2 + 2*q1*q3),                                                               dvxCov*(2*q0*q3 + 2*q1*q2)^2 + dvzCov*(2*q0*q1 - 2*q2*q3)^2 + dvyCov*(q0^2 - q1^2 + q2^2 - q3^2)^2, dvyCov*(2*q0*q1 + 2*q2*q3)*(q0^2 - q1^2 + q2^2 - q3^2) - dvzCov*(2*q0*q1 - 2*q2*q3)*(q0^2 - q1^2 - q2^2 + q3^2) - dvxCov*(2*q0*q2 - 2*q1*q3)*(2*q0*q3 + 2*q1*q2), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [                                                      0,                                                      0,                                                      0,                                                      0, 0, 0, 0, dvzCov*(2*q0*q2 + 2*q1*q3)*(q0^2 - q1^2 - q2^2 + q3^2) - dvxCov*(2*q0*q2 - 2*q1*q3)*(q0^2 + q1^2 - q2^2 - q3^2) - dvyCov*(2*q0*q1 + 2*q2*q3)*(2*q0*q3 - 2*q1*q2), dvyCov*(2*q0*q1 + 2*q2*q3)*(q0^2 - q1^2 + q2^2 - q3^2) - dvzCov*(2*q0*q1 - 2*q2*q3)*(q0^2 - q1^2 - q2^2 + q3^2) - dvxCov*(2*q0*q2 - 2*q1*q3)*(2*q0*q3 + 2*q1*q2),                                                               dvxCov*(2*q0*q2 - 2*q1*q3)^2 + dvyCov*(2*q0*q1 + 2*q2*q3)^2 + dvzCov*(q0^2 - q1^2 - q2^2 + q3^2)^2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [                                                      0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [                                                      0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [                                                      0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [                                                      0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [                                                      0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [                                                      0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [                                                      0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [                                                      0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [                                                      0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [                                                      0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [                                                      0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [                                                      0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [                                                      0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [                                                      0,                                                      0,                                                      0,                                                      0, 0, 0, 0,                                                                                                                                                                0,                                                                                                                                                                0,                                                                                                                                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]];
        end
        %% 真空速测量仿真z和H
        function z = tasMeasFcn(obj, x)%#ok<INUSL>
        %MAGMEASFCN Measurement function Hmag(x) for state vector x
        %   1 measurement from airspeed boom
        %   tas;
            q0 = x(1);
            q1 = x(2);
            q2 = x(3);
            q3 = x(4);                
            vn = x(8);
            ve = x(9);
            vd = x(10);
            vwn = x(23);
            vwe = x(24);
%             z = ((ve - vwe)^2 + (vn - vwn)^2 + vd^2)^(1/2);
%             
            % 将地速和风速投影到体系，取x轴的差
            Tbn = [[ q0^2 + q1^2 - q2^2 - q3^2,         2*q1*q2 - 2*q0*q3,         2*q0*q2 + 2*q1*q3]
                [         2*q0*q3 + 2*q1*q2, q0^2 - q1^2 + q2^2 - q3^2,         2*q2*q3 - 2*q0*q1]
                [         2*q1*q3 - 2*q0*q2,         2*q0*q1 + 2*q2*q3, q0^2 - q1^2 - q2^2 + q3^2]];
            vNav_b = Tbn'*[vn;ve;vd];
            vNav_b_x = vNav_b(1);
            vw_b = Tbn'*[vwn;vwe;0];
            vw_b_x = vw_b(1);
            sel = 'nonabs'; % 'nonabs'
            switch sel
                case 'abs'
                    % 将地速和风速投影到体系，取x轴的差的绝对值
                    z = abs(vNav_b_x - vw_b_x);
                otherwise
                    % 将地速和风速投影到体系，取x轴的差
                    z = vNav_b_x - vw_b_x;
            end
%             z = sqrt((vNav_b(1)-vwn)^2 + (vNav_b(2)-vwe)^2 + vNav_b(3)^2); % predicted measurement
        end        
        
        function dhdx = tasMeasJacobianFcn(obj, x)%#ok<INUSL>
            q0 = x(1);
            q1 = x(2);
            q2 = x(3);
            q3 = x(4);            
            vn = x(8);
            ve = x(9);
            vd = x(10);
            vwn = x(23);
            vwe = x(24);   
            sel = 'nonabs'; % 'nonabs'
            switch sel
                case 'abs'
                    % 将地速和风速投影到体系，取x轴的差的绝对值
                    dhdx = [ sign(vwn*(q0^2 + q1^2 - q2^2 - q3^2) - vn*(q0^2 + q1^2 - q2^2 - q3^2) + vd*(2*q0*q2 - 2*q1*q3) - ve*(2*q0*q3 + 2*q1*q2) + vwe*(2*q0*q3 + 2*q1*q2))*(2*q2*vd - 2*q3*ve - 2*q0*vn + 2*q3*vwe + 2*q0*vwn), -sign(vwn*(q0^2 + q1^2 - q2^2 - q3^2) - vn*(q0^2 + q1^2 - q2^2 - q3^2) + vd*(2*q0*q2 - 2*q1*q3) - ve*(2*q0*q3 + 2*q1*q2) + vwe*(2*q0*q3 + 2*q1*q2))*(2*q3*vd + 2*q2*ve + 2*q1*vn - 2*q2*vwe - 2*q1*vwn), sign(vwn*(q0^2 + q1^2 - q2^2 - q3^2) - vn*(q0^2 + q1^2 - q2^2 - q3^2) + vd*(2*q0*q2 - 2*q1*q3) - ve*(2*q0*q3 + 2*q1*q2) + vwe*(2*q0*q3 + 2*q1*q2))*(2*q0*vd - 2*q1*ve + 2*q2*vn + 2*q1*vwe - 2*q2*vwn), -sign(vwn*(q0^2 + q1^2 - q2^2 - q3^2) - vn*(q0^2 + q1^2 - q2^2 - q3^2) + vd*(2*q0*q2 - 2*q1*q3) - ve*(2*q0*q3 + 2*q1*q2) + vwe*(2*q0*q3 + 2*q1*q2))*(2*q1*vd + 2*q0*ve - 2*q3*vn - 2*q0*vwe + 2*q3*vwn), 0, 0, 0, -sign(vwn*(q0^2 + q1^2 - q2^2 - q3^2) - vn*(q0^2 + q1^2 - q2^2 - q3^2) + vd*(2*q0*q2 - 2*q1*q3) - ve*(2*q0*q3 + 2*q1*q2) + vwe*(2*q0*q3 + 2*q1*q2))*(q0^2 + q1^2 - q2^2 - q3^2), -sign(vwn*(q0^2 + q1^2 - q2^2 - q3^2) - vn*(q0^2 + q1^2 - q2^2 - q3^2) + vd*(2*q0*q2 - 2*q1*q3) - ve*(2*q0*q3 + 2*q1*q2) + vwe*(2*q0*q3 + 2*q1*q2))*(2*q0*q3 + 2*q1*q2), sign(vwn*(q0^2 + q1^2 - q2^2 - q3^2) - vn*(q0^2 + q1^2 - q2^2 - q3^2) + vd*(2*q0*q2 - 2*q1*q3) - ve*(2*q0*q3 + 2*q1*q2) + vwe*(2*q0*q3 + 2*q1*q2))*(2*q0*q2 - 2*q1*q3), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, sign(vwn*(q0^2 + q1^2 - q2^2 - q3^2) - vn*(q0^2 + q1^2 - q2^2 - q3^2) + vd*(2*q0*q2 - 2*q1*q3) - ve*(2*q0*q3 + 2*q1*q2) + vwe*(2*q0*q3 + 2*q1*q2))*(q0^2 + q1^2 - q2^2 - q3^2), sign(vwn*(q0^2 + q1^2 - q2^2 - q3^2) - vn*(q0^2 + q1^2 - q2^2 - q3^2) + vd*(2*q0*q2 - 2*q1*q3) - ve*(2*q0*q3 + 2*q1*q2) + vwe*(2*q0*q3 + 2*q1*q2))*(2*q0*q3 + 2*q1*q2)];
                otherwise
                    % 将地速和风速投影到体系，取x轴的差
                    dhdx = [ 2*q3*ve - 2*q2*vd + 2*q0*vn - 2*q3*vwe - 2*q0*vwn, 2*q3*vd + 2*q2*ve + 2*q1*vn - 2*q2*vwe - 2*q1*vwn, 2*q1*ve - 2*q0*vd - 2*q2*vn - 2*q1*vwe + 2*q2*vwn, 2*q1*vd + 2*q0*ve - 2*q3*vn - 2*q0*vwe + 2*q3*vwn, 0, 0, 0, q0^2 + q1^2 - q2^2 - q3^2, 2*q0*q3 + 2*q1*q2, 2*q1*q3 - 2*q0*q2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, - q0^2 - q1^2 + q2^2 + q3^2, - 2*q0*q3 - 2*q1*q2];
            end
%             dhdx = [ 0, 0, 0, 0, 0, 0, 0, (2*vn - 2*vwn)/(2*((ve - vwe)^2 + (vn - vwn)^2 + vd^2)^(1/2)), (2*ve - 2*vwe)/(2*((ve - vwe)^2 + (vn - vwn)^2 + vd^2)^(1/2)), vd/((ve - vwe)^2 + (vn - vwn)^2 + vd^2)^(1/2), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -(2*vn - 2*vwn)/(2*((ve - vwe)^2 + (vn - vwn)^2 + vd^2)^(1/2)), -(2*ve - 2*vwe)/(2*((ve - vwe)^2 + (vn - vwn)^2 + vd^2)^(1/2))];
%             dhdx = [ -(2*(2*q1*vd + 2*q0*ve - 2*q3*vn)*(vwe - ve*(q0^2 - q1^2 + q2^2 - q3^2) - vd*(2*q0*q1 + 2*q2*q3) + vn*(2*q0*q3 - 2*q1*q2)) + 2*(2*q3*ve - 2*q2*vd + 2*q0*vn)*(vwn - vn*(q0^2 + q1^2 - q2^2 - q3^2) + vd*(2*q0*q2 - 2*q1*q3) - ve*(2*q0*q3 + 2*q1*q2)) - 2*(vd*(q0^2 - q1^2 - q2^2 + q3^2) - ve*(2*q0*q1 - 2*q2*q3) + vn*(2*q0*q2 + 2*q1*q3))*(2*q0*vd - 2*q1*ve + 2*q2*vn))/(2*((vd*(q0^2 - q1^2 - q2^2 + q3^2) - ve*(2*q0*q1 - 2*q2*q3) + vn*(2*q0*q2 + 2*q1*q3))^2 + (vwe - ve*(q0^2 - q1^2 + q2^2 - q3^2) - vd*(2*q0*q1 + 2*q2*q3) + vn*(2*q0*q3 - 2*q1*q2))^2 + (vwn - vn*(q0^2 + q1^2 - q2^2 - q3^2) + vd*(2*q0*q2 - 2*q1*q3) - ve*(2*q0*q3 + 2*q1*q2))^2)^(1/2)), -(2*(2*q0*vd - 2*q1*ve + 2*q2*vn)*(vwe - ve*(q0^2 - q1^2 + q2^2 - q3^2) - vd*(2*q0*q1 + 2*q2*q3) + vn*(2*q0*q3 - 2*q1*q2)) + 2*(2*q3*vd + 2*q2*ve + 2*q1*vn)*(vwn - vn*(q0^2 + q1^2 - q2^2 - q3^2) + vd*(2*q0*q2 - 2*q1*q3) - ve*(2*q0*q3 + 2*q1*q2)) + 2*(vd*(q0^2 - q1^2 - q2^2 + q3^2) - ve*(2*q0*q1 - 2*q2*q3) + vn*(2*q0*q2 + 2*q1*q3))*(2*q1*vd + 2*q0*ve - 2*q3*vn))/(2*((vd*(q0^2 - q1^2 - q2^2 + q3^2) - ve*(2*q0*q1 - 2*q2*q3) + vn*(2*q0*q2 + 2*q1*q3))^2 + (vwe - ve*(q0^2 - q1^2 + q2^2 - q3^2) - vd*(2*q0*q1 + 2*q2*q3) + vn*(2*q0*q3 - 2*q1*q2))^2 + (vwn - vn*(q0^2 + q1^2 - q2^2 - q3^2) + vd*(2*q0*q2 - 2*q1*q3) - ve*(2*q0*q3 + 2*q1*q2))^2)^(1/2)), (2*(2*q0*vd - 2*q1*ve + 2*q2*vn)*(vwn - vn*(q0^2 + q1^2 - q2^2 - q3^2) + vd*(2*q0*q2 - 2*q1*q3) - ve*(2*q0*q3 + 2*q1*q2)) - 2*(2*q3*vd + 2*q2*ve + 2*q1*vn)*(vwe - ve*(q0^2 - q1^2 + q2^2 - q3^2) - vd*(2*q0*q1 + 2*q2*q3) + vn*(2*q0*q3 - 2*q1*q2)) + 2*(vd*(q0^2 - q1^2 - q2^2 + q3^2) - ve*(2*q0*q1 - 2*q2*q3) + vn*(2*q0*q2 + 2*q1*q3))*(2*q3*ve - 2*q2*vd + 2*q0*vn))/(2*((vd*(q0^2 - q1^2 - q2^2 + q3^2) - ve*(2*q0*q1 - 2*q2*q3) + vn*(2*q0*q2 + 2*q1*q3))^2 + (vwe - ve*(q0^2 - q1^2 + q2^2 - q3^2) - vd*(2*q0*q1 + 2*q2*q3) + vn*(2*q0*q3 - 2*q1*q2))^2 + (vwn - vn*(q0^2 + q1^2 - q2^2 - q3^2) + vd*(2*q0*q2 - 2*q1*q3) - ve*(2*q0*q3 + 2*q1*q2))^2)^(1/2)), (2*(2*q3*ve - 2*q2*vd + 2*q0*vn)*(vwe - ve*(q0^2 - q1^2 + q2^2 - q3^2) - vd*(2*q0*q1 + 2*q2*q3) + vn*(2*q0*q3 - 2*q1*q2)) - 2*(2*q1*vd + 2*q0*ve - 2*q3*vn)*(vwn - vn*(q0^2 + q1^2 - q2^2 - q3^2) + vd*(2*q0*q2 - 2*q1*q3) - ve*(2*q0*q3 + 2*q1*q2)) + 2*(vd*(q0^2 - q1^2 - q2^2 + q3^2) - ve*(2*q0*q1 - 2*q2*q3) + vn*(2*q0*q2 + 2*q1*q3))*(2*q3*vd + 2*q2*ve + 2*q1*vn))/(2*((vd*(q0^2 - q1^2 - q2^2 + q3^2) - ve*(2*q0*q1 - 2*q2*q3) + vn*(2*q0*q2 + 2*q1*q3))^2 + (vwe - ve*(q0^2 - q1^2 + q2^2 - q3^2) - vd*(2*q0*q1 + 2*q2*q3) + vn*(2*q0*q3 - 2*q1*q2))^2 + (vwn - vn*(q0^2 + q1^2 - q2^2 - q3^2) + vd*(2*q0*q2 - 2*q1*q3) - ve*(2*q0*q3 + 2*q1*q2))^2)^(1/2)), 0, 0, 0, (2*(2*q0*q2 + 2*q1*q3)*(vd*(q0^2 - q1^2 - q2^2 + q3^2) - ve*(2*q0*q1 - 2*q2*q3) + vn*(2*q0*q2 + 2*q1*q3)) - 2*(q0^2 + q1^2 - q2^2 - q3^2)*(vwn - vn*(q0^2 + q1^2 - q2^2 - q3^2) + vd*(2*q0*q2 - 2*q1*q3) - ve*(2*q0*q3 + 2*q1*q2)) + 2*(2*q0*q3 - 2*q1*q2)*(vwe - ve*(q0^2 - q1^2 + q2^2 - q3^2) - vd*(2*q0*q1 + 2*q2*q3) + vn*(2*q0*q3 - 2*q1*q2)))/(2*((vd*(q0^2 - q1^2 - q2^2 + q3^2) - ve*(2*q0*q1 - 2*q2*q3) + vn*(2*q0*q2 + 2*q1*q3))^2 + (vwe - ve*(q0^2 - q1^2 + q2^2 - q3^2) - vd*(2*q0*q1 + 2*q2*q3) + vn*(2*q0*q3 - 2*q1*q2))^2 + (vwn - vn*(q0^2 + q1^2 - q2^2 - q3^2) + vd*(2*q0*q2 - 2*q1*q3) - ve*(2*q0*q3 + 2*q1*q2))^2)^(1/2)), -(2*(q0^2 - q1^2 + q2^2 - q3^2)*(vwe - ve*(q0^2 - q1^2 + q2^2 - q3^2) - vd*(2*q0*q1 + 2*q2*q3) + vn*(2*q0*q3 - 2*q1*q2)) + 2*(2*q0*q1 - 2*q2*q3)*(vd*(q0^2 - q1^2 - q2^2 + q3^2) - ve*(2*q0*q1 - 2*q2*q3) + vn*(2*q0*q2 + 2*q1*q3)) + 2*(2*q0*q3 + 2*q1*q2)*(vwn - vn*(q0^2 + q1^2 - q2^2 - q3^2) + vd*(2*q0*q2 - 2*q1*q3) - ve*(2*q0*q3 + 2*q1*q2)))/(2*((vd*(q0^2 - q1^2 - q2^2 + q3^2) - ve*(2*q0*q1 - 2*q2*q3) + vn*(2*q0*q2 + 2*q1*q3))^2 + (vwe - ve*(q0^2 - q1^2 + q2^2 - q3^2) - vd*(2*q0*q1 + 2*q2*q3) + vn*(2*q0*q3 - 2*q1*q2))^2 + (vwn - vn*(q0^2 + q1^2 - q2^2 - q3^2) + vd*(2*q0*q2 - 2*q1*q3) - ve*(2*q0*q3 + 2*q1*q2))^2)^(1/2)), (2*(2*q0*q2 - 2*q1*q3)*(vwn - vn*(q0^2 + q1^2 - q2^2 - q3^2) + vd*(2*q0*q2 - 2*q1*q3) - ve*(2*q0*q3 + 2*q1*q2)) - 2*(2*q0*q1 + 2*q2*q3)*(vwe - ve*(q0^2 - q1^2 + q2^2 - q3^2) - vd*(2*q0*q1 + 2*q2*q3) + vn*(2*q0*q3 - 2*q1*q2)) + 2*(vd*(q0^2 - q1^2 - q2^2 + q3^2) - ve*(2*q0*q1 - 2*q2*q3) + vn*(2*q0*q2 + 2*q1*q3))*(q0^2 - q1^2 - q2^2 + q3^2))/(2*((vd*(q0^2 - q1^2 - q2^2 + q3^2) - ve*(2*q0*q1 - 2*q2*q3) + vn*(2*q0*q2 + 2*q1*q3))^2 + (vwe - ve*(q0^2 - q1^2 + q2^2 - q3^2) - vd*(2*q0*q1 + 2*q2*q3) + vn*(2*q0*q3 - 2*q1*q2))^2 + (vwn - vn*(q0^2 + q1^2 - q2^2 - q3^2) + vd*(2*q0*q2 - 2*q1*q3) - ve*(2*q0*q3 + 2*q1*q2))^2)^(1/2)), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, (2*vwn - 2*vn*(q0^2 + q1^2 - q2^2 - q3^2) + 2*vd*(2*q0*q2 - 2*q1*q3) - 2*ve*(2*q0*q3 + 2*q1*q2))/(2*((vd*(q0^2 - q1^2 - q2^2 + q3^2) - ve*(2*q0*q1 - 2*q2*q3) + vn*(2*q0*q2 + 2*q1*q3))^2 + (vwe - ve*(q0^2 - q1^2 + q2^2 - q3^2) - vd*(2*q0*q1 + 2*q2*q3) + vn*(2*q0*q3 - 2*q1*q2))^2 + (vwn - vn*(q0^2 + q1^2 - q2^2 - q3^2) + vd*(2*q0*q2 - 2*q1*q3) - ve*(2*q0*q3 + 2*q1*q2))^2)^(1/2)), (2*vwe - 2*ve*(q0^2 - q1^2 + q2^2 - q3^2) - 2*vd*(2*q0*q1 + 2*q2*q3) + 2*vn*(2*q0*q3 - 2*q1*q2))/(2*((vd*(q0^2 - q1^2 - q2^2 + q3^2) - ve*(2*q0*q1 - 2*q2*q3) + vn*(2*q0*q2 + 2*q1*q3))^2 + (vwe - ve*(q0^2 - q1^2 + q2^2 - q3^2) - vd*(2*q0*q1 + 2*q2*q3) + vn*(2*q0*q3 - 2*q1*q2))^2 + (vwn - vn*(q0^2 + q1^2 - q2^2 - q3^2) + vd*(2*q0*q2 - 2*q1*q3) - ve*(2*q0*q3 + 2*q1*q2))^2)^(1/2))];
        end
        %% Magnetometer Correct Helper Functions
        function z = magMeasFcn(obj, x)%#ok<INUSL>
        %MAGMEASFCN Measurement function Hmag(x) for state vector x
        %   3 measurements from magnetometer
        %   [magx, magy, magz];
            
            q0 = x(1);
            q1 = x(2);
            q2 = x(3);
            q3 = x(4);
            magNavX = x(17);
            magNavY = x(18);
            magNavZ = x(19);
            magBiasX = x(20);
            magBiasY = x(21);
            magBiasZ = x(22);
            
            mx = magBiasX + magNavX*(q0^2 + q1^2 - q2^2 - q3^2) - magNavZ*(2*q0*q2 - 2*q1*q3) + magNavY*(2*q0*q3 + 2*q1*q2);
            my = magBiasY + magNavY*(q0^2 - q1^2 + q2^2 - q3^2) + magNavZ*(2*q0*q1 + 2*q2*q3) - magNavX*(2*q0*q3 - 2*q1*q2);
            mz = magBiasZ + magNavZ*(q0^2 - q1^2 - q2^2 + q3^2) - magNavY*(2*q0*q1 - 2*q2*q3) + magNavX*(2*q0*q2 + 2*q1*q3);
            
            z = [mx my mz]';
            
        end

        function dhdx = magMeasJacobianFcn(obj, x)%#ok<INUSL>
        %MAGMEASJACOBIANFCN Compute the jacobian dHmag/dx of measurement function Hmag(x)
            q0 = x(1);
            q1 = x(2);
            q2 = x(3);
            q3 = x(4);
            magNavX = x(17);
            magNavY = x(18);
            magNavZ = x(19);
            
            dhdx = [ ...
                2*magNavY*q3 - 2*magNavZ*q2 + 2*magNavX*q0, 2*magNavZ*q3 + 2*magNavY*q2 + 2*magNavX*q1, 2*magNavY*q1 - 2*magNavZ*q0 - 2*magNavX*q2, 2*magNavZ*q1 + 2*magNavY*q0 - 2*magNavX*q3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, q0^2 + q1^2 - q2^2 - q3^2,         2*q0*q3 + 2*q1*q2,         2*q1*q3 - 2*q0*q2, 1, 0, 0, 0, 0;
                2*magNavZ*q1 + 2*magNavY*q0 - 2*magNavX*q3, 2*magNavZ*q0 - 2*magNavY*q1 + 2*magNavX*q2, 2*magNavZ*q3 + 2*magNavY*q2 + 2*magNavX*q1, 2*magNavZ*q2 - 2*magNavY*q3 - 2*magNavX*q0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,         2*q1*q2 - 2*q0*q3, q0^2 - q1^2 + q2^2 - q3^2,         2*q0*q1 + 2*q2*q3, 0, 1, 0, 0, 0;
                2*magNavZ*q0 - 2*magNavY*q1 + 2*magNavX*q2, 2*magNavX*q3 - 2*magNavY*q0 - 2*magNavZ*q1, 2*magNavY*q3 - 2*magNavZ*q2 + 2*magNavX*q0, 2*magNavZ*q3 + 2*magNavY*q2 + 2*magNavX*q1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,         2*q0*q2 + 2*q1*q3,         2*q2*q3 - 2*q0*q1, q0^2 - q1^2 - q2^2 + q3^2, 0, 0, 1, 0, 0];
        end      

        %% GPS Correct Helper Functions
        function z = gpsMeasFcn(obj, x)%#ok<INUSL>
        %GPSMEASFCN Measurement function Hgps(x) for state vector x
        %   6 measurements from GPS
        %   [posNavX, posNavY, posNavZ, velNavX, velNavY, velNavZ]
            
            pnx = x(5);
            pny = x(6);
            pnz = x(7);
            vnx = x(8);
            vny = x(9);
            vnz = x(10);
           
            z = [pnx pny pnz vnx vny vnz]';
            
        end

        function dhdx = gpsMeasJacobianFcn(obj, ~) %#ok<INUSD>
        %GPSMEASJACOBIANFCN Compute the jacobian dHgps/dx of measurement function Hgps(x)
           
            dhdx = [
                0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
                0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
                0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
                0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
                0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
                0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
            
        end  
        
        function [innov, iCov] = fusegpsPosition(obj, gpsPos, Rpos)
            rf = rfconfig(obj.ReferenceFrame);
            z = rf.lla2frame(gpsPos, obj.ReferenceLocation).';

            [innov, iCov] = basicCorrect(obj, z, @measurementGPSPosition, Rpos, ...
                    @measurementJacobianGPSPosition);
        end
        
        function h = measurementGPSPosition(~, x)
            pos = x(5:7);
            
            h = pos;
        end
        
        function H = measurementJacobianGPSPosition(~, ~)
            
            H = [...
                0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
                0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
                0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
                ];
        end
    end
end

%% Other Helper Functions
function validateMeasurement(meas, argName)
validateattributes(meas, {'double','single'}, ...
    {'real','finite','2d','nrows',1,'ncols',3,'nonempty'}, ...
    '', ...
    argName);
end

function g = gravms2()
    g = fusion.internal.UnitConversions.geeToMetersPerSecondSquared(1);
end

function p = posangle(p)
%POSANGLE Force quaternion to have a positive angle

idx = parts(p) < 0;
if any(idx(:))
    p(idx) = -p(idx);
end
end

function s = defaultState(refStr)
    rf = rfconfig(refStr);

    magFieldNED = defaultMagFieldNED;
    magField = magFieldNED;
    magField(rf.NorthIndex) = magFieldNED(1);
    magField(rf.EastIndex) = magFieldNED(2);
    magField(3) = -rf.ZAxisUpSign * magFieldNED(3);
    
    s = [1; zeros(15,1); magField(:); 0; 0; 0; 0; 0;];
end

function p = defaultCov()
    p = 1e-6*eye(24);
end

function rf = rfconfig(refStr)
%RFCONFIG Return the reference frame configuration object based on the 
%   reference frame string.
rf = fusion.internal.frames.ReferenceFrame.getMathObject( ...
                refStr);
end

function mfNED = defaultMagFieldNED
mfNED = fusion.internal.UnitConversions.MagneticFieldNED;
end
