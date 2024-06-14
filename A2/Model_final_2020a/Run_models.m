clear all;
close all;
clc;

%% Load the model parameters
VSC_GF_SG_params        % Runs the .m file

%% Runs the models

tic
sim('SG_GFOL_2020a')
toc
results_gfol.fvsc = fvsc;
results_gfol.fsg = fsg;
results_gfol.Pvsc = Pvsc;
results_gfol.Psg = Psg;
results_gfol.Qvsc = Qvsc;
results_gfol.Qsg = Qsg;
results_gfol.tsim = tnolin;

save('Results_SG_GFOL_2021_11_14','results_gfol')
clear results_gfol fvsc fsg Pvsc Psg Qvsc Qsg tnolin

tic
sim('SG_GFOR_2020a')
toc
results_gfor.fvsc= fvsc;
results_gfor.fsg = fsg;
results_gfor.Pvsc = Pvsc;
results_gfor.Psg = Psg;
results_gfor.PQvsc = Qvsc;
results_gfor.Qsg = Qsg;
results_gfor.tsim = tnolin;
save('Results_SG_GFOR_2021_11_14','results_gfor')

%% Plot the results
plot_comparison         % Runs the .m file

