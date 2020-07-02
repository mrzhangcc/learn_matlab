clear;
close all;
if ispc
    folder = 'F:\T2-1\Analysis\';
elseif ismac
    folder = '/Users/chuangchuangzhang/Documents/Data/StructureMRI/ZQ175/';
elseif isunix
else
end

filename = ['ZQ175-3W-';'ZQ175-5W-';'ZQ175-7W-'];
no = '2';
MH_Part = [];
MH_Up_Part = [];
MH_Down_Part = [];
MW_Part = [];
MW_Up_Part = [];
MW_Down_Part = [];

FH_Part = [];
FH_Up_Part = [];
FH_Down_Part = [];
FW_Part = [];
FW_Up_Part = [];
FW_Down_Part = [];
% Brain CaudatePutamen Neocortex Cerebellum Thalamus LGP
% PeriformCortex Hypothalamus CC/ExternalCapsule
type = 'CaudatePutamen';
for i = 1:size(filename, 1)
    Mean = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'Mean');
    MH_Part(1, i) = Mean{type, 'MH'};
    t = Mean{type, 'MH_std'};
    MH_Up_Part(1, i) = MH_Part(1, i) + t;
    MH_Down_Part(1, i) = MH_Part(1, i) - t;
    MW_Part(1, i) = Mean{type, 'MW'};
    t = Mean{type, 'MW_std'};
    MW_Up_Part(1, i) = MW_Part(1, i) + t;
    MW_Down_Part(1, i) = MW_Part(1, i) - t;
    
    FH_Part(1, i) = Mean{type, 'FH'};
    t = Mean{type, 'FH_std'};
    FH_Up_Part(1, i) = FH_Part(1, i) + t;
    FH_Down_Part(1, i) = FH_Part(1, i) - t;
    FW_Part(1, i) = Mean{type, 'FW'};
    t = Mean{type, 'FW_std'};
    FW_Up_Part(1, i) = FW_Part(1, i) + t;
    FW_Down_Part(1, i) = FW_Part(1, i) - t;
end

x = [3, 5, 7];
figure;

x1 = linspace(3, 7, 29)';
smoothtype = 'poly2';
%MW
[cMW, gof, output] = fit(x', MW_Part', smoothtype);
yMW = feval(cMW, x1);
[cMW_Up, gof, output] = fit(x', MW_Up_Part', smoothtype);
yup = feval(cMW_Up, x1);
[cMW_Down, gof, output] = fit(x', MW_Down_Part', smoothtype);
ydown = feval(cMW_Down, x1);

xconf = [x1' x1(end:-1:1)'];         
yconf = [ydown' yup(end:-1:1)'];

pC = fill(xconf,yconf,'green');
pC.FaceColor = [0.77 0.9 0.875];      
pC.EdgeColor = 'none'; 
pC.FaceAlpha = 0.5;
%MH
[cMH, gof, output] = fit(x', MH_Part', smoothtype);
yMH = feval(cMH, x1);
[cMH_Up, gof, output] = fit(x', MH_Up_Part', smoothtype);
yup = feval(cMH_Up, x1);
[cMH_Down, gof, output] = fit(x', MH_Down_Part', smoothtype);
ydown = feval(cMH_Down, x1);

xconf = [x1' x1(end:-1:1)'] ;         
yconf = [ydown' yup(end:-1:1)'];

hold on
pC = fill(xconf,yconf,'red');
pC.FaceColor = [0.97 0.85 0.85];      
pC.EdgeColor = 'none'; 
pC.FaceAlpha = 0.5;
hold off

%FH
[cFH, gof, output] = fit(x', FH_Part', smoothtype);
yFH = feval(cFH, x1);
[cFH_Up, gof, output] = fit(x', FH_Up_Part', smoothtype);
yup = feval(cFH_Up, x1);
[cFH_Down, gof, output] = fit(x', FH_Down_Part', smoothtype);
ydown = feval(cFH_Down, x1);

xconf = [x1' x1(end:-1:1)'] ;         
yconf = [ydown' yup(end:-1:1)'];

hold on
pC = fill(xconf,yconf,'red');
pC.FaceColor = [0.926 0.79 0.86];      
pC.EdgeColor = 'none'; 
pC.FaceAlpha = 0.5;
hold off

%FW
[cFW, gof, output] = fit(x', FW_Part', smoothtype);
yFW = feval(cFW, x1);
[cFW_Up, gof, output] = fit(x', FW_Up_Part', smoothtype);
yup = feval(cFW_Up, x1);
[cFW_Down, gof, output] = fit(x', FW_Down_Part', smoothtype);
ydown = feval(cFW_Down, x1);

xconf = [x1' x1(end:-1:1)'] ;         
yconf = [ydown' yup(end:-1:1)'];

hold on
pC = fill(xconf,yconf,'green');
pC.FaceColor = [0.79 0.87 0.89];      
pC.EdgeColor = 'none'; 
pC.FaceAlpha = 0.5;
hold off

hold on
p1 = plot(x1,yMW, 'Color', [0 0.66 0.52], 'LineWidth', 3);
p2 = plot(x1,yMH, 'Color', [0.9 0.38 0.38], 'LineWidth', 3);
p3 = plot(x1, yFW, 'Color', [0.13 0.46 0.54], 'LineWidth', 3);
p4 = plot(x1, yFH, 'Color', [0.69 0.164 0.531], 'LineWidth', 3);
hold off

xlim([2.8 7.2]);
xticks([3 5 7]);
% Brain CaudatePutamen Neocortex Cerebellum Thalamus PeriformCortex Hypothalamus CC/ExternalCapsule
if strcmp(type, 'CaudatePutamen')
%     ylim([14 22]);
    ylim([16 21.5]);
elseif strcmp(type, 'Neocortex')
%     ylim([70 110])
    ylim([75 100]);
elseif strcmp(type, 'Cerebellum')
%     ylim([30 70]);
    ylim([40 60]);
elseif strcmp(type, 'Thalamus')
%     ylim([15 28]);
    ylim([18 24]);
elseif strcmp(type, 'PeriformCortex')
    ylim([1 5]);
elseif strcmp(type, 'Hypothalamus')
    ylim([6 16]);
elseif strcmp(type, 'CC/ExternalCapsule')
    ylim([8 16]);
elseif strcmp(type, 'Brain')
    ylim([350 500]);
else
end
% ylim([15 25]);
xlabel('Weeks', 'FontSize', 18);
ylabel('Volume(mm^3)', 'FontSize', 18);

ax = gca; % current axes
ax.FontSize = 16;

lgd = legend([p1 p2 p3 p4],{'MWT', 'MHD', 'FWT', 'FHD'}, 'Location', 'northwest', 'FontSize', 12);
legend('boxoff');
if strcmp(type, 'LGP')
    title(lgd, 'Lateral Globus Pallidus');
elseif strcmp(type, 'CaudatePutamen')
    title(lgd, 'Striatum');
else
    title(lgd, type);
end

if strcmp(type, 'CC/ExternalCapsule')
    saveas(gcf,sprintf('%sA_%s.png', folder, 'CC_ExternalCapsule'))
else
    saveas(gcf,sprintf('%sA_%s.png', folder, type))
end

% legend('MH', 'MW', 'FH', 'FW', 'MH-', 'MW-', 'FH-', 'FW-');

% %FW
% [0.13 0.46 0.54]
% [0.79 0.87 0.89]
% %FH
% [0.69 0.164 0.531]
% [0.926 0.79 0.86]
