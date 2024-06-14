%%%%%----------Simulations parameters -------%%%%%
clear;close all;
%% System basic parameters

Ts = 20e-6;                             % Simulation time step (s)

% Basic parameters
fg = 50;                                   % AC grid frequency (Hz)
Sb = 100e6;                             % Base power (VA)
Vhv = 22e3;                            % AC grid voltage (rms, phase-to-phase)
Vmv = 22e3;                             % converter AC-side voltage (rms, phase-to-phase)
Vmvpk = Vmv*sqrt(2)/sqrt(3);    % MV phase-to-ground peak-to-peak
Vhvpk = Vhv*sqrt(2)/sqrt(3);     % HV phase-to-ground peak-to-peak  
Zbmv = Vmv^2/Sb;
Zbhv = Vhv^2/Sb;                     % Base impedance HV side (Ohm)
Ibhv = Sb/(sqrt(3)*Vhv);              % Base current HV side
Ihv = Sb/(Vhv*sqrt(3));
Ihvpk = Ihv*sqrt(2);

% Generator parameters
S0non = 1000e6; % SG 0 nominal power in VA



%% VSC
tonvsc = 0.01; % Time instant to connect the VSCs
%% Transformers
Xtpu = 0.15;             % Transformer reactance p.u
Rtpu = Xtpu/40;

%% VSC
Svsc = 200e6;
ksw1 = 27;                     % PWM frequency (number of times the AC frequency)
wsw1 = ksw1*2*pi*fg;           % Converter angular switching-frequency 
wc1 = wsw1/10;                 % current-loop bandwidth
wpq1 = wc1/10;                 % power-loop bandwidth
wdc1 = wc1/10;                 % DC voltage loop banddiwth

w_pll = 2*pi*80;                % PLL bandwidth
Iovc = 1.2;
%% Line parameters - Conductor ID 1

%klin = 3;                    % Transmission line length reduction factor

r1_id1 = 0.06862;                 % Positive-sequence resistance (Ohm/km)
r0_id1 = 0.39362;                 % Zero-sequence resistance (Ohm/km)
l1_id1 = 0.00128;   % Positive-sequence inductance (H/km)
l0_id1 = 0.00368;   % Zero-sequence inductance (H/km)
c1_id1 = 9.15905e-09;    % Positive-sequence capacitance (F/km)
c0_id1 = 6.57988e-09;   % Zero-sequence capacitance (F/km)
% %% VSC 1
tonvsc = 1e-3; % Time instant to connect the VSCs
Svsc = 100e6; % VSC nominal power 
ksw1 = 27;                           % Switching ratio (number of times the AC frequency)
wsw1 = ksw1*2*pi*fg;           % Converter angular switching-frequency 
wc1 = wsw1/10;                    % current-loop bandwidth
wpq1 = wc1/10;                     % power-loop bandwidth
wdc1 = wc1/10;                     % DC voltage loop banddiwth

Xtpu = 0.15;             % VSC Transformer reactance p.u
Rtpu = Xtpu/40;        % VSC Transformer resistance p.u

%% Problem1
%simTime=20;
% load_active_power       =S0non*0.5;
% load_inductive_power    =0;
% load_capacitive_power   =0;
% result_resistive=sim("Assign_Task1and2.slx");
% 
% load_active_power       =S0non*0.7;
% load_inductive_power    =S0non*0.3;
% load_capacitive_power   =0;
% result_inductive=sim("Assign_Task1and2.slx");
% 
% load_active_power       =S0non*0.7;
% load_inductive_power    =0;
% load_capacitive_power   =S0non*0.3;
% result_capacitive=sim("Assign_Task1and2.slx");

