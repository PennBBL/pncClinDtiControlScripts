% Calculating average and modal controllability

clear

Data_Folder = '/data/joy/BBL/projects/pncClinDtiControl/data';
Matrix_Folder = [Data_Folder '/matrices_withoutBrainStem'];

Atlas_Yeo_Index = load([Data_Folder '/atlas/Yeo_7system_in_Lausanne234.txt']);
Atlas_Yeo_Index = Atlas_Yeo_Index(1:233);

ControlFolder = [Data_Folder '/controlData'];
FA_ResultantFolder = [ControlFolder '/FA_Control'];
mkdir(FA_ResultantFolder);

Lausanne125_FA_Matrix_Cell = g_ls([Matrix_Folder '/Lausanne125/FA/*.mat']);
for i = 1:length(Lausanne125_FA_Matrix_Cell)
    i
    [~, FileName, ~] = fileparts(Lausanne125_FA_Matrix_Cell{i});
    scanID_str = FileName(1:4);
    ResultantFile = [FA_ResultantFolder '/' num2str(scanID_str) '.mat'];

    Job_Name = ['ConCal_' num2str(i)];
    pipeline.(Job_Name).command = 'ControlCal_Function(opt.para1, opt.para2, opt.para3, files_out{1})';
    pipeline.(Job_Name).opt.para1 = Lausanne125_FA_Matrix_Cell{i};
    pipeline.(Job_Name).opt.para2 = 0.2;
    pipeline.(Job_Name).opt.para3 = Atlas_Yeo_Index;
    pipeline.(Job_Name).files_out{1} = ResultantFile;
end

ResultantFile = [ControlFolder '/Lausanne125_FA_control.mat'];
Job_Name = 'Merge';
for i = 1:length(Lausanne125_FA_Matrix_Cell)
    ConCal_JobName = ['ConCal_' num2str(i)];
    pipeline.(Job_Name).files_in{i} = pipeline.(ConCal_JobName).files_out{1};
end
pipeline.(Job_Name).command = 'ControlMerge_Function(files_in, files_out{1})';
pipeline.(Job_Name).files_out{1} = ResultantFile;

psom_gb_vars
Pipeline_opt.mode = 'qsub';
Pipeline_opt.qsub_options = '-q all.q';
Pipeline_opt.mode_pipeline_manager = 'batch';
Pipeline_opt.max_queued = 200;
Pipeline_opt.flag_verbose = 1;
Pipeline_opt.flag_pause = 1;
Pipeline_opt.path_logs = [FA_ResultantFolder '/logs'];

psom_run_pipeline(pipeline, Pipeline_opt);

