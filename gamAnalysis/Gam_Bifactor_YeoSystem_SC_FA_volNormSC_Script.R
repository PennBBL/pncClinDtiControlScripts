
library('R.matlab');
source('/data/joy/BBL/projects/pncClinDtiControl/scripts/gamAnalysis/Gam_Bifactor_OneModel_Function.R')

Control_Folder = '/data/joy/BBL/projects/pncClinDtiControl/data/controlData';

#SC_Controllability_Mat <- paste(Control_Folder, 'Lausanne125_SC_control_YeoSystemAvg.mat', sep = '/');
#Resultant_Folder <- paste(Control_Folder, 'Gam_SC_Bifactor_YeoSystem_OneModel', sep = '/');
#Gam_Bifactor_OneModel(SC_Controllability_Mat, Resultant_Folder);

FA_Controllability_Mat <- paste(Control_Folder, 'Lausanne125_FA_control_YeoSystemAvg.mat', sep = '/');
Resultant_Folder <- paste(Control_Folder, 'Gam_FA_Bifactor_YeoSystem_OneModel', sep = '/');
Gam_Bifactor_OneModel(FA_Controllability_Mat, Resultant_Folder);

volNormSC_Controllability_Mat <- paste(Control_Folder, 'Lausanne125_volNormSC_control_YeoSystemAvg.mat', sep = '/');
Resultant_Folder <- paste(Control_Folder, 'Gam_volNormSC_Bifactor_YeoSystem_OneModel', sep = '/');
Gam_Bifactor_OneModel(volNormSC_Controllability_Mat, Resultant_Folder);