% figure(1);
% hold on;
% plot(result_resistive.generatorPe);
% plot(result_inductive.generatorPe);
% plot(result_capacitive.generatorPe);
% title("generator Pe");
% legend('50% resistive','70%+30% inductive','70%+30% capacitive');
% xlabel('time [seconds]') 
% ylabel('Power [psu VA]') 
% 
% figure(2);
% subplot(2,1,1);
% hold on;
% plot(result_resistive.t,result_resistive.loadpowerPQ.Data(:,1));
% plot(result_resistive.t,result_inductive.loadpowerPQ.Data(:,1));
% plot(result_resistive.t,result_capacitive.loadpowerPQ.Data(:,1));
% title("Load P");
% legend('50% resistive','70%+30% inductive','70%+30% capacitive');
% xlabel('time [seconds]') 
% ylabel('Power [W]')
% 
% subplot(2,1,2);
% hold on;
% plot(result_resistive.t,result_resistive.loadpowerPQ.Data(:,2));
% plot(result_resistive.t,result_inductive.loadpowerPQ.Data(:,2));
% plot(result_resistive.t,result_capacitive.loadpowerPQ.Data(:,2));
% title("Load Q");
% legend('50% resistive','70%+30% inductive','70%+30% capacitive');
% xlabel('time [seconds]') 
% ylabel('Power [VAR]')
% 
% figure(3);
% hold on;
% plot(result_resistive.wm);
% plot(result_inductive.wm);
% plot(result_capacitive.wm);
% title("Wm in pu");
% legend('50% resistive','70%+30% inductive','70%+30% capacitive');
% xlabel('time [seconds]') 
% ylabel('freq [pu rads/s]')
% hold off;
% 
% 
% 
% figure(4);
% simTime=1;
% for c = [10,30]
%     percentage_inductive=(c)/100;
%     load_active_power       =S0non*0.7;
%     load_inductive_power    =S0non*percentage_inductive;
%     load_capacitive_power   =0;
%     result_inductive=sim("Assign_Task1and2.slx");
%     hold on;
%     plot(result_inductive.wm);
%     title("Wm in pu (parametric)");
%     legend('10% inductive','30% inductive');
%     xlabel('time [seconds]') 
%     ylabel('freq [pu rad/s]')
% end
% 
% figure(5);
% simTime=10;
% for c = [10,30]
%     percentage_inductive=(c)/100;
%     load_active_power       =S0non*0.7;
%     load_inductive_power    =S0non*percentage_inductive;
%     load_capacitive_power   =0;
%     result_inductive=sim("Assign_Task1and2.slx");
%     hold on;
%     plot(result_inductive.generatorPe);
%     title("generatorPe (parametric)");
%     legend('10% inductive','30% inductive');    
%     xlabel('time [seconds]') 
%     ylabel('Power [pu w]')
% end
% 
% 
% figure(6);
% load_active_power       =S0non*0.5;
% load_inductive_power    =0;
% load_capacitive_power   =0;
% 
% for c = [10,30,50]
%     load_active_power       =S0non*c/100;
%     load_inductive_power    =0;
%     load_capacitive_power   =0;
%     result_resistive=sim("Assign_Task1and2.slx");
%     hold on;
%     plot(result_resistive.wm);
%     title("Wm in pu");
%     legend('10% resistive','30% resistive','50% resistive');
%     xlabel('time [seconds]') 
%     ylabel('freq [pu rads/s]')
% end


