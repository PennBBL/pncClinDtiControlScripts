function sync = sync_Calculation(Network_Matrix)
    Degree = sum(Network_Matrix);
    lap = diag(Degree) - Network_Matrix;
    e = (eig(lap));
    [Node_Quantity, ~] = size(Network_Matrix);
    e2 = e(2:Node_Quantity); % because the first one is zero
    Degree_Avg = sum(Degree)/Node_Quantity;
    sync = (d^2) / var(e2, 1);
