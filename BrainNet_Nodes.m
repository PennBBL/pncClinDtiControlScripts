
% Atlas_Path = '/data/joy/BBL/projects/pncClinDtiControl/data/atlas/ROIv_scale125.nii.gz';
% BrainNet_GenCoord(Atlas_Path, '/data/joy/BBL/projects/pncClinDtiControl/data/controlData/ROIv_scale125.node');

ControlData_Folder = '/data/joy/BBL/projects/pncClinDtiControl/data/controlData';
Node_Info = load([ControlData_Folder '/ROIv_scale125.node'], '-ascii');
Node_Info(end, :) = [];
Resultant_Folder = [ControlData_Folder '/BrainNet_NodeFiles'];
Atlas_Yeo_Mapping = load('/data/joy/BBL/projects/pncClinDtiControl/data/atlas/Yeo_7system_in_Lausanne234.txt');
Atlas_Yeo_Mapping = Atlas_Yeo_Mapping(1:233);
Node_Info(:, 4) = Atlas_Yeo_Mapping;

% Avg_Control
load([ControlData_Folder '/Avg_Con_Gam_F_P.mat']);
% Age
Node_Info(:, 5) = abs(Avg_Con_Gam_F_P.Age_F) .* Avg_Con_Gam_F_P.Age_P_Sig_Mask;
save([Resultant_Folder '/Avg_Control_Age_Uncorrect.node'], 'Node_Info', '-ascii');
Node_Info(:, 5) = abs(Avg_Con_Gam_F_P.Age_F) .* Avg_Con_Gam_F_P.Age_CorrectP_Sig_Mask;
save([Resultant_Folder '/Avg_Control_Age_FDR.node'], 'Node_Info', '-ascii');
% Mood
Node_Info(:, 5) = abs(Avg_Con_Gam_F_P.Mood_F) .* Avg_Con_Gam_F_P.Mood_P_Sig_Mask;
save([Resultant_Folder '/Avg_Control_Mood_Uncorrect.node'], 'Node_Info', '-ascii');
Node_Info(:, 5) = abs(Avg_Con_Gam_F_P.Mood_F) .* Avg_Con_Gam_F_P.Mood_CorrectP_Sig_Mask;
save([Resultant_Folder '/Avg_Control_Mood_FDR.node'], 'Node_Info', '-ascii');
% Psychosis
Node_Info(:, 5) = abs(Avg_Con_Gam_F_P.Psychosis_F) .* Avg_Con_Gam_F_P.Psychosis_P_Sig_Mask;
save([Resultant_Folder '/Avg_Control_Psychosis_Uncorrect.node'], 'Node_Info', '-ascii');
Node_Info(:, 5) = abs(Avg_Con_Gam_F_P.Psychosis_F) .* Avg_Con_Gam_F_P.Psychosis_CorrectP_Sig_Mask;
save([Resultant_Folder '/Avg_Control_Psychosis_FDR.node'], 'Node_Info', '-ascii');
% Externalizing
Node_Info(:, 5) = abs(Avg_Con_Gam_F_P.Externalizing_F) .* Avg_Con_Gam_F_P.Externalizing_P_Sig_Mask;
save([Resultant_Folder '/Avg_Control_Externalizing_Uncorrect.node'], 'Node_Info', '-ascii');
Node_Info(:, 5) = abs(Avg_Con_Gam_F_P.Externalizing_F) .* Avg_Con_Gam_F_P.Externalizing_CorrectP_Sig_Mask;
save([Resultant_Folder '/Avg_Control_Externalizing_FDR.node'], 'Node_Info', '-ascii');
% Phobias
Node_Info(:, 5) = abs(Avg_Con_Gam_F_P.Phobias_F) .* Avg_Con_Gam_F_P.Phobias_P_Sig_Mask;
save([Resultant_Folder '/Avg_Control_Phobias_Uncorrect.node'], 'Node_Info', '-ascii');
Node_Info(:, 5) = abs(Avg_Con_Gam_F_P.Phobias_F) .* Avg_Con_Gam_F_P.Phobias_CorrectP_Sig_Mask;
save([Resultant_Folder '/Avg_Control_Phobias_FDR.node'], 'Node_Info', '-ascii');
% OverallPsycho
Node_Info(:, 5) = abs(Avg_Con_Gam_F_P.OverallPsycho_F) .* Avg_Con_Gam_F_P.OverallPsycho_P_Sig_Mask;
save([Resultant_Folder '/Avg_Control_OverallPsycho_Uncorrect.node'], 'Node_Info', '-ascii');
Node_Info(:, 5) = abs(Avg_Con_Gam_F_P.OverallPsycho_F) .* Avg_Con_Gam_F_P.OverallPsycho_CorrectP_Sig_Mask;
save([Resultant_Folder '/Avg_Control_OverallPsycho_FDR.node'], 'Node_Info', '-ascii');

