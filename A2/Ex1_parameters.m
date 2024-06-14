clear all
close all
clc
%% System parameters definition

kdroop=0.05;                 % 5 percent droop characteristic curve (also detailed as R in the slides)
Sb=500e6;                    % Base system power 
tau_gen=5;                   % Generator turbine time constant           
Ho=5;                        % Base inertia constant (s)
w=2*pi*50;                   % Base frequency
sp=1/kdroop*Sb/w;            % Droop characteristic curve (MW/(rad/s)

fixed_tau_gen=5;
fixed_kdroop=0.05;
%% Running the different models

ii=0;
for H=Ho*[0.5,1,2,5]
    
J=H*2*Sb/(w)^2;              % Moment of inertia (calculation based on H)
M=J*w;                       % Moment of inertia x nominal speed
ii=ii+1;                     % Iteration number
    
    % Simulating the model
    model=sim('Ex1_inertia_2020a')
    % Ploting figures
    f1 = figure(1); set(f1, 'Position', [50 500 500 250]);
    title('Load decrease impact on frequency - Different H values')
    hold all
    plot(model.frequency_sc0.time,model.frequency_sc0.signals.values,'Linewidth',2);
    xlabel('Time [s]','Interpreter','latex','FontSize',12);
    ylabel('Frequency (pu)','Interpreter','latex','FontSize',12);
    txt{ii}=['H=' num2str(H)]
    l1=legend(txt)
    set(l1,'Interpreter','latex','FontSize',12,'Location','NorthEast'); 
    
    f2 = figure(2); set(f2, 'Position', [50 500 500 250]); 
    title('Load increase impact on frequency - Different H values')
    hold all
    plot(model.frequency_sc1.time,model.frequency_sc1.signals.values,'Linewidth',2);
    xlabel('Time [s]','Interpreter','latex','FontSize',12);
    ylabel('Frequency (pu)','Interpreter','latex','FontSize',12);
    l2=legend(txt)
    set(l2,'Interpreter','latex','FontSize',12,'Location','NorthEast'); 
    
    f3 = figure(3); set(f3, 'Position', [50 500 500 250]); 
    title('Load increase impact on frequency - Different H values + droop')
    hold all
    plot(model.frequency_sc2.time,model.frequency_sc2.signals.values,'Linewidth',2);
    xlabel('Time [s]','Interpreter','latex','FontSize',12);
    ylabel('Frequency (pu)','Interpreter','latex','FontSize',12);
    l3=legend(txt)
    set(l3,'Interpreter','latex','FontSize',12,'Location','NorthEast'); 
    
    f4 = figure(4); set(3, 'Position', [50 500 500 250]);
    title('Load increase impact on frequency - Different H values + droop')
    hold all
    plot(model.frequency_sc3.time,model.frequency_sc3.signals.values,'Linewidth',2);
    xlabel('Time [s]','Interpreter','latex','FontSize',12);
    ylabel('Frequency (pu)','Interpreter','latex','FontSize',12);
    l3=legend(txt)
    set(l3,'Interpreter','latex','FontSize',12,'Location','NorthEast'); 
    
    f10 = figure(10); set(f10, 'Position', [50 500 500 250]);
    hold all
    plot(model.frequency_sc10.time,model.frequency_sc10.signals.values/w,'Linewidth',2);
    xlabel('Time [s]','Interpreter','latex','FontSize',12);
    ylabel('Frequency (pu)','Interpreter','latex','FontSize',12);
    l10=legend(txt)
    set(l10,'Interpreter','latex','FontSize',10,'Location','NorthEast'); 
    
    f11 = figure(11); set(f11, 'Position', [50 500 500 250]);
    hold all
    title('Load increase impact on frequency - Different H values + droop + Two machines')
    plot(model.frequency_sc11.time,model.frequency_sc11.signals.values/w,'Linewidth',2);
    xlabel('Time [s]','Interpreter','latex','FontSize',12);
    ylabel('Frequency (pu)','Interpreter','latex','FontSize',12);
    l11=legend(txt)
    set(l11,'Interpreter','latex','FontSize',12,'Location','NorthEast'); 
end 

ii=0;
H=Ho*0.5;
for tau_gen=[1,2,3,4,5]
    
J=H*2*Sb/(w)^2;              % Moment of inertia (calculation based on H)
M=J*w;                       % Moment of inertia x nominal speed
ii=ii+1;                     % Iteration number
    
 txt{ii}=['tau_gen=' num2str(tau_gen)];

    % Simulating the model
    model=sim('Ex1_inertia_2020a');
    % Ploting figures
    f100 = figure(100); set(f100, 'Position', [50 500 500 250]); 
    title('Load increase impact on frequency - Different tau values + droop')
    hold all
    plot(model.frequency_sc2.time,model.frequency_sc2.signals.values,'Linewidth',2);
    xlabel('Time [s]','Interpreter','latex','FontSize',12);
    ylabel('Frequency (pu)','Interpreter','latex','FontSize',12);
    l100=legend(txt);
    set(l3,'Interpreter','latex','FontSize',12,'Location','NorthEast'); 
    
end 


ii=0;
H=Ho*0.5;
tau_gen=5;

for kdroop=[0.05,0.1,0.15,0.2,0.25]
    
J=H*2*Sb/(w)^2;              % Moment of inertia (calculation based on H)
M=J*w;                       % Moment of inertia x nominal speed
ii=ii+1;                     % Iteration number
    
 txt{ii}=['kdroop=' num2str(kdroop)];

    % Simulating the model
    model=sim('Ex1_inertia_2020a');
    % Ploting figures
    f101 = figure(101); set(f101, 'Position', [50 500 500 250]); 
    title('Load increase impact on frequency - Different K droop values + droop')
    hold all
    plot(model.frequency_sc2.time,model.frequency_sc2.signals.values,'Linewidth',2);
    xlabel('Time [s]','Interpreter','latex','FontSize',12);
    ylabel('Frequency (pu)','Interpreter','latex','FontSize',12);
    l101=legend(txt);
    set(l101,'Interpreter','latex','FontSize',12,'Location','NorthEast'); 
    
end 










ii=0;
tau_gen=5;
kdroop=0.05;

for H=Ho*[0.5,1,2,5]
    
J=H*2*Sb/(w)^2;              % Moment of inertia (calculation based on H)
M=J*w;                       % Moment of inertia x nominal speed
ii=ii+1;                     % Iteration number
    
 txt{ii}=['H=' num2str(H)];

    % Simulating the model
    model=sim('Ex1_inertia_2020a');
    % Ploting figures
    f203 = figure(203); set(f203, 'Position', [50 500 500 250]); 
    title('Load increase impact on frequency - Different H + droop two generators')
    hold all
    plot(model.frequency_sc3.time,model.frequency_sc3.signals.values,'Linewidth',2);
    xlabel('Time [s]','Interpreter','latex','FontSize',12);
    ylabel('Frequency (pu)','Interpreter','latex','FontSize',12);
    l203=legend(txt);
    set(l203,'Interpreter','latex','FontSize',12,'Location','NorthEast'); 
    
end 




ii=0;
H=Ho*0.5;
kdroop=0.05;
for tau_gen=[1,2,3,4,5]
    
J=H*2*Sb/(w)^2;              % Moment of inertia (calculation based on H)
M=J*w;                       % Moment of inertia x nominal speed
ii=ii+1;                     % Iteration number
    
 txt{ii}=['tau_gen=' num2str(tau_gen)];

    % Simulating the model
    model=sim('Ex1_inertia_2020a');
    % Ploting figures
    f200 = figure(200); set(f200, 'Position', [50 500 500 250]); 
    title('Load increase impact on frequency - Different tau values + droop two generators')
    hold all
    plot(model.frequency_sc3.time,model.frequency_sc3.signals.values,'Linewidth',2);
    xlabel('Time [s]','Interpreter','latex','FontSize',12);
    ylabel('Frequency (pu)','Interpreter','latex','FontSize',12);
    l200=legend(txt);
    set(l200,'Interpreter','latex','FontSize',12,'Location','NorthEast'); 
    
end 


ii=0;
H=Ho*0.5;
tau_gen=5;

for kdroop=[0.05,0.1,0.15,0.2,0.25]
    
J=H*2*Sb/(w)^2;              % Moment of inertia (calculation based on H)
M=J*w;                       % Moment of inertia x nominal speed
ii=ii+1;                     % Iteration number
    
 txt{ii}=['kdroop=' num2str(kdroop)];

    % Simulating the model
    model=sim('Ex1_inertia_2020a');
    % Ploting figures
    f201 = figure(201); set(f201, 'Position', [50 500 500 250]); 
    title('Load increase impact on frequency - Different K droop values + droop two generators')
    hold all
    plot(model.frequency_sc3.time,model.frequency_sc3.signals.values,'Linewidth',2);
    xlabel('Time [s]','Interpreter','latex','FontSize',12);
    ylabel('Frequency (pu)','Interpreter','latex','FontSize',12);
    l201=legend(txt);
    set(l201,'Interpreter','latex','FontSize',12,'Location','NorthEast'); 
    
end 




