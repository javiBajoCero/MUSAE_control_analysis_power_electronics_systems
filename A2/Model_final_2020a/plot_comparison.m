clear all; clc;

%% Load the results

load('Results_SG_GFOL_2021_11_14.mat')
load('Results_SG_GFOR_2021_11_14.mat')

%% Plot the results
set(0,'defaulttextinterpreter','latex')
set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(groot,'defaultLegendInterpreter','latex');
set(0,'defaultAxesFontSize',14)
format long; format compact

figure('Position',[1000 400 750 600]);
subplot(2, 1, 1)
hold on
plot(results_gfor.tsim,results_gfor.fsg,'k','Linewidth',1.5)
plot(results_gfor.tsim,results_gfor.fvsc,'r','Linewidth',1.5)
plot(results_gfol.tsim,results_gfol.fsg,'--','Color','k','Linewidth',1.5)
plot(results_gfol.tsim,results_gfol.fvsc,'--','Color','r','Linewidth',1.5)
ylim([49.5 50.5])
xlim([19 40])
legend('$f_{SG}$ - GFOR','$f_{VSC}$ - GFOR','$f_{SG}$ - GFOL','$f_{VSC}$ - GFOL','interpreter','latex','Location','eastoutside')
grid on
xlabel('Time [s]')
ylabel('f [Hz]')

%%
subplot(2,1, 2)
hold on
plot(results_gfor.tsim,results_gfor.Psg/1e6,'k','Linewidth',1.5)
plot(results_gfor.tsim,results_gfor.Pvsc/1e6,'r','Linewidth',1.5)
plot(results_gfol.tsim,results_gfol.Psg/1e6,'--','Color','k','Linewidth',1.5)
plot(results_gfol.tsim,results_gfol.Pvsc/1e6,'--','Color','r','Linewidth',1.5)
ylim([150 320])
xlim([19 40])
legend('$P_{SG}$ - GFOR','$P_{VSC}$ - GFOR','$P_{SG}$ - GFOL','$P_{VSC}$ - GFOL','interpreter','latex','Location','eastoutside')
grid on
xlabel('Time [s]')
ylabel('P [MW]')