
Original_Folder = '/data/joy/BBL/projects/pncClinDtiControl/data/matrices/';
Resultant_Folder = '/data/joy/BBL/projects/pncClinDtiControl/data/matrices_withoutBrainStem/';

% Lausanne 125
Lausanne125_FA_Matrix_Cell = g_ls([Original_Folder '/Lausanne125/FA/*.mat']);
for i = 1:length(Lausanne125_FA_Matrix_Cell)
    load(Lausanne125_FA_Matrix_Cell{i});
    connectivity = connectivity(1:233, 1:233);
    [~, FileName, Suffix] = fileparts(Lausanne125_FA_Matrix_Cell{i});
    save([Resultant_Folder '/Lausanne125/FA/' FileName Suffix], 'connectivity');
end

Lausanne125_SC_Matrix_Cell = g_ls([Original_Folder '/Lausanne125/streamlineCount/*.mat']);
for i = 1:length(Lausanne125_SC_Matrix_Cell)
    load(Lausanne125_SC_Matrix_Cell{i});
    connectivity = connectivity(1:233, 1:233);
    [~, FileName, Suffix] = fileparts(Lausanne125_SC_Matrix_Cell{i});
    save([Resultant_Folder '/Lausanne125/streamlineCount/' FileName Suffix], 'connectivity');
end

Lausanne125_volNormSC_Matrix_Cell = g_ls([Original_Folder '/Lausanne125/volNormSC/*.mat']);
for i = 1:length(Lausanne125_volNormSC_Matrix_Cell)
    load(Lausanne125_volNormSC_Matrix_Cell{i});
    connectivity = connectivity(1:233, 1:233);
    [~, FileName, Suffix] = fileparts(Lausanne125_volNormSC_Matrix_Cell{i});
    save([Resultant_Folder '/Lausanne125/volNormSC/' FileName Suffix], 'connectivity');
end

% Lausanne 60
Lausanne60_FA_Matrix_Cell = g_ls([Original_Folder '/Lausanne60/FA/*.mat']);
for i = 1:length(Lausanne60_FA_Matrix_Cell)
    load(Lausanne60_FA_Matrix_Cell{i});
    connectivity = connectivity(1:128, 1:128);
    [~, FileName, Suffix] = fileparts(Lausanne60_FA_Matrix_Cell{i});
    save([Resultant_Folder '/Lausanne60/FA/' FileName Suffix], 'connectivity');
end

Lausanne60_SC_Matrix_Cell = g_ls([Original_Folder '/Lausanne60/streamlineCount/*.mat']);
for i = 1:length(Lausanne60_SC_Matrix_Cell)
    load(Lausanne60_SC_Matrix_Cell{i});
    connectivity = connectivity(1:128, 1:128);
    [~, FileName, Suffix] = fileparts(Lausanne60_SC_Matrix_Cell{i});
    save([Resultant_Folder '/Lausanne60/streamlineCount/' FileName Suffix], 'connectivity');
end

Lausanne60_volNormSC_Matrix_Cell = g_ls([Original_Folder '/Lausanne60/volNormSC/*.mat']);
for i = 1:length(Lausanne60_volNormSC_Matrix_Cell)
    load(Lausanne60_volNormSC_Matrix_Cell{i});
    connectivity = connectivity(1:128, 1:128);
    [~, FileName, Suffix] = fileparts(Lausanne60_volNormSC_Matrix_Cell{i});
    save([Resultant_Folder '/Lausanne60/volNormSC/' FileName Suffix], 'connectivity');
end
