
library('R.matlab')
library('CCA')

CCA_Permutation_SGE_function <- function(Brain_Matrix_Path, Behavior_Matrix_Path, Times_IDRange, ResultantFolder, Max_Queued, QueueOptions) {
#
# Calculating the relationship between brain measurements and behaviors using CCA
# Brain_Matrix:
#   Subjects * Features matrix
# Behavior_Matrix:
#   Subjects * behavior matrix
#
# Times_IDRange:
#   Array of index of permutations
#
# ResultantFile:
#   Path of resultant file (.mat format), optional
#

  Finish_File <- c();
  Times_IDRange_Todo <- c();
  Todo_Quantity <- 0;
  for (i in 1:length(Times_IDRange)) 
  {
    ResultantFolder_I = file.path(ResultantFolder, paste('Time_', as.character(Times_IDRange[i]), sep = ''));
    if (!dir.exists(ResultantFolder_I)) 
    {
      dir.create(ResultantFolder_I);
    }
    if (!file.exists(file.path(ResultantFolder_I, 'Res.mat'))) 
    {
      Todo_Quantity <- Todo_Quantity + 1;
      Times_IDRange_Todo[Todo_Quantity] <- Times_IDRange[i];
      writeMat(file.path(ResultantFolder_I, 'configuration.mat'), BrainMatrixPath = Brain_Matrix_Path, BehaviorMatrixPath = Behavior_Matrix_Path, ResultantFolderI = ResultantFolder_I); 
      R_cmd = paste('source("/data/joy/BBL/projects/pncClinDtiControl/scripts/CCA/CCA_Permutation_SGE_Sub_function.R");
                     library(R.matlab);
                     configuration <- readMat("', 
                     ResultantFolder_I,
                    '/configuration.mat");
                     Brain_Matrix_Path <- configuration$BrainMatrixPath;
                     Behavior_Matrix_Path <- configuration$BehaviorMatrixPath;
                     ResultantFolder_I <- configuration$ResultantFolderI;
                     CCA_Permutation_SGE_Sub_function(Brain_Matrix_Path, Behavior_Matrix_Path, ResultantFolder_I)', sep = '');
      Finish_File[Todo_Quantity] = file.path(ResultantFolder_I, 'Res.mat');
      script_R <- file(file.path(ResultantFolder_I, 'script.R'));
      writeLines(R_cmd, script_R);
      close(script_R);

      Sys_cmd = paste('Rscript ', ResultantFolder_I, '/script.R > ',ResultantFolder_I, '/perm.log 2>&1\n', sep = '');
      script_cmd <- file(file.path(ResultantFolder_I, 'script.sh'));
      writeLines(Sys_cmd, script_cmd);
      close(script_cmd); 
    }
  }

  Jobs_Quantity <- length(Finish_File);

  if (length(Times_IDRange_Todo) > Max_Queued) 
  {
    Submit_Quantity <- Max_Queued;
  } 
  else
  {
    Submit_Quantity <- length(Times_IDRange_Todo);
  }

  for (i in 1:Submit_Quantity) 
  {
    ResultantFolder_I <- paste(ResultantFolder, '/Time_', as.character(Times_IDRange_Todo[i]), sep = '');
    Option <- paste(' -V -o ', ResultantFolder_I, '/perm.o -e ', ResultantFolder_I, '/perm.e', sep = '');
    cmd <- paste('qsub ', ResultantFolder_I, '/script.sh ', QueueOptions, ' -N perm_', as.character(Times_IDRange_Todo[i]), Option, sep = '');
    system(cmd); 
  }

  if (length(Times_IDRange_Todo) > Max_Queued) 
  {
    Finished_Quantity = 0;
    while (1) 
    {
      for (i in 1:length(Finish_File)) 
      {
        if (file.exists(Finish_File[i])) 
        {
          Finished_Quantity = Finished_Quantity + 1;
          print(Finish_File[i]);
          Finish_File <- Finish_File[-i];
          print(format(Sys.time(), "%a %b %d %X %Y %Z"));
          print(paste('Finish quantity = ', as.character(Finished_Quantity), sep = ''));
          if (Submit_Quantity <= length(Times_IDRange_Todo)) 
          {
            ResultantFolder_I <- paste(ResultantFolder, '/Time_', as.character(Times_IDRange_Todo[Submit_Quantity]), sep = '');
            Option <- paste(' -V -o ', ResultantFolder_I, '/perm.o -e ', ResultantFolder_I, '/perm.e', sep = '');
            cmd <- paste('qsub ', ResultantFolder_I, '/script.sh ', QueueOptions, ' -N perm_', as.character(Times_IDRange_Todo[Submit_Quantity]), Option, sep = '');
            system(cmd);
            Submit_Quantity <- Submit_Quantity + 1;
            break;
          }
        }       
      }
      if (Finished_Quantity >= Jobs_Quantity) 
      {
        break;
      }
    }
  }
}


CCA_Permutation_SGE_Sub_function <- function(BrainMatrixPath, BehaviorMatrixPath, ResultantFolder) 
{
    
  BrainMat <- readMat(BrainMatrixPath);
  BrainMatrix <- BrainMat$BrainMatrix;

  BehaviorMat <- readMat(BehaviorMatrixPath);
  BehaviorMatrix <- BehaviorMat$BehaviorMatrix;

  CCA_function(BrainMatrix, BehaviorMatrix, file.path(ResultantFolder, 'Res.mat'));
}

CCA_Permutation_Function <- function(Brain_Matrix, Behavior_Matrix, Times, ResultantFile) 
{
#
# Calculating the relationship between brain measurements and behaviors using CCA
# Brain_Matrix:
#   Subjects * Features matrix
# Behavior_Matrix:
#   Subjects * behavior matrix
#
# Times:
#   Times of permutation
#
# ResultantFile:
#   Path of resultant file (.mat format), optional
#

  Behavior_Dim <- dim(Behavior_Matrix);
  Subjects_Quantity <- Behavior_Dim[1];
  Behavior_Quantity <- Behavior_Dim[2];

  CCA_Brain_Behavior_Corr_Random = matrix(c(1:(Times * Behavior_Quantity)), nrow = Times, ncol = Behavior_Quantity);

  for (i in 1:Times) 
  {
    print(i);
    Rand_Index <- sample(1:Subjects_Quantity, Subjects_Quantity);
    Behavior_Matrix_Random <- matrix(c(1:(Subjects_Quantity * Behavior_Quantity)), nrow = Subjects_Quantity, ncol = Behavior_Quantity);  
    Behavior_Matrix_Random[1:Subjects_Quantity,] <- Behavior_Matrix[Rand_Index,];
    CCA_Brain_Behavior_Random = cc(Brain_Matrix, Behavior_Matrix_Random);
    CCA_Brain_Behavior_Corr_Random[i, ] = CCA_function(Brain_Matrix, Behavior_Matrix_Random);
  }

  if (nargs() >= 4) 
  {
    writeMat(ResultantFile, CCA_Corr_Random = CCA_Brain_Behavior_Corr_Random);
  }

  return (CCA_Brain_Behavior_Corr_Random);
}


CCA_function <- function(Brain_Matrix, Behavior_Matrix, ResultantFile) 
{
#
# Calculating the relationship between brain measurements and behaviors using CCA
# Brain_Matrix:
#   Subjects * Features matrix
# Behavior_Matrix:
#   Subjects * behavior matrix
# ResultantFile:
#   Path of resultant file (.mat format), optional
#

  CCA_Brain_Behavior = cc(Brain_Matrix, Behavior_Matrix);
  CCA_Brain_Behavior_Corr = CCA_Brain_Behavior$cor;

  if (nargs() >= 3) 
  {
    writeMat(ResultantFile, CCACorr = CCA_Brain_Behavior_Corr);
  }

  return (CCA_Brain_Behavior_Corr);
}
