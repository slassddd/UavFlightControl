MPCSim_path.Ts = 0.036;
MPCSim_path.numSample = 10;
MPCSim_path.maxYaw = 120;
MPCSim_path.pathplotenable = true; % false true
MPCSim_path.dataGenMode = 'regularbatch'; % 'single' 'regularbatch'
MPCSim_path.modeSim = 'matlab'; % matlab simulink
MPCSim_path.algMode = 'psi_dz_V'; % psi_dz psi_dz_V
MPCSim_path.Duration = 16;
MPCSim_path.V = 22;
gVal = 9.81;
INIT_MPCPath
INIT_MPCPath_3s
switch MPCSim_path.dataGenMode
    case 'rand'
        yaws = randi([-MPCSim_path.maxYaw,MPCSim_path.maxYaw],MPCSim_path.numSample)*pi/180;
        dzs = 200*rand(MPCSim_path.numSample,1).*sign(randn(MPCSim_path.numSample,1));
    case 'regularbatch'
        yaws = linspace(-pi/2,-2*pi,MPCSim_path.numSample);
        dzs = -30*ones(size(yaws));
        Vs = linspace(MPCSim_path.V,MPCSim_path.V,MPCSim_path.numSample);%linspace(20,30,MPCSim_path.numSample);
    case 'single'
        yaws = -150*pi/180;
        dzs = -30;
        Vs = MPCSim_path.V;
        MPCSim_path.numSample = 1;
end
for i = 1:MPCSim_path.numSample    
    switch MPCSim_path.algMode
        case 'psi_dz'
            x = [yaws(i);dzs(i)];
        case 'psi_dz_V'
            x = [yaws(i);dzs(i);Vs(i)];
    end
    x(1) = rem(x(1),2*pi);
    if x(1) > pi
        x(1) = x(1) - 2*pi;
    elseif x(1) <= -pi
        x(1) = x(1) + 2*pi;
    end
    PosXY = [0,x(2)];
    mv = nloptions.MVTarget;
    %%
    % Simulate the closed-loop system using the |nlmpcmove| function, specifying
    % simulation options using an |nlmpcmove| object.
    switch MPCSim_path.modeSim
        case 'matlab'
            hbar = waitbar(0,'Simulation Progress');
            xHistory = x';
            lastMV = mv;
            uHistory = lastMV;
            for k = 1:(MPCSim_path.Duration/MPCParam_path.Ts)
                x = xHistory(k,:);
                xk = xHistory(k,:);
                switch MPCSim_path.algMode
                    case 'psi_dz'
                        yref = [0;0];
                        [uk,nloptions,info] = nlmpcmove(nlmpcObj_path,xk,lastMV,yref',[],nloptions);
                        uHistory(k+1,:) = uk';
                        lastMV = uk;
                        % Update states.
                        ODEFUN = @(t,xk) uavPathFollowStateFcn(xk,uk);                    
                    case 'psi_dz_V'
                        yref = [0;0;Vs(i)];
                        [uk,nloptions,info] = nlmpcmove(nlmpcObj_path_3s,xk,lastMV,yref',[],nloptions);
                        uHistory(k+1,:) = uk';
                        lastMV = uk;
                        % Update states.
                        ODEFUN = @(t,xk) uavPathFollowStateFcn_3s(xk,uk);   
                end
                [TOUT,YOUT] = ode45(ODEFUN,[0 MPCParam_path.Ts], xHistory(k,:)');            
                xHistory(k+1,:) = YOUT(end,:);
                PosXY(end+1,:) = PosXY(end,:) + MPCSim_path.V*[cos(xHistory(k+1,1)) sin(xHistory(k+1,1))]*MPCParam_path.Ts;
                if 0
                    figure(2);
                    tempXHistory = YOUT;
                    clear tempPosXY
                    tempPosXY = PosXY(end-1,:);
                    for i = 1:size(YOUT,1)-1
                        tempPosXY(end+1,:) = tempPosXY(end,:) + VVal*[cos(tempXHistory(i+1,1)) sin(tempXHistory(i+1,1))]*MPCParam_path.Ts;
                    end
                    plot(tempPosXY(:,1),tempPosXY(:,2));grid on;hold on;
                    xlabel('X [m]')
                    ylabel('Y [m]')
                    axis equal
                end
                waitbar(k*MPCParam_path.Ts/MPCSim_path.Duration,hbar);
            end
            close(hbar)
            % %% Visualization and ResulMPCParam_path.Ts
            if MPCSim_path.pathplotenable
                TALL = [0:MPCParam_path.Ts:MPCSim_path.Duration]';
                % PosXY = VVal*[cos(xHistory(:,1)) sin(xHistory(:,2))];
                figure(1);
                subplot(321)
                plot(TALL,xHistory(:,1)*180/pi);grid on;hold on;
                xlabel('time (sec)')
                ylabel('航向角 [deg]')
                subplot(323)
                plot(TALL,xHistory(:,2));grid on;hold on;
                xlabel('time (sec)')
                ylabel('侧偏距 [m]')
                subplot(325)
                plot(TALL,uHistory*180/pi);grid on;hold on;
                xlabel('time (sec)')
                ylabel('滚转角 [deg]')
                subplot(122)
                plot(PosXY(:,1),PosXY(:,2));grid on;hold on;
                xlabel('X [m]')
                ylabel('Y [m]')
                axis equal
                xHistory(end,:)
            end
        case 'simulink'
            switch MPCSim_path.algMode
                case 'psi_dz'
                    sim('mpcModel');
                case 'psi_dz_V'
                    sim('mpcModel_3s');
            end            
            
    end
end