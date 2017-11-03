#!/bin/sh

## Define subject list
scanid_list=$(cut -d',' -f2 < /data/joy/BBL/projects/pncClinDtiControl/subjectLists/pncClinDtiControl_n1089_subjectIDs.csv) 

# SC_outdir=/data/joy/BBL/projects/pncClinDtiControl/data/matrices/Lausanne125/streamlineCount
# mkdir -p ${SC_outdir}

# FA_outdir=/data/joy/BBL/projects/pncClinDtiControl/data/matrices/Lausanne125/FA
# mkdir -p ${FA_outdir}

volNorm_outdir=/data/joy/BBL/projects/pncClinDtiControl/data/matrices/Lausanne60/volNormSC
mkdir -p ${volNorm_outdir}

for name in ${scanid_list}; do
	scanid=$name
	echo $scanid
	
	# Streamline count matrix path
#	SC_path=/data/joy/BBL/studies/pnc/n1601_dataFreeze/neuroimaging/dti/deterministic_dec2016/streamlineCount/LausanneScale125/"${scanid}"_streamlineCount_LausanneScale125.mat
	# FA matrix path
#	FA_path=/data/joy/BBL/studies/pnc/n1601_dataFreeze/neuroimaging/dti/deterministic_dec2016/FA/LausanneScale125/"${scanid}"_FA_LausanneScale125.mat

	volNorm_path=/data/joy/BBL/studies/pnc/n1601_dataFreeze/neuroimaging/dti/deterministic_dec2016/volNormStreamline/LausanneScale60/"${scanid}"_volNormStreamline_LausanneScale60.mat

# 	cp ${SC_path} ${SC_outdir}
#	cp ${FA_path} ${FA_outdir}
	cp ${volNorm_path} ${volNorm_outdir}
done

