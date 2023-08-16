%% Main Function of the Optimization.
clear all
close all
clc


%% Initial design vector

initial = [0.5,0.4,20e6];% [phi,psi,P_LPT]

x0 = initial./abs(initial);

global couplings
couplings.x0 = initial;
%% Bounds of the optimization

lb = [0.4,0.3,20e5]./abs(initial);

ub = [1.1,0.6 ,20e7]./abs(initial);


% Setting optimization options.
options.Display         = 'iter-detailed';
options.Algorithm       = 'sqp'; 
options.FunValCheck     = 'off';
options.DiffMinChange   = 1e-5;         % Minimum change while gradient searching
options.DiffMaxChange   = 1e-2;            % Maximum change while gradient searching
options.TolCon          = 1e-12;         % Maximum difference between two subsequent constraint vectors [c and ceq]
options.TolFun          = 1e-6;         % Maximum difference between two subsequent objective value
options.TolX            = 1e-12;         % Maximum difference between two subsequent design vectors

options.MaxIter         = 1000;         % Maximum iterations
options.MaxFunEvals     = 4e3;          % Maximum number of function evaluations
options.FinDiffType = 'central';

options.PlotFcns = {@optimplotfval,@optimplotx,@optimplotfunccount,...
                    @optimplotfirstorderopt,@optimplotstepsize,...
                    @optimplotconstrviolation};    % Plotting the optimization parameters.


% % Running the optimization.  
% tic
% [x_opt,FVAL,exitflag,output] = fmincon(@Coordinator,x0,[],[],[],[],lb,ub,@Constraints,options);
% history.x = [history.x;x];
% toc


% Running the optimization.  
tic
[x_opt,FVAL,exitflag,output] = fmincon(@Objective,x0,[],[],[],[],lb,ub,@Constraints,options);
%history.x = [history.x;x];
final_x = x_opt.*initial

toc