% Mod_Control
load([ControlData_Folder '/Mod_Con_Gam_F_P.mat']);
% Age
Node_Info(:, 5) = abs(Mod_Con_Gam_F_P.Age_F) .* Mod_Con_Gam_F_P.Age_P_Sig_Mask;
save([Resultant_Folder '/Mod_Control_Age_Uncorrect.node'], 'Node_Info', '-ascii');
Node_Info(:, 5) = abs(Mod_Con_Gam_F_P.Age_F) .* Mod_Con_Gam_F_P.Age_CorrectP_Sig_Mask;
save([Resultant_Folder '/Mod_Control_Age_FDR.node'], 'Node_Info', '-ascii');
% Mood
Node_Info(:, 5) = abs(Mod_Con_Gam_F_P.Mood_F) .* Mod_Con_Gam_F_P.Mood_P_Sig_Mask;
save([Resultant_Folder '/Mod_Control_Mood_Uncorrect.node'], 'Node_Info', '-ascii');
Node_Info(:, 5) = abs(Mod_Con_Gam_F_P.Mood_F) .* Mod_Con_Gam_F_P.Mood_CorrectP_Sig_Mask;
save([Resultant_Folder '/Mod_Control_Mood_FDR.node'], 'Node_Info', '-ascii');
% Psychosis
Node_Info(:, 5) = abs(Mod_Con_Gam_F_P.Psychosis_F) .* Mod_Con_Gam_F_P.Psychosis_P_Sig_Mask;
save([Resultant_Folder '/Mod_Control_Psychosis_Uncorrect.node'], 'Node_Info', '-ascii');
Node_Info(:, 5) = abs(Mod_Con_Gam_F_P.Psychosis_F) .* Mod_Con_Gam_F_P.Psychosis_CorrectP_Sig_Mask;
save([Resultant_Folder '/Mod_Control_Psychosis_FDR.node'], 'Node_Info', '-ascii');
% Externalizing
Node_Info(:, 5) = abs(Mod_Con_Gam_F_P.Externalizing_F) .* Mod_Con_Gam_F_P.Externalizing_P_Sig_Mask;
save([Resultant_Folder '/Mod_Control_Externalizing_Uncorrect.node'], 'Node_Info', '-ascii');
Node_Info(:, 5) = abs(Mod_Con_Gam_F_P.Externalizing_F) .* Mod_Con_Gam_F_P.Externalizing_CorrectP_Sig_Mask;
save([Resultant_Folder '/Mod_Control_Externalizing_FDR.node'], 'Node_Info', '-ascii');
% Phobias
Node_Info(:, 5) = abs(Mod_Con_Gam_F_P.Phobias_F) .* Mod_Con_Gam_F_P.Phobias_P_Sig_Mask;
save([Resultant_Folder '/Mod_Control_Phobias_Uncorrect.node'], 'Node_Info', '-ascii');
Node_Info(:, 5) = abs(Mod_Con_Gam_F_P.Phobias_F) .* Mod_Con_Gam_F_P.Phobias_CorrectP_Sig_Mask;
save([Resultant_Folder '/Mod_Control_Phobias_FDR.node'], 'Node_Info', '-ascii');
% OverallPsycho
Node_Info(:, 5) = abs(Mod_Con_Gam_F_P.OverallPsycho_F) .* Mod_Con_Gam_F_P.OverallPsycho_P_Sig_Mask;
save([Resultant_Folder '/Mod_Control_OverallPsycho_Uncorrect.node'], 'Node_Info', '-ascii');
Node_Info(:, 5) = abs(Mod_Con_Gam_F_P.OverallPsycho_F) .* Mod_Con_Gam_F_P.OverallPsycho_CorrectP_Sig_Mask;
save([Resultant_Folder '/Mod_Control_OverallPsycho_FDR.node'], 'Node_Info', '-ascii');
