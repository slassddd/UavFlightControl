function [FlightPerfSimParam,FLIGHT_PERF_PARAM_V1000,FLIGHT_PERF_PARAM_V10] = INIT_FlightPerformance()
FlightPerfSimParam.Ts_base = 0.036;
%% V1000参数
FLIGHT_PERF_PARAM_V1000 = INIT_FlightPerformance_V1000();
%% V10参数
FLIGHT_PERF_PARAM_V10 = INIT_FlightPerformance_V10();