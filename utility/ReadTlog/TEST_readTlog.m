% Visualize and Playback MAVLink Flight Log
% This example shows how to load a telemetry log (TLOG) containing MAVLink packets into MATLAB®. Details of the messages are extracted for plotting. Then, to simulate the flight again, the messages are republished over the MAVLink communication interface. This publishing mimics an unmanned aerial vehicle (UAV) executing the flight recorded in the tlog.
% Load MAVLink TLOG
% Create a mavlinkdialect object using the "common.xml" dialect. Use mavlinktlog with this dialect to load the TLOG data.
dialect = mavlinkdialect('common.xml');
logimport = mavlinktlog('mavlink_flightlog.tlog',dialect);

% Extract the GPS messages from the TLOG and visualize them using geoplot.
msgs = readmsg(logimport, 'MessageName', 'GPS_RAW_INT', ...
                          'Time',[0 100]);
latlon = msgs.Messages{1};
% filter out zero-valued messages
latlon = latlon(latlon.lat ~= 0 & latlon.lon ~= 0, :);
figure()
geoplot(double(latlon.lat)/1e7, double(latlon.lon)/1e7);

% Extract the attitude messages from the TLOG. Specify the message name for attitude messages. Plot the roll, pitch, yaw data using stackedplot.
msgs = readmsg(logimport,'MessageName','ATTITUDE','Time',[0 100]);

figure()
stackedplot(msgs.Messages{1},{'roll','pitch','yaw'});

% Playback MAVLink Log Entries
% Create a MAVLink communication interface and publish the messages from the TLOG to user defined UDP port.  Create a sender and receiver for passing the MAVLink messages. This communication system works the same way that real hardware would publish messages using the MAVLink communication protocols.
sender = mavlinkio(dialect,'SystemID',1,'ComponentID',1,...
                   'AutopilotType',"MAV_AUTOPILOT_GENERIC",...
                   'ComponentType',"MAV_TYPE_QUADROTOR");
connect(sender,'UDP');

destinationPort = 14550;
destinationHost = '127.0.0.1';

receiver = mavlinkio(dialect);
connect(receiver,'UDP','LocalPort',destinationPort);

subscriber = mavlinksub(receiver,'ATTITUDE','NewMessageFcn',@(~,msg)disp(msg.Payload));
% Send the first 100 messages at a rate of 50 Hz.
payloads = table2struct(msgs.Messages{1});
attitudeDefinition = msginfo(dialect, 'ATTITUDE');
for msgIdx = 1:100
    sendudpmsg(sender,struct('MsgID', attitudeDefinition.MessageID, 'Payload', payloads(msgIdx)),destinationHost,destinationPort);
    pause(1/50);
end

% Disconnect from both MAVLink communcation interfaces.
disconnect(receiver)
disconnect(sender)
% Copyright 2020 The MathWorks, Inc.


