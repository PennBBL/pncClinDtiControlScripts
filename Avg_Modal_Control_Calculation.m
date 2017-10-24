
% Calculating average and modal controllability

Matrix_Folder = '/data/joy/BBL/projects/pncClinDtiControl/data/matrices_withoutBrainStem';


%% Lausanne 125

Lausanne125_FA_Matrix_Cell = g_ls([Matrix_Folder '/Lausanne125/FA/*.mat']);
avg_cont = zeros(233, 1089);
mod_cont = zeros(233, 1089);
for i = 1:length(Lausanne125_FA_Matrix_Cell)
    i
    load(Lausanne125_FA_Matrix_Cell{i});
    avg_cont(:, i) = ave_control(connectivity);
    mod_cont(:, i) = modal_control(connectivity);
    [~, FileName, Suffix] = fileparts(Lausanne125_FA_Matrix_Cell{i});
    subjnames{i} = [FileName Suffix];
end
save Lausanne125_FA_control.mat avg_cont mod_cont;

Lausanne125_SC_Matrix_Cell = g_ls([Matrix_Folder '/Lausanne125/streamlineCount/*.mat']);
avg_cont = zeros(233, 1089);
mod_cont = zeros(233, 1089);
for i = 1:length(Lausanne125_SC_Matrix_Cell)
    i
    load(Lausanne125_SC_Matrix_Cell{i});
    avg_cont(:, i) = ave_control(connectivity);
    mod_cont(:, i) = modal_control(connectivity);
    [~, FileName, Suffix] = fileparts(Lausanne125_SC_Matrix_Cell{i});
    subjnames{i} = [FileName Suffix];
end
save Lausanne125_SC_control.mat avg_cont mod_cont;

Lausanne125_volNormSC_Matrix_Cell = g_ls([Matrix_Folder '/Lausanne125/volNormSC/*.mat']);
avg_cont = zeros(233, 1089);
mod_cont = zeros(233, 1089);
for i = 1:length(Lausanne125_volNormSC_Matrix_Cell)
    i
    load(Lausanne125_volNormSC_Matrix_Cell{i});
    avg_cont(:, i) = ave_control(connectivity);
    mod_cont(:, i) = modal_control(connectivity);
    [~, FileName, Suffix] = fileparts(Lausanne125_volNormSC_Matrix_Cell{i});
    subjnames{i} = [FileName Suffix];
end
save Lausanne125_volNormSC_control.mat avg_cont mod_cont;


%% Lausanne 60
Lausanne60_FA_Matrix_Cell = g_ls([Matrix_Folder '/Lausanne60/FA/*.mat']);
avg_cont = zeros(128, 1089);
mod_cont = zeros(128, 1089);
for i = 1:length(Lausanne60_FA_Matrix_Cell)
    i
    load(Lausanne60_FA_Matrix_Cell{i});
    avg_cont(:, i) = ave_control(connectivity);
    mod_cont(:, i) = modal_control(connectivity);
    [~, FileName, Suffix] = fileparts(Lausanne60_FA_Matrix_Cell{i});
    subjnames{i} = [FileName Suffix];
end
save Lausanne60_FA_control.mat avg_cont mod_cont;

Lausanne60_SC_Matrix_Cell = g_ls([Matrix_Folder '/Lausanne60/streamlineCount/*.mat']);
avg_cont = zeros(128, 1089);
mod_cont = zeros(128, 1089);
for i = 1:length(Lausanne60_SC_Matrix_Cell)
    i
    load(Lausanne60_SC_Matrix_Cell{i});
    avg_cont(:, i) = ave_control(connectivity);
    mod_cont(:, i) = modal_control(connectivity);
    [~, FileName, Suffix] = fileparts(Lausanne60_SC_Matrix_Cell{i});
    subjnames{i} = [FileName Suffix];
end
save Lausanne60_SC_control.mat avg_cont mod_cont;

Lausanne60_volNormSC_Matrix_Cell = g_ls([Matrix_Folder '/Lausanne60/volNormSC/*.mat']);
avg_cont = zeros(128, 1089);
mod_cont = zeros(128, 1089);
for i = 1:length(Lausanne60_volNormSC_Matrix_Cell)
    i
    load(Lausanne60_volNormSC_Matrix_Cell{i});
    avg_cont(:, i) = ave_control(connectivity);
    mod_cont(:, i) = modal_control(connectivity);
    [~, FileName, Suffix] = fileparts(Lausanne60_volNormSC_Matrix_Cell{i});
    subjnames{i} = [FileName Suffix];
end
save Lausanne60_volNormSC_control.mat avg_cont mod_cont;
