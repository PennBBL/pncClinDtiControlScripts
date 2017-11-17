
library('R.matlab')

Behavior_Folder <- '/data/joy/BBL/projects/pncClinDtiControl/data/subjectData';
Behavior_Path <- file.path(Behavior_Folder, 'n1089_Bifactor_DtiMotion_Demogra.mat');
Behavior <- readMat(Behavior_Path);

# regressing covariates for bi-factors
  # regress sex, age, race and head motion
tmp <- lm(Mood ~ Sex + Age + Race2 + MotionMeanRelRMS, Behavior);
Mood_regRace <- resid(tmp);
tmp <- lm(Psychosis ~ Sex + Age + Race2 + MotionMeanRelRMS, Behavior);
Psychosis_regRace <- resid(tmp); 
tmp <- lm(Externalizing ~ Sex + Age + Race2 + MotionMeanRelRMS, Behavior);
Externalizing_regRace <- resid(tmp);
tmp <- lm(Phobias ~ Sex + Age + Race2 + MotionMeanRelRMS, Behavior);
Phobias_regRace <- resid(tmp);
tmp <- lm(OverallPsycho ~ Sex + Age + Race2 + MotionMeanRelRMS, Behavior);
OverallPsychos_regRace <- resid(tmp);

writeMat(file.path(Behavior_Folder, 'n1089_Bifactor_regRace.mat'), Mood_regRace = Mood_regRace, Psychosis_regRace = Psychosis_regRace, Externalizing_regRace = Externalizing_regRace, Phobias_regRace = Phobias_regRace, verallPsychos_regRace = OverallPsychos_regRace);

  # regress sex, age and head motion
tmp <- lm(Mood ~ Sex + Age + MotionMeanRelRMS, Behavior);
Mood_reg <- resid(tmp);
tmp <- lm(Psychosis ~ Sex + Age + MotionMeanRelRMS, Behavior);
Psychosis_reg <- resid(tmp);
tmp <- lm(Externalizing ~ Sex + Age + MotionMeanRelRMS, Behavior);
Externalizing_reg <- resid(tmp);
tmp <- lm(Phobias ~ Sex + Age + MotionMeanRelRMS, Behavior);
Phobias_reg <- resid(tmp);
tmp <- lm(OverallPsycho ~ Sex + Age + MotionMeanRelRMS, Behavior);
OverallPsychos_reg <- resid(tmp);

writeMat(file.path(Behavior_Folder, 'n1089_Bifactor_reg.mat'), Mood_reg = Mood_reg, Psychosis_reg = Psychosis_reg, Externalizing_reg = Externalizing_reg, Phobias_reg = Phobias_reg, verallPsychos_reg = OverallPsychos_reg);

