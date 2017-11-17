% Calculating average and modal controllability

Matrix_Folder = '/data/joy/BBL/projects/pncClinDtiControl/data/matrices';


%% Lausanne 125

Lausanne125_SC_Matrix_Cell = g_ls([Matrix_Folder '/Lausanne125/streamlineCount/*.mat']);
avg_cont = zeros(1089, 234);
mod_cont = zeros(1089, 234);
for i = 1:length(Lausanne125_SC_Matrix_Cell)
    i
    load(Lausanne125_SC_Matrix_Cell{i});
    avg_cont(i, :) = ave_control(connectivity);
    mod_cont(i, :) = modal_control(connectivity);
    [~, FileName, Suffix] = fileparts(Lausanne125_SC_Matrix_Cell{i});
    subjnames{i} = [FileName Suffix];
end
save /data/joy/BBL/projects/pncClinDtiControl/data/controlData/Lausanne125_SC_control_withBrainStem.mat avg_cont mod_cont;

