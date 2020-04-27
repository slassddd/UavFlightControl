% This script defines a continuous-time nonlinear quadrotor model and
% generates a state function and its Jacobian function used by the
% nonlinear MPC controller in the quadrotor path following example.

% Copyright 2019 The MathWorks, Inc.
% clear,clc
% Create symbolix variables for states, MVs and parameters
syms psit(t) dzt(t)
syms V g u1
syms psi dz psidot dzdot
% psi: 相对于航线的航向 依NED方向
% dzt: 侧偏距
% g: gravity
% V: 速度
% u: 滚转角

% Set values for dynamics parameters


paramValues = [VVal gVal];

% Group symbolic variables
statet = {psit(t) dzt(t)};
state = {psi dz};
state_diff = {diff(psit(t),t), diff(dzt(t),t)};
state_dot = {psidot dzdot};

% Dynamics
f(1) = g/V*tan(u1);
f(2) = V*sin(psi);

% Replace parameters and drop time dependence
f = subs(f, [V g], paramValues);
f = subs(f,statet,state);
f = simplify(f);

% Calculate linearization
A = jacobian(f,[state{:}]);
control = [u1];
B = jacobian(f,control);

% Create QuadrotorStateFcn.m
matlabFunction(transpose(f),'File','uavPathFollowStateFcn',...
    'Vars',{transpose([state{:}]),transpose(control)})
% Create QuadrotorStateJacobianFcn.m 
matlabFunction(A, B,'File','uavPathFollowStateJacobianFcn',...
    'Vars',{transpose([state{:}]),transpose(control)})


