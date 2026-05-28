function coefs = interp_newton(X, Y)
    if nargin < 2
        X = [0 0.5 1];
        Y = [1 2.12 3.55];
        fprintf('Executando Interpolação de Newton com pontos padrões:\n');
    end

    n = length(X);
    D = zeros(n, n);
    D(:,1) = Y(:);

    fprintf('\n--- INTERPOLAÇÃO DE NEWTON (Diferenças Divididas) ---\n\n');

    % Construção da tabela
    for j = 2:n
        for i = 1:n-j+1
            D(i,j) = (D(i+1,j-1) - D(i,j-1)) / (X(i+j-1) - X(i));
        end
    end

    fprintf('Tabela de Diferenças Divididas:\n');
    disp(D);

    coefs = D(1, :);

    fprintf('Coeficientes do polinômio (forma de Newton):\n');
    disp(coefs);

    % Cálculo do erro DR
    Dr = 0;
    for i = 1:n
        val = coefs(1);
        p = 1;
        for j = 2:n
            p = p * (X(i) - X(j-1));
            val = val + coefs(j) * p;
        end
        res = abs(Y(i) - val);
        if res > Dr
            Dr = res;
        end
    end

    fprintf('\n>> DR (Erro Máximo Residual nos nós) = %.6e <<\n\n', Dr);

    % Geração da curva
    x_g = linspace(min(X), max(X), 200);
    y_g = zeros(size(x_g));

    for k = 1:length(x_g)
        val = coefs(1);
        p = 1;
        for j = 2:n
            p = p * (x_g(k) - X(j-1));
            val = val + coefs(j) * p;
        end
        y_g(k) = val;
    end

    % Plot
    figure;
    plot(X, Y, 'ro', 'MarkerSize', 8, 'LineWidth', 2); hold on;
    plot(x_g, y_g, 'b-', 'LineWidth', 1.5);
    title('Interpolação de Newton');
    xlabel('X'); ylabel('Y'); grid on;
    legend('Pontos', 'Polinômio');
end
