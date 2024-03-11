clear all; close all;

%% Voltages definition
w = 2*pi*50;
t = 0:0.04/200:0.04;

%no harmonic
va = sin(w*t);
vb = sin(w*t - 2*pi/3);
vc = sin(w*t + 2*pi/3);

%harmonic_amplitude=0.1;
%harmonic_number=6;
%va = sin(w*t)           +harmonic_amplitude*sin(harmonic_number*(w*t));
%vb = sin(w*t - 2*pi/3)  +harmonic_amplitude*sin(harmonic_number*(w*t - 2*pi/3));
%vc = sin(w*t + 2*pi/3)  +harmonic_amplitude*sin(harmonic_number*(w*t + 2*pi/3));


% Adding harmonics, etc.
 %va = rand * 1.1 * sin(w*t+rand*360);% + rand * 0.5 * sin(3*(w*t+rand*360)) + rand * 0.25 * sin(5*(w*t+rand*360));
 %vb = rand * 1.1 * sin(w*t+rand*360);% + rand * 0.5 * sin(3*(w*t+rand*360)) + rand * 0.25 * sin(5*(w*t+rand*360));
 %vc = rand * 1.1 * sin(w*t+rand*360);% + rand * 0.5 * sin(3*(w*t+rand*360)) + rand * 0.25 * sin(5*(w*t+rand*360));

%% abc time domain plots
f1 = figure(1);
set(f1, 'Position', [50 500 500 250]);
hold on;
plot(t,va,'LineWidth',1.5,'Color',[0 0 1]);
plot(t,vb,'LineWidth',1.5,'Color',[0 0.6 1]);
plot(t,vc,'LineWidth',1.5,'Color',[0.6 0.6 1]);
ylim([-1.2 1.2]);
l1 = legend('$v_a$','$v_b$','$v_c$');
set(l1,'Interpreter','latex','FontSize',10,'Location','NorthEast');
xlabel('time [s]','Interpreter','latex','FontSize',12);

%% Plotting the cubic space

% Axes definition
verts3d = [-1 -1 -1; 
           -1 -1  1;
           -1  1 -1;
           -1  1  1;
            1 -1 -1;
            1 -1  1;
            1  1 -1;
            1  1  1];
        
centcara3d = [0  0  1;
              0  1  0;
              1  0  0;
              0  0 -1;
              0 -1  0;
             -1  0  0];
centcost3d = [1  0 -1;
              0  1 -1;
             -1  1  0;
             -1  0  1;
              0 -1  1;
              1 -1  0];
          
% Cubic limits
f2 = figure(2);
set(f2, 'Position', [600 300 500 450]);
hold on;
plot3([verts3d(1,1) verts3d(2,1)],[verts3d(1,2) verts3d(2,2)],[verts3d(1,3) verts3d(2,3)],'LineWidth',1,'Color','k');
plot3([verts3d(2,1) verts3d(4,1)],[verts3d(2,2) verts3d(4,2)],[verts3d(2,3) verts3d(4,3)],'LineWidth',1,'Color','k');
plot3([verts3d(4,1) verts3d(3,1)],[verts3d(4,2) verts3d(3,2)],[verts3d(4,3) verts3d(3,3)],'LineWidth',1,'Color','k');
plot3([verts3d(3,1) verts3d(1,1)],[verts3d(3,2) verts3d(1,2)],[verts3d(3,3) verts3d(1,3)],'LineWidth',1,'Color','k');
plot3([verts3d(5,1) verts3d(6,1)],[verts3d(5,2) verts3d(6,2)],[verts3d(5,3) verts3d(6,3)],'LineWidth',1,'Color','k');
plot3([verts3d(6,1) verts3d(8,1)],[verts3d(6,2) verts3d(8,2)],[verts3d(6,3) verts3d(8,3)],'LineWidth',1,'Color','k');
plot3([verts3d(8,1) verts3d(7,1)],[verts3d(8,2) verts3d(7,2)],[verts3d(8,3) verts3d(7,3)],'LineWidth',1,'Color','k');
plot3([verts3d(7,1) verts3d(5,1)],[verts3d(7,2) verts3d(5,2)],[verts3d(7,3) verts3d(5,3)],'LineWidth',1,'Color','k');
plot3([verts3d(1,1) verts3d(5,1)],[verts3d(1,2) verts3d(5,2)],[verts3d(1,3) verts3d(5,3)],'LineWidth',1,'Color','k');
plot3([verts3d(2,1) verts3d(6,1)],[verts3d(2,2) verts3d(6,2)],[verts3d(2,3) verts3d(6,3)],'LineWidth',1,'Color','k');
plot3([verts3d(3,1) verts3d(7,1)],[verts3d(3,2) verts3d(7,2)],[verts3d(3,3) verts3d(7,3)],'LineWidth',1,'Color','k');
plot3([verts3d(4,1) verts3d(8,1)],[verts3d(4,2) verts3d(8,2)],[verts3d(4,3) verts3d(8,3)],'LineWidth',1,'Color','k');

