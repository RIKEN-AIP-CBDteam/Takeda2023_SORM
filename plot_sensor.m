function plot_sensor(position, color)
% Plot sensor array
% This program was written referencing topoplot.m in EEGLAB.
%
% - Input
% position: Positions of sensors (Nsensor x 3)
% color: RGB color values of sensors (Nsensor x 3)
%
% 2023-07-04 Yusuke Takeda

% Check input
Ns = size(position, 1);
if ~exist('color', 'var')
    color = ones(Ns, 3);
end

% Plot sensor array
cla;
hold on

[phi, theta, r] = cart2sph(position(:, 1), position(:, 2), position(:, 3));
[xa, ya, za] = pol2cart(phi, 0.5*pi-theta, r);
xa = mean(xa)-xa;
ya = mean(ya)-ya;
r_max = max(sqrt(xa.^2+ya.^2));
xaa = xa;
yaa = ya;
xa = [xa; (1.1*r_max*cos(0:0.02*pi:1.99*pi))'];
ya = [ya; (1.1*r_max*sin(0:0.02*pi:1.99*pi))'];

x_max = max(xa);
y_min = min(ya);
y_max = max(ya);

for s = 1:Ns
    plot(xaa(s), yaa(s), 'o', 'Markersize', 7, 'markeredgecolor', 'k', ...
        'markerfacecolor', color(s, :), 'linewidth', 1)
end
set(gca, 'XDir', 'reverse');
set(gca, 'YDir', 'reverse');

% Plot head, ears, and nose
rmax = (y_max - y_min)/2;
l = 0:2*pi/100:2*pi;
tip = rmax*1.15; base = rmax-0.04;
EarX = [.497 .510 .518 .5299 .5419 .54 .547 .532 .510 .489]/0.5*rmax;
EarY = [.0555 .0775 .0783 .0746 .0555 -.0055 -.0932 -.1313 -.1384 -.1199]/0.5*rmax;
HCOLOR = [0 0 0];
HLINEWIDTH = 2;

plot(gca, cos(l).*rmax,sin(l).*rmax,...
    'color', HCOLOR, 'Linestyle', '-', 'LineWidth', HLINEWIDTH);
plot(gca, [.1*rmax/0.5;0;-.1*rmax/0.5], -1*[base;tip;base],...
    'Color', HCOLOR, 'LineWidth', HLINEWIDTH);
plot(gca, EarX, EarY, 'color', HCOLOR, 'LineWidth', HLINEWIDTH);
plot(gca, -EarX, EarY, 'color', HCOLOR, 'LineWidth', HLINEWIDTH);
xlim([x_max*-1.2 x_max*1.2]); ylim([y_max*-1.2 y_max*1.2]);
axis square off

