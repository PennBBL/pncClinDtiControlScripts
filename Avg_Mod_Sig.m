
clear

Avg_Con_Gam_F_P = load('/data/joy/BBL/projects/pncClinDtiControl/data/controlData/Avg_Con_Gam_F_P.mat');
FieldNames = fieldnames(Avg_Con_Gam_F_P);
for i = 7:18
    tmp = Avg_Con_Gam_F_P.(FieldNames{i});
    tmp(find(tmp > 0.05)) = 0;
    tmp(find(tmp)) = 1;
    Avg_Con_Gam_F_P.([FieldNames{i} '_Sig_Mask']) = tmp;
end
save /data/joy/BBL/projects/pncClinDtiControl/data/controlData/Avg_Con_Gam_F_P.mat Avg_Con_Gam_F_P;

Mod_Con_Gam_F_P = load('/data/joy/BBL/projects/pncClinDtiControl/data/controlData/Mod_Con_Gam_F_P.mat');
FieldNames = fieldnames(Mod_Con_Gam_F_P);
for i = 7:18
    tmp = Mod_Con_Gam_F_P.(FieldNames{i});
    tmp(find(tmp > 0.05)) = 0;
    tmp(find(tmp)) = 1;
    Mod_Con_Gam_F_P.([FieldNames{i} '_Sig_Mask']) = tmp;
end
save /data/joy/BBL/projects/pncClinDtiControl/data/controlData/Mod_Con_Gam_F_P.mat Mod_Con_Gam_F_P;
