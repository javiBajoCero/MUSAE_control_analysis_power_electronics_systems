%%%%%%%%-------------- System parameters-------------%%%%%%%%%
%(Variables to update)
Ts = 10e-6;      % Simulation time step (10 us for EMT and 150 us for Phasor)
dec = 10;        % decimation before exporting to workspace
simtime=5;
%%
fg = 50;        % Power frequency (Hz)
Sb = 100e6;     % System base power (VA)
Vmv = 22e3;     % Nominal MV (LL-RMS)
Vhv = 220e3;    % Nominal HV (LL-RMS)
Ihv = Sb/(Vhv*sqrt(3));
Ihvpk = Ihv*sqrt(2);
%% Sources
tonvsc = 0.01; % Time instant to connect the VSCs

% Nominal values (W)
S1non = 400e6;
S2non = 300e6;
S3non = 200e6;
S4snon = 200e6;
S5non = 500e6;
S6non = 400e6;
S6snon = 200e6;
S7non = 200e6;

% "Instantaneous generation (p.u)"
G1gen = 0.1245;   %    (400 MW nominal)
G2gen = 0.30;   % WF (300 MW nominal)
G3gen = 0.20;   % PV (200 MW nominal)
G4sgen = 0.2078;  % ST (200 MW nominal)
G5gen = 0.20;   % WF (300 MW nominal)
G6gen = 0.2078;   % PV (400 MW nominal)
G6sgen = 0.20;  % ST (200 MW nominal)
G7gen = 0.518;   % SG (200 MW nominal)

%% Transformers
Xtpu = 0.15;             % Transformer reactance p.u
Rtpu = Xtpu/40;

%% VSCs
% VSC 1
ksw1 = 27;                           % Switching ratio (number of times the AC frequency)
wsw1 = ksw1*2*pi*fg;           % Converter angular switching-frequency 
wc1 = wsw1/10;                    % current-loop bandwidth
wpq1 = wc1/10;                     % power-loop bandwidth
wdc1 = wc1/10;                     % DC voltage loop banddiwth

w_pll = 2*pi*80;
k_droop_f = 5;
k_droop_v = 2;
Iovc = 1.2;
%% Loads
% System base Load
Sr = 579e6; % Base apparent power (VA)
PF = 0.95; % Power factor
Pr = Sr*PF; % Base active power (W)
Qr = sqrt(Sr^2 - Pr^2); % Base reactive power (Var)

% Individual loads demands (p.u)
L3dem = 0.10;
L4dem = 0.30;
L5dem = 0.35;
L6dem = 0.15;
L7dem = 0.10;

%% Conductors
% Zebra ACSR with Cigré TB 575 Tower configuration and earth wire.
r1_zeb = 0.06862;   % ohm/km
r0_zeb = 0.39362;   % ohm/km
l1_zeb = 0.00128;    % H/km
l0_zeb = 0.00368;    % H/km
c1_zeb = 9.15905e-09;    %F/km
c0_zeb = 6.57988e-09;    % F/km

r1_hawk = 0.12087;   % ohm/km
r0_hawk = 0.44587;   % ohm/km
l1_hawk = 0.00133;    % H/km
l0_hawk = 0.00373;    % H/km
c1_hawk = 8.76156e-09;    %F/km
c0_hawk = 6.37282e-09;    % F/km

