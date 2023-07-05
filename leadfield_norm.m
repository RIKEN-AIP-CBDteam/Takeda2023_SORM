function sp_selected = leadfield_norm(G, Nsp_select, voi)
% Sensor array design based on leadfield norm
%
% - Input
% G: Leadfield matrix (Nsensor x Nvertex)
% Nsp_select: Number of sensor position to select
% voi: Vetices of interest
%
% - Output
% sp_selected: Selected sensor positions
%
% 2023-02-04 Yusuke Takeda

% Calculate leadfield norm
lf_norm = sum(G(:, voi).^2, 2).^0.5;

% Select sensor positions
[~, ix] = sort(lf_norm, 'descend');
sp_selected = ix(1:Nsp_select);


