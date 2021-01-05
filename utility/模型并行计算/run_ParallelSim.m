
modelname = 'TEST_Parsim';
TEST_PARSIM.a = 1;
in(i) = Simulink.SimulationInput(modelname);

for i = 1:16
    in(i) = in(i).setVariable('TEST_PARSIM.a',i);
end
out = parsim(in,'TransferBaseWorkspaceVariables','on'); % 打开 TransferBaseWorkspaceVariables 后，不影响 setVariable 设置的值
out(5).simout.Data