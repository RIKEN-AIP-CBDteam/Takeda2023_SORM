function sp_selected = SORM(G, Nsp_select, voi, exponent_l)
% Sensor array Optimization based on Resolution Matrix (SORM)
%
% - Input
% G: Leadfield matrix (Nsensor x Nvertex)
% Nsp_select: Number of sensor position to select
% voi: Vetices of interest
% exponent_l: <<Optional>> exponent of regularization constant (default: -1)
%
% - Output
% sp_selected: Selected sensor positions
%
% 2023-07-04 Yusuke Takeda

% Set regularization constant
if ~exist('exponent_l', 'var')
    exponent_l = -1;
end
[Nsp_candidate, Nv] = size(G);
l = trace(G'*G)/Nv*10^exponent_l;

% Initialize variables
GG = zeros(Nv, Nv);% G'*G
sp_remain = 1:Nsp_candidate;% Remaining sensor positions
sp_selected = zeros(Nsp_select, 1);% Selected sensor positions

% Sequentially select each sensor position
fprintf('Selecting sensor positions...        ')
for sp = 1:Nsp_select
    % Calculate gain vectors for remaining sensor positions
    C = GG+l*eye(Nv);
    x_list = C\G(sp_remain, :)';% Gain vectors
    
    % Select sensor position that maximizes xx
    xx = sum(x_list(voi, :).^2, 1);
    [~, b] = max(xx);
    tmp = sp_remain(b);
    sp_selected(sp) = tmp;
    fprintf('\b\b\b\b\b\b\b%3.0f/%3.0f', sp, Nsp_select)
    
    % Update GG
    sp_remain(b) = [];
    GG = GG+G(tmp, :)'*G(tmp, :);
end
fprintf('\n')