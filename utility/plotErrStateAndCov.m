function plotErrStateAndCov(time,data0,data1,limit,xstr,ystr,plotflag,varargin)
if nargin == 8
    color = varargin{1};
else
    color = 'b';
end

if plotflag.limiton
    plot(time,limit,'k--');hold on;
    plot(time,-limit,'k--');hold on;
end
plot(time,data1-data0,color);hold on;
xlabel(xstr)
ylabel(ystr)
grid(plotflag.gridon)