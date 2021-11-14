function coefs = wv_rec(sig, wname, n)
coefs = {sig};
while n > 0
    x = coefs{1};
    coefs = coefs(2:end);
    [cA, cD] = dwt(x, wname);
    coefs = [cA; cD; coefs(:)];
    n = n-1;
end
end