%hold off;
% %% problem2
% simTime=20;
% first_load_active_power       =S0non*0.5;
% first_load_inductive_power    =0;
% first_load_capacitive_power   =0;
% 
% external_load_active_power       =S0non*0.8;
% external_load_inductive_power    =0;
% external_load_capacitive_power   =0;
% 
% 
% 
%     figure(1);
% for c = [5,2]
%     hold on;
%     Shortcircuit_power=S0non*c;
%     result_resistive=sim("Assign_Task1and2.slx");
%     plot(result_resistive.wm);
%     title("Wm in pu");
%     legend('Shortcircuitpower x 5','Shortcircuitpower x 2');
%     xlabel('time [seconds]') 
%     ylabel('freq [pu rads/s]')
%     hold off;
% end
% 
%     figure(2);
% for c = [5,2]
%     hold on;
%     Shortcircuit_power=S0non*c;
%     result_resistive=sim("Assign_Task1and2.slx");
%     plot(result_resistive.pe);
%     title("Pe");
%     legend('Shortcircuitpower x 5','Shortcircuitpower x 2');
%     xlabel('time [seconds]') 
%     ylabel('Power [VA]')
% end
% 
%     figure(3);
% for c = [5,2]
%     Shortcircuit_power=S0non*c;
%     result_resistive=sim("Assign_Task1and2.slx");
% 
%     subplot(2,1,1);
%     hold on;
%     plot(result_resistive.t,result_resistive.pq.Data(:,1));
%     title("Load P");
%     legend('Shortcircuitpower x 5','Shortcircuitpower x 2');
%     xlabel('time [seconds]') 
%     ylabel('Power [W]')
% 
%     subplot(2,1,2);
%     hold on;
%     plot(result_resistive.t,result_resistive.pq.Data(:,2));
%     title("Load Q");
%     legend('Shortcircuitpower x 5','Shortcircuitpower x 2');
%     xlabel('time [seconds]') 
%     ylabel('Power [VAR]')
% end
% 
%     figure(4);
% for c = [5,2]
%     Shortcircuit_power=S0non*c;
%     result_resistive=sim("Assign_Task1and2.slx");
% 
%     subplot(2,1,1);
%     hold on;
%     plot(result_resistive.tm);
%     title("Tm");
%     legend('Shortcircuitpower x 5','Shortcircuitpower x 2');
%     xlabel('time [seconds]') 
%     ylabel('Torque [Nm]')
% 
%     subplot(2,1,2);
%     hold on;
%     plot(result_resistive.efd);
%     title("edf");
%     legend('Shortcircuitpower x 5','Shortcircuitpower x 2');
%     xlabel('time [seconds]') 
%     ylabel('volts [v]')
% end

%% problem3
% simTime=5;
% first_load_active_power       =S0non*0.4;
% first_load_inductive_power    =0;
% first_load_capacitive_power   =0;
% 
% 
% 
%     figure(1);
% for generator_inertia = 6:-0.5:0.5
%     result_resistive=sim("Assign_Task3and4.slx");
%     subplot(2,2,1);
%     hold on;
%     plot(result_resistive.wm);
%     title("wm in pu");
%     legend('generator inertia=6','generator inertia=5,5','generator inertia=5','generator inertia=4,5','generator inertia=4','generator inertia=3,5','generator inertia=3','generator inertia=2,5','generator inertia=2','generator inertia=1,5','generator inertia=1','generator inertia=0,5');
%     xlabel('time [seconds]') 
%     ylabel('wm [pu rad/s]')
% 
%     subplot(2,2,3);
%     hold on;
%     plot(result_resistive.pm);
%     title("Mechanical Power from the generator");
%     legend('generator inertia=6','generator inertia=5,5','generator inertia=5','generator inertia=4,5','generator inertia=4','generator inertia=3,5','generator inertia=3','generator inertia=2,5','generator inertia=2','generator inertia=1,5','generator inertia=1','generator inertia=0,5');
%     xlabel('time [seconds]') 
%     ylabel('Power [W]')
% 
%     subplot(2,2,2);
%     hold on;
%     plot(result_resistive.p);
%     title("Bus active power P");
%     legend('generator inertia=6','generator inertia=5,5','generator inertia=5','generator inertia=4,5','generator inertia=4','generator inertia=3,5','generator inertia=3','generator inertia=2,5','generator inertia=2','generator inertia=1,5','generator inertia=1','generator inertia=0,5');
%     xlabel('time [seconds]') 
%     ylabel('Power [W]')
% 
%     subplot(2,2,4);
%     hold on;
%     plot(result_resistive.q);
%     title("Bus reactive power Q");
%     legend('generator inertia=6','generator inertia=5,5','generator inertia=5','generator inertia=4,5','generator inertia=4','generator inertia=3,5','generator inertia=3','generator inertia=2,5','generator inertia=2','generator inertia=1,5','generator inertia=1','generator inertia=0,5');
%     xlabel('time [seconds]') 
%     ylabel('Power [VAR]')
% 
% end
% %% problem4
% 
% average_active=S0non*0.3;
% average_reactive=S0non*0.1;
% 
% simTime=10;
% first_load_active_power       =S0non*0.4;
% first_load_inductive_power    =0;
% first_load_capacitive_power   =0;
% 
%     figure(1);
% for generator_inertia = [6,3]
%     result_resistive=sim("Assign_Task3and4.slx");
%     subplot(3,1,1);
%     hold on;
%     plot(result_resistive.wm);
%     title("wm in pu");
%     legend('generator inertia=6','generator inertia=3');
%     xlabel('time [seconds]') 
%     ylabel('wm [pu rad/s]')
% 
%     subplot(3,1,2);
%     hold on;
%     plot(result_resistive.edf);
%     title("Edf");
%     legend('generator inertia=6','generator inertia=3');
%     xlabel('time [seconds]') 
%     ylabel('Voltage [v]')
% 
%     subplot(3,1,3);
%     hold on;
%     plot(result_resistive.q);
%     title("Q");
%     legend('generator inertia=6','generator inertia=3');
%     xlabel('time [seconds]') 
%     ylabel('reactive pwoer [VAR]')
% 
% end

