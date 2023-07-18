function WriteMeangenInputFile(n_stages,rpm,eta_is,reaction,phi,psi,r_des, ...
                            delta_1,delta_2,incid_1,incid_2, t_max_1, ...
                            x_t_max_1, t_max_2, x_t_max_2,chord_1,chord_2)

file = fopen("meangen.in" ,'wt');
%% MACHINE TYPE
fprintf(file, '%s \n',constants.turbo_type);
%% FLOW TYPE
fprintf(file, '%s \n',constants.flow_type); 
%% GAS PROPERTIES R AND GAMMA
fprintf(file, '%g %g \n',constants.R, constants.gamma);
%% INLET CONDITIONS PT AND TT 
fprintf(file, '%g %g \n',constants.Pt_in, constants.Tt_in);
%% NUMBER OF STAGES
fprintf(file, '%g \n',n_stages); 
%% CHOICE OF DESIGN POINT [H]UB [M]ID, OR [T]IP
fprintf(file, '%s \n',constants.design_point); % flow type
%% ROTATIONAL SPEED IN RPM
fprintf(file, '%g \n',rpm);
%% MASSFLOW RATE
fprintf(file, '%g \n',constants.mdot);
%% METHOD OF DEFINING VELOCITY TRIANGLE
fprintf(file, '%s \n',constants.triangle_method); 
%% METHOD A --> REACTION, PHI, AND PSI
fprintf(file, '%g %g %g \n',reaction,phi,psi);
%% METHOD OF DEFINING DESIGN RADIUS A --> GIVE RADIUS B --> GIVE ENTHALPY 
fprintf(file, '%s \n',constants.radius_method);
%% METHOD A --> DESGIN POINT RADIUS
fprintf(file, '%g \n',r_des);
if exist("chord_1","var") && exist("chord_2","var")
    %% BLADE AXIAL CHORDS OF ROW 1 AND ROW 2 --> STATOR ROTOR FOR TURBINE 
    fprintf(file, '%g %g \n',chord_1,chord_2);
else 
    fprintf(file, '%s \n',"A");
end
%% ROW GAP AND STAGE GAP
fprintf(file, '%g %g \n',constants.gap_row,constants.gap_stage);
%% BLOCKAGE FACTORS LEADING EDGE AND TRAILING EDGE
fprintf(file, '%g %g \n',constants.bf_le,constants.bf_te);
%% GUESS OF STAGE ISENTROPIC EFFICIENCY
fprintf(file, '%g \n',eta_is);
%% DEVIATION ANGLES ROW 1 AND ROW 2 --> STATOR ROTOR FOR TURBINE 
fprintf(file, '%g %g \n',delta_1,delta_2);
%% INCIDENCE ANGLES ROW 1 AND ROW 2 --> STATOR ROTOR FOR TURBINE 
fprintf(file, '%g %g \n',incid_1,incid_2);
%% BLADE TWIST SETTING
fprintf(file, '%g \n',constants.blade_twist);
%%  BLADE ROTATION OPTION
fprintf(file, '%s \n', constants.blade_rotation);
%% QO ANGLES AT LE  AND TE OF ROW 1 
fprintf(file, '%g %g \n',constants.QO_angle,constants.QO_angle); 
%% QO ANGLES AT LE  AND TE OF ROW 2 
fprintf(file, '%g %g \n',constants.QO_angle,constants.QO_angle); 
%% DO YOU WANT TO CHANGE THE ANGLES FOR THIS STAGE ?
fprintf(file, '%s \n', "N"); 
%% Have to say Y for all stages and give the blockage factor for every stage
for n=1:n_stages-1% 
    %% IFSAME_ALL, SET = "Y" TO REPEAT THE LAST STAGE INPUT
    fprintf(file, '%s \n',"Y");
    %% Blockage Factors leading edge and trailing edge 
    fprintf(file, '%g %g \n',constants.bf_le,constants.bf_te);
    %% DO YOU WANT TO CHANGE THE ANGLES FOR THIS STAGE ? "Y" or "N"
    fprintf(file, '%s \n',"N");
end
%% IS OUTPUT REQUESTED FOR ALL BLADE ROWS ?
fprintf(file, '%s \n',"Y");

if exist("t_max_1","var") && exist("x_t_max_1","var")
    %% USE THE GIVEN THICKNESS AND MAX THICKNESS LOCATION FOR ROW 1
    fprintf(file, '%s \n',"N");
    %% MAX THICKNESS AND LOCATION MAX THICKNES ROW 1 SECTION 1
    fprintf(file, '%g %g \n',t_max_1, x_t_max_1);
    %% MAX THICKNESS AND LOCATION MAX THICKNES ROW 1 SECTION 2
    fprintf(file, '%g %g \n',t_max_1, x_t_max_1);
    %% MAX THICKNESS AND LOCATION MAX THICKNES ROW 1 SECTION 2
    fprintf(file, '%g %g \n',t_max_1, x_t_max_1); 
else
    %% USE THE GIVEN THICKNESS AND MAX THICKNESS LOCATION FOR ROW 1
    fprintf(file, '%s \n',"Y");
end

if exist("t_max_2","var") && exist("x_t_max_2","var")
    %% USE THE GIVEN THICKNESS AND MAX THICKNESS LOCATION FOR ROW 2
    fprintf(file, '%s \n',"N");
    %% MAX THICKNESS AND LOCATION MAX THICKNES ROW 2 SECTION 1
    fprintf(file, '%g %g \n',t_max_2, x_t_max_2);
    %% MAX THICKNESS AND LOCATION MAX THICKNES ROW 2 SECTION 2
    fprintf(file, '%g %g \n',t_max_2, x_t_max_2);
    %% MAX THICKNESS AND LOCATION MAX THICKNES ROW 2 SECTION 2
    fprintf(file, '%g %g \n',t_max_2, x_t_max_2); 
    %% USE SAME BLADE PROFILES THROUGHOUT THE STAGE
else
    %% USE THE GIVEN THICKNESS AND MAX THICKNESS LOCATION FOR ROW 2
    fprintf(file, '%s \n',"Y");
end

for n=1:n_stages-1 
    fprintf(file, '%s \n',"Y");
    fprintf(file, '%s \n',"Y");
end
fclose(file);

% cd("..")

end