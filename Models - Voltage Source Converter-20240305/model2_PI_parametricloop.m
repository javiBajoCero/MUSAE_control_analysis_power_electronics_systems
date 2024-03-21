clear 
close all;

ki=2.5;
K_max = 10;
sim_time=0.01;
for kp = 1:K_max

    sim("Model2_PLL.slx");
    hold on;
   txttitle = sprintf( 'kp= %d', kp );
   % Plot with display name
   title('Vd (Ki=2,5)');
   plot( Vd_PLL, 'DisplayName', txttitle ,'LineWidth',3);
end

figure();
kp=1;
for ki = 1:K_max

    sim("Model2_PLL.slx");
    hold on;
   txttitle = sprintf( 'ki= %d', ki );
   % Plot with display name
   title('Vd (Kp=1)');
   plot( Vd_PLL, 'DisplayName', txttitle ,'LineWidth',1);
end