
# Calculating the relationship between network controllability and behavioral bifactors

library('R.matlab')
library('mgcv')

Controllability_Mat <- readMat('/data/joy/BBL/projects/pncClinDtiControl/data/controlData/Lausanne125_SC_control.mat');
Avg_Controllability <- Controllability_Mat$avg.cont;
Mod_Controllability <- Controllability_Mat$mod.cont;

Behavioral <- readMat('/data/joy/BBL/projects/pncClinDtiControl/data/subjectData/n1089_Bifactor_DtiMotion_Demogra.mat');
Behavioral$Sex <- as.factor(Behavioral$Sex);
Behavioral$Race <- as.factor(Behavioral$Race);
Behavioral$Age <- as.numeric(Behavioral$Age);
Behavioral$Mood <- as.numeric(Behavioral$Mood);
Behavioral$Psychosis <- as.numeric(Behavioral$Psychosis);
Behavioral$Externalizing <- as.numeric(Behavioral$Externalizing);
Behavioral$Phobias <- as.numeric(Behavioral$Phobias);
Behavioral$OverallPsycho <- as.numeric(Behavioral$OverallPsycho);
Behavioral$MotionMeanRelRMS <- as.numeric(Behavioral$MotionMeanRelRMS);
# 1089 subjects in all, and they have all the behavioral scores (all the behavioral scores above are not NAN)

tmp <- dim(Avg_Controllability);
NodesQuantity <- tmp[2];
ColName <- c("Age_F", "Mood_F", "Psychosis_F", "Externalizing_F", "Phobias_F", "OverallPsycho_F", "Age_P", "Mood_P", "Psychosis_P", "Externalizing_P", "Phobias_P", "OverallPsycho_P", "Age_CorrectP", "Mood_CorrectP", "Psychosis_CorrectP", "Externalizing_CorrectP", "Phobias_CorrectP", "OverallPsycho_CorrectP");
RowName <- character(length = 233);
for (i in 1:233){
  RowName[i] = paste("Node", as.character(i)); 
}

Avg_Con_Gam_F_P_Matrix <- matrix(c(1:(233*18)), nrow = 233, ncol = 18, dimnames = list(RowName, ColName));
for (i in 1:NodesQuantity){
  print(i);
  Avg_Con_Gam <- gam(Avg_Controllability[, i] ~ s(Age) + s(Mood) + s(Psychosis) + s(Externalizing) + s(Phobias) + s(OverallPsycho) + Sex + MotionMeanRelRMS, fx = TRUE, data = Behavioral);
  Avg_Con_Gam_F_P_Matrix[i, 1:12]  <- as.vector(summary(Avg_Con_Gam)$s.table[,3:4]);
  # resultant vector, in each row, the first 6 elements were f values, and the next 6 elements were p values
}
for (i in 1:6){
  Avg_Con_Gam_F_P_Matrix[, 12 + i] <- p.adjust(Avg_Con_Gam_F_P_Matrix[, 6 + i], "fdr");
}
  
Mod_Con_Gam_F_P_Matrix <- matrix(c(1:(233*18)), nrow = 233, ncol = 18, dimnames = list(RowName, ColName));
for (i in 1:NodesQuantity){
  print(i);
  Mod_Con_Gam <- gam(Mod_Controllability[, i] ~ s(Age) + s(Mood) + s(Psychosis) + s(Externalizing) + s(Phobias) + s(OverallPsycho) + Sex + MotionMeanRelRMS, fx = TRUE, data = Behavioral);
  Mod_Con_Gam_F_P_Matrix[i, 1:12] <- as.vector(summary(Mod_Con_Gam)$s.table[,3:4]);
}
for (i in 1:6){
  Mod_Con_Gam_F_P_Matrix[, 12 + i] <- p.adjust(Mod_Con_Gam_F_P_Matrix[, 6 + i], "fdr");
}