limit = 1.2;
xlim([-limit limit]);
ylim([-limit limit]);
zlim([-limit limit]);
view(115,20);
axis square;
axis vis3d;
axis off;
view(110,10);

% Zero sequence
plot3([centcost3d(1,1) centcost3d(2,1)],[centcost3d(1,2) centcost3d(2,2)],[centcost3d(1,3) centcost3d(2,3)],'LineWidth',1,'Color',[0.5 0.5 0.5]);
plot3([centcost3d(2,1) centcost3d(3,1)],[centcost3d(2,2) centcost3d(3,2)],[centcost3d(2,3) centcost3d(3,3)],'LineWidth',1,'Color',[0.5 0.5 0.5]);
plot3([centcost3d(3,1) centcost3d(4,1)],[centcost3d(3,2) centcost3d(4,2)],[centcost3d(3,3) centcost3d(4,3)],'LineWidth',1,'Color',[0.5 0.5 0.5]);
plot3([centcost3d(4,1) centcost3d(5,1)],[centcost3d(4,2) centcost3d(5,2)],[centcost3d(4,3) centcost3d(5,3)],'LineWidth',1,'Color',[0.5 0.5 0.5]);
plot3([centcost3d(5,1) centcost3d(6,1)],[centcost3d(5,2) centcost3d(6,2)],[centcost3d(5,3) centcost3d(6,3)],'LineWidth',1,'Color',[0.5 0.5 0.5]);
plot3([centcost3d(6,1) centcost3d(1,1)],[centcost3d(6,2) centcost3d(1,2)],[centcost3d(6,3) centcost3d(1,3)],'LineWidth',1,'Color',[0.5 0.5 0.5]);

% Spatial vector plot
plot3(va, vb, vc,'LineWidth',3,'Color','r');

% Natural axes
a = [1 0 0];
b = [0 1 0];
c = [0 0 1];
plot3([0 a(1)],[0 a(2)],[0 a(3)],'LineWidth',2,'Color','k');
plot3([0 b(1)],[0 b(2)],[0 b(3)],'LineWidth',2,'Color','k');
plot3([0 c(1)],[0 c(2)],[0 c(3)],'LineWidth',2,'Color','k');
text(a(1)+0.1,a(2)+0.0,a(3)+0.0,'a','FontSize',14,'Color','k');
text(b(1)+0.0,b(2)+0.1,b(3)+0.0,'b','FontSize',14,'Color','k');
text(c(1)+0.0,c(2)+0.0,c(3)+0.1,'c','FontSize',14,'Color','k');

% Clarke axes
Clarke = (1/3) * [2 -1 -1;                  
                  0 -sqrt(3) sqrt(3);
                  1 1 1];
alpha = inv(Clarke) * a';
beta = inv(Clarke) * b';
gamma = inv(Clarke) * c';
                    
plot3([0 alpha(1)],[0 alpha(2)],[0 alpha(3)],'LineWidth',2,'Color','m');
plot3([0 beta(1)],[0 beta(2)],[0 beta(3)],'LineWidth',2,'Color','m');
plot3([0 gamma(1)],[0 gamma(2)],[0 gamma(3)],'LineWidth',2,'Color','m');
text(alpha(1)+0.1,alpha(2)+0.0,alpha(3)+0.0,'\alpha','FontSize',14,'Color','m');
text(beta(1)+0.0,beta(2)+0.1,beta(3)+0.0,'\beta','FontSize',14,'Color','m');
text(gamma(1)+0.0,gamma(2)+0.0,gamma(3)+0.1,'0','FontSize',14,'Color','m');

%% Plot temporal clarke

for i=1:1:201
    V_Clarke(i,:) = Clarke * [va(i); vb(i); vc(i)];
end
V_Clarke = V_Clarke';
valfa = V_Clarke(1,:);
vbeta = V_Clarke(2,:);
vgamma = V_Clarke(3,:);

f3 = figure(3);
set(f3, 'Position', [50 150 500 250]);
hold on;
plot(t,valfa,'LineWidth',1.5,'Color',[1 0 0]);
plot(t,vbeta,'LineWidth',1.5,'Color',[1 0 0.6]);
plot(t,vgamma,'LineWidth',1.5,'Color',[1 0.6 0.6]);
ylim([-1.2 1.2]);
l1 = legend('$v_{\alpha}$','$v_{\beta}$','$v_{0}$');
set(l1,'Interpreter','latex','FontSize',10,'Location','NorthEast');
xlabel('time [s]','Interpreter','latex','FontSize',12);


%% View ab
figure(2)
view(90,-90);
%% View bc
figure(2)
view(90,0);
%% View ac
figure(2)
view(0,0);
%% View alpha beta
figure(2)
view(135,35);
%% View alpha beta
figure(2)
view(135,-55);

