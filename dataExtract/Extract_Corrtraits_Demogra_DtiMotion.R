
# Extracting the biofactors, demographics and dti head motion information according to the order controllability measurements 

require('R.matlab')

Control_SC_125 = "/data/joy/BBL/projects/pncClinDtiControl/data/controlData/Lausanne125_SC_control.mat";
tmp = readMat(Control_SC_125);
Scan_ID_SC = t(tmp$scan.ID);

print('.');
Corrtraitsv2_CSV = "/data/joy/BBL/projects/pncClinDtiControl/subjectLists/pncClinDtiControl_n1089_subject_data.csv";
tmp = read.csv(Corrtraitsv2_CSV);
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
Mood = tmp$mood_corrtraitsv2[Indice];
Psychosis = tmp$psychosis_corrtraitsv2[Indice];
Externalizing = tmp$externalizing_corrtraitsv2[Indice];
Fear = tmp$fear_corrtraitsv2[Indice];
Mood_sr = tmp$mood_sr_corrtraits[Indice];
Psychosis_sr = tmp$psychosis_sr_corrtraits[Indice];
Externalizing_sr = tmp$externalizing_sr_corrtraits[Indice];
Fear_sr = tmp$fear_sr_corrtraits[Indice];

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

Resultant_Mat = "/data/joy/BBL/projects/pncClinDtiControl/data/subjectData/n1089_Corrtraits_DtiMotion_Demogra.mat";
writeMat(Resultant_Mat, Scan_ID_SC = Scan_ID_SC, Sex = Sex, Age = Age, Race = Race, Race2 = Race2, Mood = Mood, Psychosis = Psychosis, Externalizing = Externalizing, Fear = Fear, Mood_sr = Mood_sr, Psychosis_sr = Psychosis_sr, Externalizing_sr = Externalizing_sr, Fear_sr = Fear_sr, MotionMeanRelRMS = MotionMeanRelRMS);
Resultant_CSV = "/data/joy/BBL/projects/pncClinDtiControl/data/subjectData/n1089_Corrtraits_DtiMotion_Demogra.csv";
All_Info_CSV = data.frame(Scan_ID_SC = Scan_ID_SC, Sex = Sex, Age = Age, Race = Race, Race2 = Race2, Mood = Mood, Psychosis = Psychosis, Externalizing = Externalizing, Fear = Fear, Mood_sr = Mood_sr, Psychosis_sr = Psychosis_sr, Externalizing_sr = Externalizing_sr, Fear_sr = Fear_sr, MotionMeanRelRMS = MotionMeanRelRMS);
write.csv(All_Info_CSV, file = Resultant_CSV);
