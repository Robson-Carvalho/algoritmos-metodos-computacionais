function V = matriz_vandermonde(X)
    n = length(X);
    V = zeros(n, n);

    for i = 1:n
        for j = 1:n
            V(i,j) = X(i)^(j-1);
        end
    end
end
