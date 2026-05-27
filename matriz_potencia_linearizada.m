function M = matriz_potencia_linearizada(X, Y)
    % Retorna matriz pronta para regressão linear do modelo:
    % y = alpha * x^beta  ->  ln(y) = ln(alpha) + beta ln(x)

    X = X(:);
    Y = Y(:);

    M = [log(X) log(Y)];
end
