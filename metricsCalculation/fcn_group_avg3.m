function G = fcn_group_avg3(A,dist,hemiid)
[n,~,nsub] = size(A);
C = sum(A > 0,3);
W = sum(A,3)./C;
Grp = zeros(n,n,2);
for j = 1:2
    if j == 1
        d = +(hemiid == 1)*(hemiid' == 2);
        d = d | d';
    else
        d = +(hemiid == 1)*(hemiid' == 1) | +(hemiid == 2)*(hemiid' == 2);
        d = d | d';
    end
    D = nonzeros(bsxfun(@times,(A > 0),dist.*triu(d)));
    M = round(length(D))/nsub;
    dist_hemi = dist.*d;
    [x,y] = ecdf(D);
    x = round(x.*M);
    G = zeros(n);
    for i = 1:M
        ind = (x >= (i - 1)) & (x < i);
        if sum(ind)
            yy = y(ind);
            mask = dist_hemi >= min(yy) & dist_hemi <= max(yy);
            [u,v] = find(triu(mask,1));
            indx = (v - 1)*n + u;
            c = C(indx);
            w = W(indx);
            zz = sum(c == max(c));
            if zz == 1
                [~,indmax] = max(c);
                G(indx(indmax)) = 1;
            else
                aa = find(c == max(c));
                ww = w(aa);
                [~,indsort] = sort(ww,'descend');
                G(indx(aa(indsort(1)))) = 1;
            end
        end
    end
    Grp(:,:,j) = G;
end
G = sum(Grp,3); G = G + G';