r1 = r1_hawk;
r0= r0_hawk;
l1= l1_hawk; 
l0= l0_hawk;
c1= c1_hawk;
c0= c0_hawk;
%%
% disp('EMT_load.slx Ts=10us, t=5seconds')
% tic;
% model_emt=sim('EMT_load.slx');
% toc
% 
% disp('Phasor_load.slx Ts=10us, t=5seconds')
% tic;
% model_phasor=sim('Phasor_load.slx');
% toc
% 
% figure(1);
% subplot(3,1,1);
% hold on;
% plot(model_phasor.phasor_Vg6);
% plot(model_emt.emt_Vg6);
% title("Voltage at the bus of  the synch gen6 + Power converter 6");
% legend('phasor model','emt model');
% xlabel('time [seconds]') 
% ylabel('V [volts]')
% 
% subplot(3,1,2);
% hold on;
% plot(model_phasor.phasor_Ig6pv);
% plot(model_emt.emt_Ig6pv);
% title("Current output from power converter 6");
% legend('phasor model','emt model');
% xlabel('time [seconds]') 
% ylabel('I [Amps]')
% 
% subplot(3,1,3);
% hold on;
% plot(model_phasor.phaser_Te6s);
% plot(model_emt.emt_Te6s);
% title("Torque present at synch generator 6");
% legend('phasor model','emt model');
% xlabel('time [seconds]') 
% ylabel('T [pu]')
% 
% Ts = 150e-6;      % Simulation time step (10 us for EMT and 150 us for Phasor)
% disp('Phasor_load.slx Ts=150us, t=5seconds')
% tic;
% model_phasor150=sim('Phasor_load.slx');
% toc
% 
% figure(2);
% subplot(3,1,1);
% hold on;
% plot(model_phasor.phasor_Vg6);
% plot(model_phasor150.phasor_Vg6);
% title("Voltage at the bus of  the synch gen6 + Power converter 6");
% legend('phasor model T=10us','phasor model T=150us');
% xlabel('time [seconds]') 
% ylabel('V [volts]')
% 
% subplot(3,1,2);
% hold on;
% plot(model_phasor.phasor_Ig6pv);
% plot(model_phasor150.phasor_Ig6pv);
% title("Current output from power converter 6");
% legend('phasor model T=10us','phasor model T=150us');
% xlabel('time [seconds]') 
% ylabel('I [Amps]')
% 
% subplot(3,1,3);
% hold on;
% plot(model_phasor.phaser_Te6s);
% plot(model_phasor150.phaser_Te6s);
% title("Torque present at synch generator 6");
% legend('phasor model T=10us','phasor model T=150us');
% xlabel('time [seconds]') 
% ylabel('T [pu]')
% 
% figure(3);
% subplot(3,1,1);
% hold on;
% plot(model_phasor150.phasor_Vg6);
% plot(model_emt.emt_Vg6);
% title("Voltage at the bus of  the synch gen6 + Power converter 6");
% legend('phasor model T=150us','EMT model T=10us');
% xlabel('time [seconds]') 
% ylabel('V [volts]')
% 
% subplot(3,1,2);
% hold on;
% plot(model_phasor150.phasor_Ig6pv);
% plot(model_emt.emt_Ig6pv);
% title("Current output from power converter 6");
% legend('phasor model T=150us','EMT model T=10us');
% xlabel('time [seconds]') 
% ylabel('I [Amps]')
% 
% subplot(3,1,3);
% hold on;
% plot(model_phasor150.phaser_Te6s);
% plot(model_emt.emt_Te6s);
% title("Torque present at synch generator 6");
% legend('phasor model T=150us','EMT model T=10us');
% xlabel('time [seconds]') 
% ylabel('T [pu]')



%
disp('EMT_G1.slx Ts=10us, t=5seconds')
tic;
model_emt=sim('EMT_G1.slx');
toc

disp('Phasor_G1.slx Ts=10us, t=5seconds')
tic;
model_phasor=sim('Phasor_G1.slx');
toc

figure(1);
subplot(3,1,1);
hold on;
plot(model_phasor.phasor_Vg6);
plot(model_emt.emt_Vg6);
title("Voltage at the bus of  the synch gen6 + Power converter 6");
legend('phasor model','emt model');
xlabel('time [seconds]') 
ylabel('V [volts]')

subplot(3,1,2);
hold on;
plot(model_phasor.phasor_Ig6pv);
plot(model_emt.emt_Ig6pv);
title("Current output from power converter 6");
legend('phasor model','emt model');
xlabel('time [seconds]') 
ylabel('I [Amps]')

subplot(3,1,3);
hold on;
plot(model_phasor.phaser_Te6s);
plot(model_emt.emt_Te6s);
title("Torque present at synch generator 6");
legend('phasor model','emt model');
xlabel('time [seconds]') 
ylabel('T [pu]')

Ts = 150e-6;      % Simulation time step (10 us for EMT and 150 us for Phasor)
disp('Phasor_G1.slx Ts=150us, t=5seconds')
tic;
model_phasor150=sim('Phasor_G1.slx');
toc

figure(2);
subplot(3,1,1);
hold on;
plot(model_phasor.phasor_Vg6);
plot(model_phasor150.phasor_Vg6);
title("Voltage at the bus of  the synch gen6 + Power converter 6");
legend('phasor model T=10us','phasor model T=150us');
xlabel('time [seconds]') 
ylabel('V [volts]')

subplot(3,1,2);
hold on;
plot(model_phasor.phasor_Ig6pv);
plot(model_phasor150.phasor_Ig6pv);
title("Current output from power converter 6");
legend('phasor model T=10us','phasor model T=150us');
xlabel('time [seconds]') 
ylabel('I [Amps]')

subplot(3,1,3);
hold on;
plot(model_phasor.phaser_Te6s);
plot(model_phasor150.phaser_Te6s);
title("Torque present at synch generator 6");
legend('phasor model T=10us','phasor model T=150us');
xlabel('time [seconds]') 
ylabel('T [pu]')

figure(3);
subplot(3,1,1);
hold on;
plot(model_phasor150.phasor_Vg6);
plot(model_emt.emt_Vg6);
title("Voltage at the bus of  the synch gen6 + Power converter 6");
legend('phasor model T=150us','EMT model T=10us');
xlabel('time [seconds]') 
ylabel('V [volts]')

subplot(3,1,2);
hold on;
plot(model_phasor150.phasor_Ig6pv);
plot(model_emt.emt_Ig6pv);
title("Current output from power converter 6");
legend('phasor model T=150us','EMT model T=10us');
xlabel('time [seconds]') 
ylabel('I [Amps]')

subplot(3,1,3);
hold on;
plot(model_phasor150.phaser_Te6s);
plot(model_emt.emt_Te6s);
title("Torque present at synch generator 6");
legend('phasor model T=150us','EMT model T=10us');
xlabel('time [seconds]') 
ylabel('T [pu]')