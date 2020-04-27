function [nlmpcObj,nloptions] = nlmpc_pathfollow(MPCParam_path)
%%
Ts = MPCParam_path.Ts_mpc;
p = MPCParam_path.p;
m = MPCParam_path.m;
nx = MPCParam_path.nx; % yaw,dz
ny = MPCParam_path.ny; % yaw,dz
nu = MPCParam_path.nu; % phi
StateFcn = MPCParam_path.StateFcn;
StateJacobianFcn = MPCParam_path.StateJacobianFcn;
maxRoll = MPCParam_path.maxRoll;
maxRollRate = MPCParam_path.maxRollRate;
nlmpcObj = nlmpc(nx, ny, nu);
%%
nlmpcObj.Model.StateFcn = StateFcn;
%%
nlmpcObj.Jacobian.StateFcn = StateJacobianFcn;
%%
% Validate your prediction model, your custom functions, and their Jacobians.
% rng(0)
% validateFcns(nlobj,rand(nx,1),rand(nu,1));
%%
% Specify a sample time of |0.1| seconds, prediction horizon of 18 steps, and
% control horizon of 2 steps.
nlmpcObj.Ts = Ts;
nlmpcObj.PredictionHorizon = p;
nlmpcObj.ControlHorizon = m;
%%
% Limit all four control inputs to be in the range [0,12].
nlmpcObj.MV = struct('Min',{-maxRoll},'Max',{maxRoll});
nlmpcObj.MV.RateMin = -maxRollRate;
nlmpcObj.MV.RateMax = maxRollRate;
%%
nlmpcObj.Weights.OutputVariables = [1 0.12];
%%
nlmpcObj.Weights.ManipulatedVariables = [0];
%%
% Also, penalize aggressive control actions by specifying tuning weights for
% the MV rates of change.

nlmpcObj.Weights.ManipulatedVariablesRate = [0];
% Nominal control that keeps the quadrotor floating
nloptions = nlmpcmoveopt;
nloptions.MVTarget = [0];