function [avg_cont, mod_cont, bound_cont] = ControlCal_Function(ConnPath, rho, partitionInit, ResultantFile)

%
% ConnPath:
%    The path of the .mat file which contains a matrix named 'connectivity'
%

load(ConnPath);
avg_cont = ave_control(connectivity);
mod_cont = modal_control(connectivity);
bnd_cont = bound_control(connectivity, rho, partitionInit);

save(ResultantFile, 'avg_cont', 'mod_cont', 'bnd_cont');
