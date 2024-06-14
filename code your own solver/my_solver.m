clear; close all;

sim_time = 0.1; % Total simulation time in seconds
sim_step_time = 1e-3; % Simulation step time in seconds

R = 0.3; % Resistance in ohms
L = 1e-3; % Inductance in henries

% Number of simulation steps
num_steps = sim_time / sim_step_time;

% Preallocate arrays for current and voltage
i = zeros(1, num_steps);
v = zeros(1, num_steps);
v_load=zeros(1,num_steps);

% Initial conditions
v(1) = 1; % Initial voltage
i(1) = 0; % Initial current
v_load(1)=1;
figure;

for n = 2:num_steps
    % Update current using the discrete form of the RL circuit equation
    i(n) = i(n-1) + (sim_step_time / L) * (v(n-1) - R * i(n-1));
    
    % Update voltage for this example, assuming a constant voltage source
    v(n) = v(1); % If you want to simulate a different voltage source, update this accordingly

    v_load(n)= v(n) - i(n)*R;
end

% Plotting the results
plot((0:num_steps-1) * sim_step_time, v, 'b');
hold on;
plot((0:num_steps-1) * sim_step_time, i, 'r');
hold on;
plot((0:num_steps-1) * sim_step_time, v_load, 'g');
xlabel('Time (s)');
ylabel('Value');
legend('Voltage (V)', 'Current (A)', 'voltage at the load (V)');
title('RL Circuit Simulation');
grid on;