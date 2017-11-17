
function ConMerge_Function(ConFile_Cell, ResultantFile)

SubjectsQuantity = length(ConFile_Cell);
tmp = load(ConFile_Cell{1});
NodesQuantity = length(tmp.avg_cont);
avg_cont = zeros(SubjectsQuantity, NodesQuantity);
mod_cont = zeros(SubjectsQuantity, NodesQuantity);
bnd_cont = zeros(SubjectsQuantity, NodesQuantity);
for i = 1:length(ConFile_Cell)
    tmp = load(ConFile_Cell{i});
    avg_cont(i, :) = tmp.avg_cont;
    mod_cont(i, :) = tmp.avg_cont;
    bnd_cont(i, :) = tmp.bnd_cont;
    [~, FileName, ~] = fileparts(ConFile_Cell{i});
    scan_ID(i) = str2num(FileName);
end
save(ResultantFile, 'avg_cont', 'mod_cont', 'bnd_cont', 'scan_ID');
