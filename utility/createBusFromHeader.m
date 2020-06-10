clear
headerName = 'gs.h';
Simulink.importExternalCTypes(headerName);

if 0
    load('SubFolder_ICD\MAVLink_GS')
    STRUCT_mission_item_def = Simulink.Bus.createMATLABStruct('mission_item_def');
end