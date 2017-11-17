
library('R.matlab')

Behavior_Folder <- '/data/joy/BBL/projects/pncClinDtiControl/data/subjectData';
Behavior_Path <- file.path(Behavior_Folder, 'n1089_Corrtraits_DtiMotion_Demogra.mat');
Behavior <- readMat(Behavior_Path);

# regressing covariates for corrtraits
  # regress sex, age, race and head motion
tmp <- lm(Mood ~ Sex + Age + Race2 + MotionMeanRelRMS, Behavior);
Mood_regRace <- resid(tmp);
tmp <- lm(Psychosis ~ Sex + Age + Race2 + MotionMeanRelRMS, Behavior);
Psychosis_regRace <- resid(tmp); 
tmp <- lm(Externalizing ~ Sex + Age + Race2 + MotionMeanRelRMS, Behavior);
Externalizing_regRace <- resid(tmp);
tmp <- lm(Fear ~ Sex + Age + Race2 + MotionMeanRelRMS, Behavior);
Fear_regRace <- resid(tmp);
  # for _sr
tmp <- lm(Mood.sr ~ Sex + Age + Race2 + MotionMeanRelRMS, Behavior);
Mood_sr_regRace <- resid(tmp);
tmp <- lm(Psychosis.sr ~ Sex + Age + Race2 + MotionMeanRelRMS, Behavior);
Psychosis_sr_regRace <- resid(tmp);
tmp <- lm(Externalizing.sr ~ Sex + Age + Race2 + MotionMeanRelRMS, Behavior);
Externalizing_sr_regRace <- resid(tmp);
tmp <- lm(Fear.sr ~ Sex + Age + Race2 + MotionMeanRelRMS, Behavior);
Fear_sr_regRace <- resid(tmp);

writeMat(file.path(Behavior_Folder, 'n1089_Corrtraits_regRace.mat'), Mood_regRace = Mood_regRace, Psychosis_regRace = Psychosis_regRace, Externalizing_regRace = Externalizing_regRace, Fear_regRace = Fear_regRace, Mood_sr_regRace = Mood_sr_regRace, Psychosis_sr_regRace = Psychosis_sr_regRace, Externalizing_sr_regRace = Externalizing_sr_regRace, Fear_sr_regRace = Fear_sr_regRace);

  # regress sex, age, and head motion
tmp <- lm(Mood ~ Sex + Age + MotionMeanRelRMS, Behavior);
Mood_reg <- resid(tmp);
tmp <- lm(Psychosis ~ Sex + Age + MotionMeanRelRMS, Behavior);
Psychosis_reg <- resid(tmp);
tmp <- lm(Externalizing ~ Sex + Age + MotionMeanRelRMS, Behavior);
Externalizing_reg <- resid(tmp);
tmp <- lm(Fear ~ Sex + Age + MotionMeanRelRMS, Behavior);
Fear_reg <- resid(tmp);
  # for _sr
tmp <- lm(Mood.sr ~ Sex + Age + MotionMeanRelRMS, Behavior);
Mood_sr_reg <- resid(tmp);
tmp <- lm(Psychosis.sr ~ Sex + Age + MotionMeanRelRMS, Behavior);
Psychosis_sr_reg <- resid(tmp);
tmp <- lm(Externalizing.sr ~ Sex + Age + MotionMeanRelRMS, Behavior);
Externalizing_sr_reg <- resid(tmp);
tmp <- lm(Fear.sr ~ Sex + Age + MotionMeanRelRMS, Behavior);
Fear_sr_reg <- resid(tmp);

writeMat(file.path(Behavior_Folder, 'n1089_Corrtraits_reg.mat'), Mood_reg = Mood_reg, Psychosis_reg = Psychosis_reg, Externalizing_reg = Externalizing_reg, Fear_reg = Fear_reg, Mood_sr_reg = Mood_sr_reg, Psychosis_sr_reg = Psychosis_sr_reg, Externalizing_sr_reg = Externalizing_sr_reg, Fear_sr_reg = Fear_sr_reg);

