
# Extracting the biofactors, demographics and dti head motion information according to the order controllability measurements 

require('R.matlab')

Control_SC_125 = "/data/joy/BBL/projects/pncClinDtiControl/data/controlData/Lausanne125_SC_control.mat";
tmp = readMat(Control_SC_125);
Scan_ID_SC = tmp$scan.ID;

print('.');
Bifactor_CSV = "/data/joy/BBL/projects/pncClinDtiControl/data/subjectData/n1601_goassess_itemwise_bifactor_scores_20161219.csv";
tmp = read.csv(Bifactor_CSV);
Scan_ID_Factor_CSV = tmp$scanid;
#Indice = which(Scan_ID_Factor_CSV %in% Scan_ID_SC);
Indice = matrix(1:length(Scan_ID_SC), nrow = length(Scan_ID_SC));
for (i in 1:length(Scan_ID_SC)){
  for (j in 1:length(Scan_ID_Factor_CSV)){
    if(Scan_ID_SC[i] == Scan_ID_Factor_CSV[j]){
      Indice[i] = j;
      break;
    }
  }
}
Mood = tmp$mood_4factorv2[Indice];
Psychosis = tmp$psychosis_4factorv2[Indice];
Externalizing = tmp$externalizing_4factorv2[Indice];
Phobias = tmp$phobias_4factorv2[Indice];
OverallPsycho = tmp$overall_psychopathology_4factorv2[Indice];

print('..');
Demographics_CSV = "/data/joy/BBL/projects/pncClinDtiControl/data/subjectData/n1601_demographics_go1_20161212.csv";
tmp = read.csv(Demographics_CSV);
Scan_ID_Demogra_CSV = tmp$scanid;
#Indice = which(Scan_ID_Demogra_CSV %in% Scan_ID_SC);
Indice = matrix(1:length(Scan_ID_SC), nrow = length(Scan_ID_SC));
for (i in 1:length(Scan_ID_SC)){
  for (j in 1:length(Scan_ID_Demogra_CSV)){
    if(Scan_ID_SC[i] == Scan_ID_Demogra_CSV[j]){
      Indice[i] = j;
      break;
    }
  }
}
Sex = tmp$sex[Indice];
Age = tmp$ageAtScan1[Indice];
Race = tmp$race[Indice];
Race2 = tmp$race2[Indice];

print('...');
Motion_CSV = "/data/joy/BBL/studies/pnc/n1601_dataFreeze/neuroimaging/dti/n1601_dti_qa_20170301.csv";
tmp = read.csv(Motion_CSV);
Scan_ID_Motion_CSV = tmp$scanid;
#Indice = which(Scan_ID_Motion_CSV %in% Scan_ID_SC);
Indice = matrix(1:length(Scan_ID_SC), nrow = length(Scan_ID_SC));
for (i in 1:length(Scan_ID_SC)){
  for (j in 1:length(Scan_ID_Motion_CSV)){
    if(Scan_ID_SC[i] == Scan_ID_Motion_CSV[j]){
      Indice[i] = j;
      break;
    }
  }
}
MotionMeanRelRMS = tmp$dti64MeanRelRMS[Indice];

Resultant_Mat = "/data/joy/BBL/projects/pncClinDtiControl/data/subjectData/n1089_Bifactor_DtiMotion_Demogra.mat";
writeMat(Resultant_Mat, Scan_ID_SC = Scan_ID_SC, Sex = Sex, Age = Age, Race = Race, Race2 = Race2, Mood = Mood, Psychosis = Psychosis, Externalizing = Externalizing, Phobias = Phobias, OverallPsycho = OverallPsycho, MotionMeanRelRMS = MotionMeanRelRMS);
Resultant_CSV = "/data/joy/BBL/projects/pncClinDtiControl/data/subjectData/n1089_Bifactor_DtiMotion_Demogra.csv";
All_Info_CSV = data.frame(Scan_ID_SC = Scan_ID_SC, Sex = Sex, Age = Age, Race = Race, Race2 = Race2, Mood = Mood, Psychosis = Psychosis, Externalizing = Externalizing, Phobias = Phobias, OverallPsycho = OverallPsycho, MotionMeanRelRMS = MotionMeanRelRMS);
write.csv(All_Info_CSV, file = Resultant_CSV);
