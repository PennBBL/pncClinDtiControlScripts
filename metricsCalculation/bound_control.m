function [values] = bound_control(A, rho, partitionInit);

% FUNCTION:
%        Returns values of BOUNDARY CONTROLLABILITY for each node in a
%        network, given the adjacency matrix for that network. Boundary
%        controllability measures the extent to which the node is well 
%        positioned to couple and decouple network modules.         


% DEPENDENCIES:
%        This function requires the function 'boundaryDetection.m' to be 
%        in the Matlab path.

% INPUT:
%        A: a NxN structural (NOT FUNCTIONAL) network adjacency matrix 
%        where N is the number of nodes in the network. Assumes all values 
%        in the matrix are positive, and that the matrix is symmetric.

%        rho: the free parameter that sets the threshold ratio for the 
%        detection of boundary points(nodes that contain connections to 
%        both communities). In weighted structural networks, rho is an 
%        alternative to a global threshold. Low values of rho will add the 
%        entire subnetwork to the control set for each iteration of the 
%        algorithm. High values of rho will detect few boundary points.
%        Too high  values of rho may fail to identify  a control set, 
%        in which case a warning will be returned.

%        partitionInit: an Nx1 vector of integers representing the 
%        initial community assignments of nodes in A. The partition of A
%        could be determined empirically such as with a community detection 
%        algorithm or defined by the user.

% OUTPUT:
%         Vector of ranking boundary controllability values for each node.
%         Higher values represent higher ranks in the control heirarchy.
%
% Bassett Lab, University of Pennsylvania, 2016. 
% Reference: Gu, Pasqualetti, Cieslak, Telesford, Yu, Kahn, Medaglia,
%            Vettel, Miller, Grafton & Bassett, Nature Communications
%            6:8414, 2015.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Kset = zeros(1, size(A,1)); 
    I = eye(size(A,1)); 
    cardK = size(A,1); 
    partition = partitionInit; 
    
    communities = unique(partition);
    
    % A = A./ max(A(:));
    A = A / sum(A(:));
    for i = communities'
        ind1 = find(partition == i);
        ind2 = (partition ~= i);
        
        for j = 1 : numel(ind1) 
            lala = sum(A(ind1(j), ind2)); 
            if ( lala >= rho) 
                Kset(ind1(j)) = 1; 
            end
        end
    end
    

    while (sum(Kset>0) < cardK)
        sum(Kset > 0) %
        uniPVal = unique(partition); 
        eigVals = zeros(1, numel(uniPVal)); 
        for i = 1 : numel(uniPVal) 
            if all(Kset(partition == uniPVal(i))) 
                eigVals(i) = Inf; 
            else
                A1 = A / (1+eigs(A,1));
                B = I(:, (partition == uniPVal(i)));
                [U, T] = schur(A1,'real');
                midMat = U' *(B*B')*U;
                v = diag(T);
                P = midMat ./(1 - v*v');
                H2 = sqrt(trace(P));
                eigValues = svd(P);
                eigVals(i) = eigValues(end); 
            end
        end
        if (all(eigVals == Inf)) 
            break; 
        end
        [~, l] = min(eigVals); 
        indL = find(partition == uniPVal(l)); 

        [boundInd, newPart, ~] = boundaryDetection(A, indL, rho);

        if(sum(boundInd) > 0); 
            Kset(Kset > 0) = Kset(Kset > 0) + 1; 
            Kset(boundInd) = 1;
        end
        if (numel(newPart > 0))
            partition(newPart) = max(uniPVal) + 1;
        end
      
    end
    indices = Kset;
    M = max(Kset);
    for i = 1:M
        indices(Kset == i) = sum(Kset <= i);
    end
    
    values = indices;
