%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grid-following/grid-forming 2L-VSC + SG
% Date: 14/11/2021
% =========================================================================
clear; 
clc
% =========================================================================

%% AC grid 1: Thevenin equivalent 
Sn1=500e6;              % Base power
Un1=320e3;              % Base AC voltage
Vpeak = Un1*sqrt(2/3);  % Peak single phase voltage
Ipeak_n1=sqrt(2)*Sn1/Un1;
f1=50;                  % Base frequency
w_g1=2*pi*f1;           % Base frequency
Vdcref_n1=640e3;        % DC grid: ideal

%% AC Line impedance definition
np = 1;                 % number of parallel lines
l = 50;                 % km
Lpu = 1e-3/np;          % 1 mH/km;
Rpu = 0.03/np;          % 0.03 ohm/km
Vl = 220e3;             % Parameters at 220 kV
Lac = Lpu*l*(Un1/Vl)^2;
Rac = Rpu*l*(Un1/Vl)^2;

%% Simulation time step
Ts = 5e-5;

%% Other parameters
sat_current=1.15;        % Current saturation
epsilon=1;              % Used for the current saturation
v_ini=1e-5;             % Initialization voltages
magnitud_delay=Ts;    % Constant delay for simulation    
plots_step=Ts;        % Plot samples step 

%% 2L-VSC - Grid forming

Sn_n1=Sn1;                          % Base power
cosfi_n1=1;
f_n1=f1;
w_n1=2*pi*f_n1;
Un_n1=Un1;                          % Line-line voltage
Vpeak_n1=Un_n1/sqrt(3)*sqrt(2);     % Peak voltage
Xn_n1=Un_n1^2/Sn_n1;                % Base impedance
Ln_n1=Xn_n1/(2*pi*f_n1);            % Base inductance

Rc_n1=0.01*Xn_n1;                   % Converter grid coupling filter resistance
Lc_n1=0.2*Ln_n1;                    % Converter grid coupling filter inductance
Cac_n1=1/5.88*(1/(w_n1*Xn_n1));     % Converter grid coupling filter capacitance

vaini_n1=Vpeak_n1;                  % PCC initial voltages
vbini_n1=-1/2*Vpeak_n1;
vcini_n1=-1/2*Vpeak_n1;

P_ref_n1=-200e6;
Q_ref_n1=10e6;

% Current control
taus=1e-3;
kp_s_n1=Lc_n1/taus;
ki_s_n1=Rc_n1/taus;

% AC voltage tuning: 
xi_vac=0.707;
wn_vac=2*pi*1/taus/10;
kp_vac_n1=2*Cac_n1*xi_vac*wn_vac;
ki_vac_n1=wn_vac^2*Cac_n1;
kp_vac_n1=0.025;
ki_vac_n1=0.5;
% kp_vac_n1=2/Vpeak_n1*Ipeak_n1;
% ki_vac_n1=600/Vpeak_n1*Ipeak_n1;

% Voltage feedforward filters
tau_u=40e-3;
tau_ig=40e-3;

% Droop parameters
k_droop_f_n1=0.05;
tau_droop_f=0.1;%40e-3;
k_droop_u_n1=1e-4;
tau_droop_u=40e-3;

%% 2L-VSC - Grid following

Sn_n2=Sn1;                          % Base power
f_n2=f1;                            % Frequency
w_n2=2*pi*f_n2;                     % Frequency
Un_n2=Un1;                          % Line-line voltage
Vpeak_n2=Un_n2/sqrt(3)*sqrt(2);     % Peak voltage
Inom_n2 = Sn_n2/Un_n2/sqrt(3);      % Rated current
Xn_n2=Un_n2^2/Sn_n2;                % Base impedance
Ln_n2=Xn_n2/(2*pi*f_n2);            % Base inductance

Rc_n2=0.01*Xn_n2;                   % Converter grid coupling filter resistance
Lc_n2=0.2*Ln_n2;                    % Converter grid coupling filter inductance
    
