

Control_Folder = '/data/joy/BBL/projects/pncClinDtiControl/data/controlData';
Atlas_Yeo_Index = load('/data/joy/BBL/projects/pncClinDtiControl/data/atlas/Yeo_7system_in_Lausanne234.txt');
Atlas_Yeo_Index = Atlas_Yeo_Index(1:233);
for i = 1:8
  System_Indices{i} = find(Atlas_Yeo_Index == i);
end

% 233 atlas, FA
tmp = load([Control_Folder '/Lausanne125_FA_control.mat']);
avg_cont = zeros(1089, 8);
mod_cont = zeros(1089, 8);
bnd_cont = zeros(1089, 8);
for i = 1:8
  avg_cont(:, i) = mean(tmp.avg_cont(:, System_Indices{i}), 2);
  mod_cont(:, i) = mean(tmp.mod_cont(:, System_Indices{i}), 2); 
  bnd_cont(:, i) = mean(tmp.bnd_cont(:, System_Indices{i}), 2);
end
scan_ID = tmp.scan_ID;
save([Control_Folder '/Lausanne125_FA_control_YeoSystemAvg.mat'], 'avg_cont', 'mod_cont', 'bnd_cont', 'scan_ID');

% 233 atlas, SC
tmp = load([Control_Folder '/Lausanne125_SC_control.mat']);
avg_cont = zeros(1089, 8);
mod_cont = zeros(1089, 8);
bnd_cont = zeros(1089, 8);
for i = 1:8
  avg_cont(:, i) = mean(tmp.avg_cont(:, System_Indices{i}), 2);
  mod_cont(:, i) = mean(tmp.mod_cont(:, System_Indices{i}), 2);
  bnd_cont(:, i) = mean(tmp.bnd_cont(:, System_Indices{i}), 2);
end
scan_ID = tmp.scan_ID;
save([Control_Folder '/Lausanne125_SC_control_YeoSystemAvg.mat'], 'avg_cont', 'mod_cont', 'bnd_cont', 'scan_ID');

% 233 atlas, SC
tmp = load([Control_Folder '/Lausanne125_volNormSC_control.mat']);
avg_cont = zeros(1089, 8);
mod_cont = zeros(1089, 8);
bnd_cont = zeros(1089, 8);
for i = 1:8
  avg_cont(:, i) = mean(tmp.avg_cont(:, System_Indices{i}), 2);
  mod_cont(:, i) = mean(tmp.mod_cont(:, System_Indices{i}), 2);
  bnd_cont(:, i) = mean(tmp.bnd_cont(:, System_Indices{i}), 2);
end
scan_ID = tmp.scan_ID;
save([Control_Folder '/Lausanne125_volNormSC_control_YeoSystemAvg.mat'], 'avg_cont', 'mod_cont', 'bnd_cont', 'scan_ID');