%% problem5
simTime=60;

generator_inertia=5;

average_active=S0non*0.3;
average_reactive=S0non*0.1;





for R = [0.1,0.05,0.02]
    kp=1/R;%
    ki=0;
    kd=0;

    result_resistive=sim("Assign_Task3and4.slx");
    subplot(2,2,1);
    hold on;
    plot(result_resistive.wm);
    title("wm in pu");
    legend('R=10%','R=5%','R=2%');
    xlabel('time [seconds]') 
    ylabel('wm [pu rad/s]')

    subplot(2,2,2);
    hold on;
    plot(result_resistive.p);
    title("P");
    legend('R=10%','R=5%','R=2%');
    xlabel('time [seconds]') 
    ylabel('active power [w]')

    subplot(2,2,3);
    hold on;
    plot(result_resistive.q);
    title("Q");
    legend('R=10%','R=5%','R=2%');
    xlabel('time [seconds]') 
    ylabel('reactive pwoer [VAR]')

    subplot(2,2,4);
    hold on;
    plot(result_resistive.pe);
    title("Pe");
    legend('R=10%','R=5%','R=2%');
    xlabel('time [seconds]') 
    ylabel('Power [VA]')

end
% 
figure(2);
R=0.05;% Droop rate characteritic
kp=1/R;%
ki=0;
kd=0;

for generator_inertia = [10,6,3]


    result_resistive=sim("Assign_Task3and4.slx");
    subplot(2,2,1);
    hold on;
    plot(result_resistive.wm);
    title("wm in pu");
    legend('generator inertia=10','generator inertia=6','generator inertia=3');
    xlabel('time [seconds]') 
    ylabel('wm [pu rad/s]')

    subplot(2,2,2);
    hold on;
    plot(result_resistive.p);
    title("P");
    legend('generator inertia=10','generator inertia=6','generator inertia=3');
    xlabel('time [seconds]') 
    ylabel('active power [w]')

    subplot(2,2,3);
    hold on;
    plot(result_resistive.q);
    title("Q");
    legend('generator inertia=10','generator inertia=6','generator inertia=3');
    xlabel('time [seconds]') 
    ylabel('reactive pwoer [VAR]')

    subplot(2,2,4);
    hold on;
    plot(result_resistive.pe);
    title("Pe");
    legend('generator inertia=10','generator inertia=6','generator inertia=3');
    xlabel('time [seconds]') 
    ylabel('Power [VA]')

end

