########################################################################################################
### This script will construct a subject sample for Rick's PNC-Control-Clinical analyses, retaining  ###
###     subjects who passed quality assurance protocols for Freesurfer, DTI, and healthExcludev2     ###
########################################################################################################

## LTN and Health Status
health <- read.csv("/data/joy/BBL/projects/pncClinDtiControl/data/n1601_health_20170421.csv")
## T1
t1_qa <- read.csv("/data/joy/BBL/projects/pncClinDtiControl/data/n1601_t1QaData_20170306.csv")
## DTI 
dti_qa <- read.csv("/data/joy/BBL/projects/pncClinDtiControl/data/n1601_dti_qa_20170301.csv")
## B0 Acquisition
protVal <- read.csv("/data/joy/BBL/projects/pncClinDtiControl/data/n1601_pnc_protocol_validation_params_status_20161220.csv")
## Demographics
demo <- read.csv("/data/joy/BBL/projects/pncClinDtiControl/data/n1601_demographics_go1_20161212.csv")
## Clinical Scores
clin_bifactor <- read.csv("/data/joy/BBL/projects/pncClinDtiControl/data/n1601_goassess_itemwise_bifactor_scores_20161219.csv")
clin_corrtraits <- read.csv("/data/joy/BBL/projects/pncClinDtiControl/data/n1601_goassess_itemwise_corrtraits_scores_20161219.csv")
clin_fscores <- read.csv("/data/joy/BBL/projects/pncClinDtiControl/data/n1601_goassess_itemwise_fscores_self_regressed_20170131.csv")
## Subject identifier
tracker <- read.csv("/data/joy/BBL/projects/pncClinDtiControl/data/n1601_tracker_go1_20161212.csv")
tracker <- tracker[c("bblid","scanid")]

##############################
### Merge demographic data ###
##############################
demo <- merge(demo, health, by=c("bblid","scanid"))
demo <- merge(demo, t1_qa, by=c("bblid","scanid"))
demo <- merge(demo, dti_qa, by=c("bblid","scanid"))
demo <- merge(demo, protVal, by=c("bblid","scanid"))
demo <- merge(demo, clin_bifactor, by=c("bblid","scanid"))
demo <- merge(demo, clin_corrtraits, by=c("bblid","scanid"))
demo <- merge(demo, clin_fscores, by=c("bblid","scanid"))

####################################################
### Define study sample using exclusion criteria ###
####################################################
Betzel_df <- demo

## FreeSurfer QA
Betzel_df <- Betzel_df[which(Betzel_df$fsFinalExclude == 0), ] 

## Valid and complete 64-direction DTI sequence
Betzel_df <- Betzel_df[which(Betzel_df$dti64ProtocolValidationStatus == 1), ]

## B0 acquisition and distortion correction
Betzel_df <- Betzel_df[which(Betzel_df$b0ProtocolValidationStatus==1), ]

## Roalf's DTI QA
Betzel_df <- Betzel_df[which(Betzel_df$dti64Exclude == 0), ]
dim(Betzel_df)

## Health Exclude
Betzel_df <- Betzel_df[which(Betzel_df$healthExcludev2 == 0), ]
dim(Betzel_df)
####################################################

## Specify columns to retain
attach(Betzel_df)
keeps <- c("bblid", "scanid")
  
## Define new dataframe with specified columns 
subjid_df <- Betzel_df[keeps]
dim(subjid_df)
detach(Betzel_df)

## Write out subject identifiers to CSV
write.csv(subjid_df, "/data/joy/BBL/projects/pncClinDtiControl/subjectLists/pncClinDtiControl_n1089_subjectIDs.csv", row.names=FALSE)

## Write out all demographics and QA data to CSV
write.csv(Betzel_df, "/data/joy/BBL/projects/pncClinDtiControl/subjectLists/pncClinDtiControl_n1089_subject_data.csv", row.names=FALSE)

