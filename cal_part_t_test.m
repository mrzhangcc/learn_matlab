clear
close all;
folder = '/Users/chuangchuangzhang/Downloads/Analysis/';
filename = ['ZQ175-3W-';'ZQ175-5W-';'ZQ175-7W-'];
no = '2';
MH_Brain = [];
MW_Brain = [];
FH_Brain = [];
FW_Brain = [];
% CaudatePutamen Neocortex Cerebellum Thalamus PeriformCortex Hypothalamus CC/ExternalCapsule
type = 'Neocortex';
for i = 1:size(filename, 1)
    MH = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MH_combine');
    MW = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MW_combine');
    FH = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'FH_combine');
    FW = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'FW_combine');
    MH_Brain = MH{type, :};
    MW_Brain = MW{type, :};
    FH_Brain = FH{type, :};
    FW_Brain = FW{type, :};
    [h,p,ci,stats] = ttest2(MH_Brain',MW_Brain', 'Vartype', 'unequal');
    disp([filename(i, :),' ', type, ' p: ', num2str(p), ', h: ', num2str(h), ', tstat: ', num2str(stats.tstat)]);
end

