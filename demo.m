% Demo program for Sensor array Optimization based on Resolution Matrix (SORM)
% Please execute the following commands step by step.
%
% 2022-11-15 Yusuke Takeda

clear all
close all
figure('Color', [1 1 1])

%% 1. Set regions of interest (ROIs) by the labels in HCP-MMP 1.0 (Glasser et al., 2016)
%ROI = {'L_4_ROI', 'R_4_ROI'};% Primary motor cortices
ROI = {'L_A1_ROI', 'L_MBelt_ROI', 'R_A1_ROI', 'R_MBelt_ROI'};% Early auditory cortices

% Convert ROIs to vertices of interest (voi)
load('HCP_MMP1.mat', 'Area')
voi = [];% vertices of interest
for roi = 1:length(ROI)
    for area = 1:length(Area)
        if strcmp(Area{area}.key, ROI{roi})
            voi = [voi;Area{area}.Iextract];
            break
        end
    end
end


%% 2. Show ROIs
% Load inflated brain model
load('inflated_brain.mat', 'V', 'F', 'inf_C')
Nv = size(V, 1);% Number of vertices
max_xyz = max(V, [], 1);
min_xyz = min(V, [], 1);

% Set colors of vertices
c = 0.8*ones(Nv, 3)-0.32*repmat(inf_C, 1, 3);
c(voi, :) = repmat([1 0 0], size(voi, 1), 1);% Red for ROIs

% Show ROIs on inflated brain model
subplot(2, 2, 1)
patch('Faces', F, 'Vertices', V, 'FaceColor', 'interp',...
    'EdgeColor', 'none', 'FaceVertexCData', c);
axis([min_xyz(1) max_xyz(1) min_xyz(2) max_xyz(2) min_xyz(3) max_xyz(3)])
axis equal off
view([-90 0])
title('Left ROI')
subplot(2, 2, 2)
patch('Faces', F, 'Vertices', V, 'FaceColor', 'interp',...
    'EdgeColor', 'none', 'FaceVertexCData', c);
axis([min_xyz(1) max_xyz(1) min_xyz(2) max_xyz(2) min_xyz(3) max_xyz(3)])
axis equal off
view([90 0])
title('Right ROI')


%% 3. Show candidate sensor positions
load('sensor_position', 'pos')
Nsp_candidate = size(pos, 1);
clr = ones(Nsp_candidate, 3);

subplot(2, 2, 3)
plot_sensor(pos, clr)
title('Candidate sensor positions')


%% 4. Select sensor positions by the SORM algorithm
Nsp_select = 10;% Number of sensor positions to select

% Load leadfield matrix of all the candidate sensor positions
load('leadfield.mat', 'G')

% Design sensor array
tic
sp_selected = SORM(G, Nsp_select, voi); % By SORM
% sp_selected  = leadfield_norm(G, Nsp_select, voi); % Based on leadfield norm 
toc


%% 5. Show designed sensor array
% Assign red color for selected sensor positions
clr(sp_selected, :) = repmat([1 0 0], Nsp_select, 1);

% Show selected sensor positions
subplot(2, 2, 4)
plot_sensor(pos, clr)
title('Designed sensor array')

