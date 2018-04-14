clear all; close all; clc;

%load system

simulation = 'twolinkarm_pd';
%choose in ['twolinkarm_pd'];
load_system(simulation);

%simulation parameters
is_animate_save = true; % if animation need to be saved
numSecondsToSimulate = 2; %number of simulation
timeStep = 0.001;
q_init = [-pi/2;0;0;0]; %desired end state
q_desired = [pi/4;pi/5;0;0]; %initial simulation state

%choose a shorter path for angles
for ii=1:2
    if abs(q_init(ii)-q_desired(ii)) > abs(2*pi-(q_init(ii)-q_desired(ii)))
        q_desired(ii)  = q_desired(ii) + 2*pi;
    end
end

%simulation
simOut = sim(simulation,'StopTime',num2str(numSecondsToSimulate),'FixedStep','0.005');
%animation
q_data = simOut.q.data;
T = simOut.q.Time;
twolinkarm_draw_save_animation(q_data, T, is_animate_save);