%P_ref_n2=-200e6;                   % Defined power P/Q (below)
Q_ref_n2=0e6;

% PLL tuning
ts_pll_n2=0.025;
xi_pll_n2=0.707;
omega_pll_n2=4/(ts_pll_n2*xi_pll_n2);
kp_pll_n2=xi_pll_n2*2*omega_pll_n2/Vpeak_n2;
tau_pll_n2=2*xi_pll_n2/omega_pll_n2;
ki_pll_n2=kp_pll_n2/tau_pll_n2;

% Current control
taus_n2=1e-3;
kp_s_n2=Lc_n2/taus_n2;
ki_s_n2=Rc_n2/taus_n2;
tau_u=40e-3; % feedforward filters

% Power PQ loop parameters
tau_p = 0.2;
kp_p_n2 = taus_n2/tau_p;
ki_p_n2 = 1/tau_p;
tau_fp = 20e-3;

tau_q = 0.2;
kp_q_n2 = taus_n2/tau_q;
ki_q_n2 = 1/tau_q;
tau_fq = 20e-3;

% Droop parameters
k_droop_f_n2=1/0.05;
tau_droop_fpll=0.1;

% PLL tuning parameters
ts_pll_n1=0.025;
xi_pll_n1=0.707;
omega_pll_n1=4/(ts_pll_n1*xi_pll_n1);
kp_pll1=xi_pll_n1*2*omega_pll_n1/Vpeak;
tau_pll_n1=2*xi_pll_n1/omega_pll_n1;
ki_pll1=kp_pll1/tau_pll_n1;

%% Synchronous generator
% Machine parameters from Kundur Examples 3.1, 3.2,  8.1 (pages 91,102, 345)
% "Power System Stability and Control"  McGraw-Hill  book, 1994
% --------------------------------------------------------------------

% Nominal parameters
Ssg = 500e6;
Pn= Ssg;   % three-phase nominal power (VA)
Vsg=  Un1;%Un1;    % nominal LL voltage (Vrms)

% Electrical machine (Standard parameters in pu)
Ld_pu = 1.66;
Lq_pu = 1.61;
Ll_pu = 0.15;
Rs_pu = 0.003;

Lmd_pu = Ld_pu-Ll_pu;
Lmq_pu = Lq_pu-Ll_pu;

Lfd_pu = 0.165;
Rf_pu = 0.0006;

L1d_pu = 0.1713;
R1d_pu = 0.0284;

L1q_pu = 0.7252;
R1q_pu = 0.00619;

L2q_pu = 0.125;
R2q_pu = 0.002368;


Llkd_pu = 0.1713;
Rkd_pu = 0.0284;

Llkq1_pu= 0.7252;
Rkq1_pu = 0.00619;

Llkq2_pu = 0.125;
Rkq2_pu = 0.002368;

% Stator base values
wbase=2*pi*f1;
Vsbase=Vsg/sqrt(3)*sqrt(2);
Isbase=Pn/Vsg/sqrt(3)*sqrt(2);
Zsbase=Vsg^2/Pn;
Lsbase=Zsbase/wbase;

%Stator RL parameters (SI)
Rs= Rs_pu*Zsbase; %0.0031;     % resistance (ohms)
Ll= Ll_pu*Lsbase; %0.4129e-3;  % leakage inductance (H) 
Lmd=Lmd_pu*Lsbase; %4.5696e-3;  % d-axis magnetizing inductance (H)  
Lmq=Lmq_pu*Lsbase; %4.432e-3;   % q-axis magnetizing inductance (H)

% Field base values
% Lfd = Lfd_pu*Lsbase; 
ifn = sqrt(2/3)*Vsg/Lfd_pu/wbase;
Ifbase=ifn*Lmd_pu;
Vfbase=Pn/Ifbase;
Zfbase=Vfbase/Ifbase;
Lfbase=Zfbase/wbase;

% Field RL parameters (SI)
Rf= Rf_pu*Zfbase; %0.0715;    %  resistance (ohms)
Llfd= Lfd_pu*Lfbase; %0.57692; %  self inductance (H)

