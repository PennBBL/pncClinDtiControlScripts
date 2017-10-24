function ROI_distance = ZC_ROI_distance(Atlas_Path)

[ParentFolder, FileName, Suffix] = fileparts(Atlas_Path);
Tmp_File = [ParentFolder '/tmp.nii'];
cmd = ['fslchfiletype NIFTI ' Atlas_Path ' ' Tmp_File];
system(cmd);

hdr = spm_vol(Tmp_File);
[data, XYZ_Physical] = spm_read_vols(hdr);
ROI_Quantity = length(unique(data)) - 1;
for i =1:ROI_Quantity
    index = find(data == i);
    XYZ_Physical_ROI_i = XYZ_Physical(:, index);
    Corrd_ROI_mean(i, :) = mean(XYZ_Physical_ROI_i, 2);
end
ROI_distance = Corrd_ROI_mean * Corrd_ROI_mean';
ROI_distance = ROI_distance - ROI_distance .* eye(ROI_Quantity);
pause(3);
delete(Tmp_File);