Avg_Con_Gam_ResultantCSV <- '/data/joy/BBL/projects/pncClinDtiControl/data/controlData/Avg_Con_Gam_F_P.csv';
write.csv(Avg_Con_Gam_F_P_Matrix, Avg_Con_Gam_ResultantCSV);
Avg_Con_Gam_ResultantMat <- '/data/joy/BBL/projects/pncClinDtiControl/data/controlData/Avg_Con_Gam_F_P.mat';
writeMat(Avg_Con_Gam_ResultantMat, Age_F = Avg_Con_Gam_F_P_Matrix[, 1], Mood_F = Avg_Con_Gam_F_P_Matrix[, 2], Psychosis_F = Avg_Con_Gam_F_P_Matrix[, 3], Externalizing_F = Avg_Con_Gam_F_P_Matrix[, 4], Phobias_F = Avg_Con_Gam_F_P_Matrix[, 5], OverallPsycho_F = Avg_Con_Gam_F_P_Matrix[, 6], Age_P = Avg_Con_Gam_F_P_Matrix[, 7], Mood_P = Avg_Con_Gam_F_P_Matrix[, 8], Psychosis_P = Avg_Con_Gam_F_P_Matrix[, 9], Externalizing_P = Avg_Con_Gam_F_P_Matrix[, 10], Phobias_P = Avg_Con_Gam_F_P_Matrix[, 11], OverallPsycho_P = Avg_Con_Gam_F_P_Matrix[, 12], Age_CorrectP = Avg_Con_Gam_F_P_Matrix[, 13], Mood_CorrectP = Avg_Con_Gam_F_P_Matrix[, 14], Psychosis_CorrectP = Avg_Con_Gam_F_P_Matrix[, 15], Externalizing_CorrectP = Avg_Con_Gam_F_P_Matrix[, 16], Phobias_CorrectP = Avg_Con_Gam_F_P_Matrix[, 17], OverallPsycho_CorrectP = Avg_Con_Gam_F_P_Matrix[, 18]); 

Mod_Con_Gam_ResultantCSV <- '/data/joy/BBL/projects/pncClinDtiControl/data/controlData/Mod_Con_Gam_F_P.csv';
write.csv(Mod_Con_Gam_F_P_Matrix, Mod_Con_Gam_ResultantCSV);
Mod_Con_Gam_ResultantMat <- '/data/joy/BBL/projects/pncClinDtiControl/data/controlData/Mod_Con_Gam_F_P.mat';
writeMat(Mod_Con_Gam_ResultantMat, Age_F = Mod_Con_Gam_F_P_Matrix[, 1], Mood_F = Mod_Con_Gam_F_P_Matrix[, 2], Psychosis_F = Mod_Con_Gam_F_P_Matrix[, 3], Externalizing_F = Mod_Con_Gam_F_P_Matrix[, 4], Phobias_F = Mod_Con_Gam_F_P_Matrix[, 5], OverallPsycho_F = Mod_Con_Gam_F_P_Matrix[, 6], Age_P = Mod_Con_Gam_F_P_Matrix[, 7], Mood_P = Mod_Con_Gam_F_P_Matrix[, 8], Psychosis_P = Mod_Con_Gam_F_P_Matrix[, 9], Externalizing_P = Mod_Con_Gam_F_P_Matrix[, 10], Phobias_P = Mod_Con_Gam_F_P_Matrix[, 11], OverallPsycho_P = Mod_Con_Gam_F_P_Matrix[, 12], Age_CorrectP = Mod_Con_Gam_F_P_Matrix[, 13], Mood_CorrectP = Mod_Con_Gam_F_P_Matrix[, 14], Psychosis_CorrectP = Mod_Con_Gam_F_P_Matrix[, 15], Externalizing_CorrectP = Mod_Con_Gam_F_P_Matrix[, 16], Phobias_CorrectP = Mod_Con_Gam_F_P_Matrix[, 17], OverallPsycho_CorrectP = Mod_Con_Gam_F_P_Matrix[, 18]); 
