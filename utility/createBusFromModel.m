
modelname = 'RefModel_Navfilter';
bus2Info = Simulink.Bus.createObject...
(modelname,[modelname,'/create Bus/Bus Creator']);

modelname = 'RefModel_AeroDyn_Sim';
bus2Info = Simulink.Bus.createObject...
(modelname,[modelname,'/create Bus/Bus Creator']);

modelname = 'RefModel_AeroDyn_Sim';
bus2Info = Simulink.Bus.createObject...
(modelname,[modelname,'/Actuator Model/Bus Creator1']);

modelname = 'RefModel_SystemArchitecture';
bus2Info = Simulink.Bus.createObject...
(modelname,[modelname,'/FlightControlFirmware/datatype3/Bus Creator']);

modelname = 'untitled';
bus2Info = Simulink.Bus.createObject...
(modelname,[modelname,'/Bus Creator']);