% Transformation ratio Ns/Nf
Ns_Nf=2/3*Ifbase/Isbase;

% Field parameters referred to the stator
Rf_prime=Rf*3/2*Ns_Nf^2;
Llfd_prime=Llfd*3/2*Ns_Nf^2;

% Damper RL parameters from Kundur Example 3.2 
Rkd   = R1d_pu*Zsbase; 
Llkd  = L1d_pu*Lsbase; 
Rkq1  = R1q_pu*Zsbase;  
Llkq1 = L1q_pu*Lsbase; 
Rkq2  = R2q_pu*Zsbase;  
Llkq2 = L2q_pu*Lsbase;
            
% Nominal field voltage
Vfn=Rf*ifn;
% Nominal field voltage and current referred to stator
Vfn_prime=Rf_pu/Lmd_pu*Vsbase;
Ifn_prime=Isbase/Lmd_pu;

% Inertia
H= 4.5; % sec
wm= w_g1; %rad/s
J= 2*H*Pn/wm^2; % kg.m^2

% Droop SG + turbine
kfd_sg_pu = 1/0.05; %SG droop gain (MW/Hz)
kfd_sg = Pn/(50*0.05); %SG droop gain (MW/Hz)
Khp = 0.25; %High pressure turbine fraction (instantaneous mech. power)
Klp = 1-Khp; %Low pressure turbine fraction (filtered mech. power)
tau_lp = 5; %Time constant for the low pressure turbine

t1 = 4;%0.1;

%Exciter SG
TR = 0;
VImin = -10; %pu Lower limint on error signal
VImax = 10; %pu Upper limit on error signal
TC = 1; % [s] Lead time constant
TB = 10; %[s] Lag time constant
KA = 200; %[pu]
TA = 0.015; %[s] Regulator time constant
VRmin = -4.53; %[pu] Minimum output
VRmax = 5.64; %[pu] Maximum regulator
s = tf('s');
tfexc = ((TC*s+1)/(TB*s+1)*KA/(TA*s+1))*(Rf_pu/Lmd_pu*Vsbase);
[Aexc,Bexc,Cexc,Dexc] = tf2ss(tfexc.num{1,1},tfexc.den{1,1});

%% Scenario configuration
Pload0= 400e6; % Power for the impedance load
Pload1= 100e6; % Increase of power for the impedance load
Pload_fnl=400e6; 

Psg0 = 200e6;%Pn*0.7; % Pref for the SG at 50 Hz
Psg0_pu = Psg0/Pn;

Pvsc0 = Pload0 -Psg0; %Pref for the VSC at 50 Hz

Tsim=40;
T_stp=20;%Tsim/2;

Vpeak_g1_init=Vpeak_n2;  %change in grid nom voltage in p.u
Vpeak_g1_fnl=Vpeak_n2;%*0.97;

angle_g1_init=0.0; %change in grid angle
angle_g1_fnl=0.0; 

%%
% result_following=sim("SG_GFOL_2020a.slx");
% result_forming=sim("SG_GFOR_2020a.slx");
% 
% subplot(2,1,1);
% hold on;
% plot(powerfollowing);
% plot(powerforming);
% title("Power response against load changes");
% legend('Grid following Power','Grid forming Power');
% xlabel('time [seconds]') 
% ylabel('P [VA]')
% 
% subplot(2,1,2);
% hold on;
% plot(wfollowing);
% plot(wforming);
% title("Freq response against load changes");
% legend('Grid following freq','Grid forming freq');
% xlabel('time [seconds]') 
% ylabel('frequency [rad/s]')

%%

% for H = [1,5,10]
% result_following=sim("SG_GFOL_2020a.slx");
% subplot(2,1,1);
% hold on;
% plot(powerfollowing);
% title("Power response against load changes");
% legend('H=1','H=5','H=10');
% xlabel('time [seconds]') 
% ylabel('P [VA]')
% 
% subplot(2,1,2);
% hold on;
% plot(wfollowing);
% title("Freq response against load changes");
% legend('H=1','H=5','H=10');
% xlabel('time [seconds]') 
% ylabel('frequency [rad/s]')
% 
% end


