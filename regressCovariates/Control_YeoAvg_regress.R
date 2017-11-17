
library('R.matlab')

Data_Folder <- '/data/joy/BBL/projects/pncClinDtiControl/data';
Control_Folder <- file.path(Data_Folder, 'controlData');
Con_FA_Path <- file.path(Control_Folder, 'Lausanne125_FA_control_YeoSystemAvg.mat');
Con_SC_Path <- file.path(Control_Folder, 'Lausanne125_SC_control_YeoSystemAvg.mat');
Con_volNormSC_Path <- file.path(Control_Folder, 'Lausanne125_volNormSC_control_YeoSystemAvg.mat');

Behavior_Path <- file.path(Data_Folder, 'subjectData/n1089_Bifactor_DtiMotion_Demogra.mat');
Behavior <- readMat(Behavior_Path);

# FA
Con_FA_Mat <- readMat(Con_FA_Path);
avg_cont <- Con_FA_Mat$avg.cont;
mod_cont <- Con_FA_Mat$mod.cont;
bnd_cont <- Con_FA_Mat$bnd.cont;
scan_ID <- Con_FA_Mat$scan.ID;

dimension <- dim(avg_cont);
SubjectsQuantity <- dimension[1];
RegionsQuantity <- dimension[2];
  # initialize these six variables
avg_cont_reg_Race <- avg_cont;
mod_cont_reg_Race <- avg_cont;
bnd_cont_reg_Race <- avg_cont;
avg_cont_reg <- avg_cont;
mod_cont_reg <- avg_cont;
bnd_cont_reg <- avg_cont;
  # regress covariates
for (i in 1:RegionsQuantity) {
  tmp <- lm(avg_cont[, i] ~ Sex + Age + Race2 + MotionMeanRelRMS, Behavior);
  avg_cont_reg_Race[, i] <- resid(tmp);
  tmp <- lm(mod_cont[, i] ~ Sex + Age + Race2 + MotionMeanRelRMS, Behavior);
  mod_cont_reg_Race[, i] <- resid(tmp);
  tmp <- lm(bnd_cont[, i] ~ Sex + Age + Race2 + MotionMeanRelRMS, Behavior);
  bnd_cont_reg_Race[, i] <- resid(tmp);

  tmp <- lm(avg_cont[, i] ~ Sex + Age + MotionMeanRelRMS, Behavior);
  avg_cont_reg[, i] <- resid(tmp);
  tmp <- lm(mod_cont[, i] ~ Sex + Age + MotionMeanRelRMS, Behavior);
  mod_cont_reg[, i] <- resid(tmp);
  tmp <- lm(bnd_cont[, i] ~ Sex + Age + MotionMeanRelRMS, Behavior);
  bnd_cont_reg[, i] <- resid(tmp);
}
writeMat(file.path(Control_Folder, 'Lausanne125_FA_Control_YeoSystemAvg_regRace.mat'), avg_cont_reg_Race = avg_cont_reg_Race, mod_cont_reg_Race = mod_cont_reg_Race, bnd_cont_reg_Race = bnd_cont_reg_Race, scan_ID = scan_ID);
writeMat(file.path(Control_Folder, 'Lausanne125_FA_Control_YeoSystemAvg_reg.mat'), avg_cont_reg = avg_cont_reg, mod_cont_reg = mod_cont_reg, bnd_cont_reg = bnd_cont_reg, scan_ID = scan_ID);

# SC 
Con_SC_Mat <- readMat(Con_SC_Path);
avg_cont <- Con_SC_Mat$avg.cont;
mod_cont <- Con_SC_Mat$mod.cont;
bnd_cont <- Con_SC_Mat$bnd.cont;
scan_ID <- Con_SC_Mat$scan.ID;

for (i in 1:RegionsQuantity) {
  tmp <- lm(avg_cont[, i] ~ Sex + Age + Race2 + MotionMeanRelRMS, Behavior);
  avg_cont_reg_Race[, i] <- resid(tmp);
  tmp <- lm(mod_cont[, i] ~ Sex + Age + Race2 + MotionMeanRelRMS, Behavior);
  mod_cont_reg_Race[, i] <- resid(tmp);
  tmp <- lm(bnd_cont[, i] ~ Sex + Age + Race2 + MotionMeanRelRMS, Behavior);
  bnd_cont_reg_Race[, i] <- resid(tmp);

  tmp <- lm(avg_cont[, i] ~ Sex + Age + MotionMeanRelRMS, Behavior);
  avg_cont_reg[, i] <- resid(tmp);
  tmp <- lm(mod_cont[, i] ~ Sex + Age + MotionMeanRelRMS, Behavior);
  mod_cont_reg[, i] <- resid(tmp);
  tmp <- lm(bnd_cont[, i] ~ Sex + Age + MotionMeanRelRMS, Behavior);
  bnd_cont_reg[, i] <- resid(tmp);
}
writeMat(file.path(Control_Folder, 'Lausanne125_SC_Control_YeoSystemAvg_regRace.mat'), avg_cont_reg_Race = avg_cont_reg_Race, mod_cont_reg_Race = mod_cont_reg_Race, bnd_cont_reg_Race = bnd_cont_reg_Race, scan_ID = scan_ID);
writeMat(file.path(Control_Folder, 'Lausanne125_SC_Control_YeoSystemAvg_reg.mat'), avg_cont_reg = avg_cont_reg, mod_cont_reg = mod_cont_reg, bnd_cont_reg = bnd_cont_reg, scan_ID = scan_ID);

# volNormSC
Con_volNormSC_Mat <- readMat(Con_volNormSC_Path);
avg_cont <- Con_volNormSC_Mat$avg.cont;
mod_cont <- Con_volNormSC_Mat$mod.cont;
bnd_cont <- Con_volNormSC_Mat$bnd.cont;
scan_ID <- Con_volNormSC_Mat$scan.ID;

for (i in 1:RegionsQuantity) {
  tmp <- lm(avg_cont[, i] ~ Sex + Age + Race2 + MotionMeanRelRMS, Behavior);
  avg_cont_reg_Race[, i] <- resid(tmp);
  tmp <- lm(mod_cont[, i] ~ Sex + Age + Race2 + MotionMeanRelRMS, Behavior);
  mod_cont_reg_Race[, i] <- resid(tmp);
  tmp <- lm(bnd_cont[, i] ~ Sex + Age + Race2 + MotionMeanRelRMS, Behavior);
  bnd_cont_reg_Race[, i] <- resid(tmp);

  tmp <- lm(avg_cont[, i] ~ Sex + Age + MotionMeanRelRMS, Behavior);
  avg_cont_reg[, i] <- resid(tmp);
  tmp <- lm(mod_cont[, i] ~ Sex + Age + MotionMeanRelRMS, Behavior);
  mod_cont_reg[, i] <- resid(tmp);
  tmp <- lm(bnd_cont[, i] ~ Sex + Age + MotionMeanRelRMS, Behavior);
  bnd_cont_reg[, i] <- resid(tmp);
}

writeMat(file.path(Control_Folder, 'Lausanne125_volNormSC_Control_YeoSystemAvg_regRace.mat'), avg_cont_reg_Race = avg_cont_reg_Race, mod_cont_reg_Race = mod_cont_reg_Race, bnd_cont_reg_Race = bnd_cont_reg_Race, scan_ID = scan_ID);
writeMat(file.path(Control_Folder, 'Lausanne125_volNormSC_Control_YeoSystemAvg_reg.mat'), avg_cont_reg = avg_cont_reg, mod_cont_reg = mod_cont_reg, bnd_cont_reg = bnd_cont_reg, scan_ID = scan_ID);
