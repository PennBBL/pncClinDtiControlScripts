% Calculate the group representative ma:trix
Data_Folder = '/data/joy/BBL/projects/pncClinDtiControl/data';
% Lausanne 125
disp('Lausanne 125');
Atlas_Path = [Data_Folder '/Atlas/ROIv_scale125.nii.gz'];
ROI_distance = ZC_ROI_distance(Atlas_Path);
ROI_distance = ROI_distance(1:233, 1:233); % Remove brain stem
% load('/data/joy/BBL/projects/pncClinDtiControl/data/rickData/dist125_without_BrainStem.mat');
hemiid = [ones(115, 1); 2 * ones(118, 1)];

SC_Cell = g_ls([Data_Folder '/matrices_withoutBrainStem/Lausanne125/streamlineCount/*.mat']);
SC_Conn_All = zeros(233, 233, length(SC_Cell));
for i = 1:length(SC_Cell)
    load(SC_Cell{i});
    SC_Conn_All(:, :, i) = connectivity;
end
Lausanne125_group_consensus_mask = fcn_group_avg3(SC_Conn_All, ROI_distance, hemiid);
% Lausanne125_group_consensus_mask = fcn_group_avg3(Conn_All, dist125_without_BrainStem, hemiid);
SC_Conn_Avg = sum(SC_Conn_All, 3) ./ sum(SC_Conn_All > 0, 3);
SC_Conn_Representative = SC_Conn_Avg .* Lausanne125_group_consensus_mask;

FA_Cell = g_ls([Data_Folder '/matrices_withoutBrainStem/Lausanne125/FA/*.mat']);
FA_Conn_All = zeros(233, 233, length(FA_Cell));
for i = 1:length(FA_Cell)
    load(FA_Cell{i});
    FA_Conn_All(:, :, i) = connectivity;
end
FA_Conn_Avg = sum(FA_Conn_All, 3) ./ sum(FA_Conn_All > 0, 3);
FA_Conn_Representative = FA_Conn_Avg .*

volNormSC_Cell = g_ls([Data_Folder '/matrices_withoutBrainStem/Lausanne125/volNormSC/*.mat'];
volNormSC_Conn_All = zeros(233, 233, length(volNormSC_Cell));
for i = 1:length(volNormSC_Cell)
    load(volNormSC_Cell{i});
    volNormSC_Conn_All(:, :, i) = connectivity;
end
volNormSC_Conn_Avg = sum(volNormSC_Conn_All, 3) ./ sum(volNormSC_Conn_All > 0, 3);

Control_Folder = [Data_Folder '/controlData'];