%%
% H=5;
% 
% for k_droop_f_n2 = [15,20,25]
%     result_following=sim("SG_GFOL_2020a.slx");
%     subplot(2,1,1);
%     hold on;
%     plot(powerfollowing);
%     title("Power response against load changes");
%     legend('Kdroop=15','Kdroop=20','Kdroop=25');
%     xlabel('time [seconds]') 
%     ylabel('P [VA]')
% 
%     subplot(2,1,2);
%     hold on;
%     plot(wfollowing);
%     title("Freq response against load changes");
%     legend('Kdroop=15','Kdroop=20','Kdroop=25');
%     xlabel('time [seconds]') 
%     ylabel('frequency [rad/s]')
% 
% end

% %%
% for H = [1,5,10]
% result_following=sim("SG_GFOR_2020a.slx");
% subplot(2,1,1);
% hold on;
% plot(powerforming);
% title("Power response against load changes");
% legend('H=1','H=5','H=10');
% xlabel('time [seconds]') 
% ylabel('P [VA]')
% 
% subplot(2,1,2);
% hold on;
% plot(wforming);
% title("Freq response against load changes");
% legend('H=1','H=5','H=10');
% xlabel('time [seconds]') 
% ylabel('frequency [rad/s]')
% 
% end


H=5;

% for k_droop_f_n1 = [1/15,1/20,1/25]
%     result_following=sim("SG_GFOR_2020a.slx");
%     subplot(2,1,1);
%     hold on;
%     plot(powerforming);
%     title("Power response against load changes");
%     legend('Kdroop=6,6%','Kdroop=5%','Kdroop=4%');
%     xlabel('time [seconds]') 
%     ylabel('P [VA]')
% 
%     subplot(2,1,2);
%     hold on;
%     plot(wforming);
%     title("Freq response against load changes");
%     legend('Kdroop=6,6%','Kdroop=5%','Kdroop=4%');
%     xlabel('time [seconds]') 
%     ylabel('frequency [rad/s]')
% 
% end

k_droop_f_n1=1/20;

% for i = [0.1,1,10]
% 
%     Xn_n1=Un_n1^2/Sn_n1;                % Base impedance
%     Ln_n1=Xn_n1/(2*pi*f_n1);            % Base inductance
%     Rc_n1=0.01*Xn_n1;                   % Converter grid coupling filter resistance
%     Lc_n1=0.2*i*Ln_n1;                    % Converter grid coupling filter inductance
%     Cac_n1=1/5.88*(1/(w_n1*Xn_n1));     % Converter grid coupling filter capacitance
% 
%     result_following=sim("SG_GFOR_2020a.slx");
%     subplot(2,1,1);
%     hold on;
%     plot(powerforming);
%     title("Power response against load changes");
%     legend('Filter L=10%','Filter L=100%','Filter L=1000%');
%     xlabel('time [seconds]') 
%     ylabel('P [VA]')
% 
%     subplot(2,1,2);
%     hold on;
%     plot(wforming);
%     title("Freq response against load changes");
%     legend('Filter L=10%','Filter L=100%','Filter L=1000%');
%     xlabel('time [seconds]') 
%     ylabel('frequency [rad/s]')
% 
% end



P_ref_n2=1e6;


%%
% for k = [10,100,1000]
% result_following=sim("SG_GFOL_2020a.slx");
% subplot(2,1,1);
% hold on;
% plot(powerfollowing);
% title("Power response against load changes");
% legend('k=10','k=100','k=1000');
% xlabel('time [seconds]') 
% ylabel('P [VA]')
% 
% subplot(2,1,2);
% hold on;
% plot(wfollowing);
% title("Freq response against load changes");
% legend('k=10','k=100','k=1000');
% xlabel('time [seconds]') 
% ylabel('frequency [rad/s]')
% 
% end