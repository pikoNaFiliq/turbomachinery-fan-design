addpath("0. Constants\","0. Functions\","0. Multall\","2. test\")
clear
clc()
%% INIT CLASS WITH COMMON CONVERSION FUNCTIONS
cc = CommonConversions();
%% COMMANDS USED TO START THE EXECUTABLES
meangen_cmd = "meangen";
stagen_cmd = 'stagen';
multall_cmd = 'multall <stage_new.dat';
% multall_cmd = 'multall <stage_new.dat > results.txt';
%% Aircraft
T_req = 1.15*constants.mtow; % required Thrust


% TR = 1- power_sp/constants.cp/constants.Tt_in; % Temperature Ratio
% PR = TR^((constants.gamma-1)/constants.gamma/eta_is);

%% Turbine CHARACTERISTICS
num_stages = 3;
rpm = 3800;
power = 0.75*225.4*1.4*constants.mtow; % Total power [W] min --> 9.25e7 
w = power/constants.mdot; % [J/kg]
w_stage = w/num_stages;



%% DOODY COEFFICIENTS --> 1.2 and 0.6 worked 1 stage rpm 4000 r =1.3
psi = 1; % range --> 1 - 3 
phi = 0.8; % range --> 0.4 - 1.2
beta_2  = atan(-1/phi);
alpha_1 = atan((psi + 1 + phi*tan(beta_2))/phi);
reaction = psi/2 -phi*tan(alpha_1) + 1 ;

u_mean = sqrt(w_stage/psi);
mean_radius = u_mean/cc.rpm2rads(rpm);

eta_is = 0.915; % isentropic efficiency
%% BLADE CHARACTERISTICS
chord_stator = 0.11;
chord_rotor = 0.12;

delta_stator = 2; % flow deviation in deg
delta_rotor = 2;

i_stator = -2; % Incidence angle stator
i_rotor = -2; % Incidence angle rotor

t_max_stator = 0.2; % max thickness stator
loc_t_max_stator = 0.28; % x location max thickness stator

t_max_rotor = 0.2; % max thickness rotor
loc_t_max_rotor = 0.28; % x location max thickness rotor


%% STARTING THE MULTALL PROCEDURE

cd("0. Multall\")
%% WRITE THE MEANGEN.IN FILE
WriteMeangenInputFile(num_stages,rpm,eta_is,reaction,phi,psi,mean_radius, ...
                    delta_stator,delta_rotor,i_stator,i_rotor, ...
                    t_max_stator,loc_t_max_stator,t_max_rotor, ...
                    loc_t_max_rotor,chord_stator,chord_rotor)

%% RUN MEANGEN AND CHECK IF IT WORKED
[status_meangen,result] = system(meangen_cmd);
if status_meangen ~=0
    error("MEANGEN RAN INTO AN ISSUE")
end

%% CALCULATE MAXIMUM PERIPHERAL SPEED USING STAGEN GEOMETRY
index = strfind(result,"HUB RADIUS");

for i=1:length(index)
    display(result(index(i):index(i)+45))
end

[u_tip_max, tip_radius] = FindUmax(cc.rpm2rads(rpm),result);

%% EDIT THE STAGEN.DAT FILE --> ADD NUMBER OF BLADES AND CHANGE IM AND KM VALUES
EditStagenInputFile()
%% RUN STAGEN AND CHECK IF IT WORKED
[status_stagen,result] = system(stagen_cmd);
if status_stagen ~=0
    error("STAGEN RAN INTO AN ISSUE")
end

%% RUN MULTALL TO TEST IT
EditMultallInputFile(true);
status_multall = system(multall_cmd);
% [status_multall,result] = system(multall_cmd);
% index = strfind(result,"NEGATIVE VOLUMES FOUND");
% display(result(index-10:index+21))

cd("..")







% % Settings fmincon
% out_name = "Attempt_1";
% 
% options = optimoptions( @fmincon, ...
%                         'Algorithm','sqp',...
%                         'FinDiffType','Central',...
%                         'StepTolerance',1e-6,...
%                         "OptimalityTolerance",1e-6,...
%                         "DiffMaxChange",0.1, ...
%                         "DiffMinChange",0.01, ...
%                         "ConstraintTolerance",0.001, ...
%                         "Display",'iter', ...
%                         "MaxIterations",1000, ...
%                         'MaxFunEvals',10000,...
%                         "OutputFcn", @output_func_iter,...
%                         "PlotFcn",{@optimplotx,@optimplotfval,@optimplotfirstorderopt}, ...
%                         "UseParallel",false);

% Starting fmincon

% [x,fval,exitflag,output,lambda,grad,hessian] = ...
%                     runobjconstr(x0,lb,ub,options,cst,mass,perf,out_name);





