function coefs = interp_vandermonde(X, Y)

    if nargin < 2
        X = [1, 2, 4, 5];
        Y = [1, 3, 12, 19];
        fprintf('Executando Interpolação de Vandermonde com pontos padrões:\n');
    end

    n = length(X);
    V = zeros(n, n);

    fprintf('\n========================================\n');
    fprintf(' INTERPOLAÇÃO POR VANDERMONDE\n');
    fprintf('========================================\n\n');

    % ============================
    % PASSO 1 - Mostrar pontos
    % ============================
    fprintf('Pontos fornecidos:\n');
    for i = 1:n
        fprintf('  P%d = (%.4f, %.4f)\n', i, X(i), Y(i));
    end
    fprintf('\n');

    % ============================
    % PASSO 2 - Construir V
    % ============================
    fprintf('Construindo matriz de Vandermonde V:\n\n');

    for i = 1:n
        for j = 1:n
            V(i,j) = X(i)^(j-1);
        end
    end

    disp(V);

    % ============================
    % PASSO 3 - Sistema
    % ============================
    fprintf('Sistema a resolver:\n');
    fprintf('V * a = Y\n\n');

    A_ext = [V, Y(:)];

    fprintf('Matriz estendida [V | Y]:\n');
    disp(A_ext);

    % ============================
    % PASSO 4 - Eliminação
    % ============================
    fprintf('Aplicando Eliminação de Gauss:\n\n');

    for k = 1:n-1
        fprintf('Passo %d:\n', k);
        for i = k+1:n
            m = A_ext(i,k) / A_ext(k,k);
            fprintf('  L%d = L%d - (%.4f)*L%d\n', i, i, m, k);
            A_ext(i,k:end) = A_ext(i,k:end) - m * A_ext(k,k:end);
        end
        disp(A_ext);
    end

    % ============================
    % PASSO 5 - Substituição
    % ============================
    coefs = zeros(n, 1);

    fprintf('Substituição retroativa:\n\n');

    coefs(n) = A_ext(n,end) / A_ext(n,n);
    fprintf('a%d = %.6f\n', n-1, coefs(n));

    for i = n-1:-1:1
        soma = 0;
        for j = i+1:n
            soma = soma + A_ext(i,j) * coefs(j);
        end
        coefs(i) = (A_ext(i,end) - soma) / A_ext(i,i);
        fprintf('a%d = %.6f\n', i-1, coefs(i));
    end

    % ============================
    % RESULTADO FINAL
    % ============================
    fprintf('\nCoeficientes finais:\n');
    disp(coefs);

    fprintf('Polinômio:\nP(x) = ');
    for i = 1:n
        fprintf('(%.4f)x^%d', coefs(i), i-1);
        if i < n
            fprintf(' + ');
        end
    end
    fprintf('\n\n');

    % ============================
    % DR
    % ============================
    Dr = 0;
    for i = 1:n
        val = 0;
        for j = 1:n
            val = val + coefs(j) * X(i)^(j-1);
        end
        res = abs(Y(i) - val);
        if res > Dr
            Dr = res;
        end
    end

    fprintf('>> DR = %.6e <<\n\n', Dr);

    % ============================
    % GRÁFICO
    % ============================
    x_g = linspace(min(X), max(X), 200);
    y_g = zeros(size(x_g));

    for k = 1:length(x_g)
        val = 0;
        for j = 1:n
            val = val + coefs(j) * x_g(k)^(j-1);
        end
        y_g(k) = val;
    end

    figure;
    plot(X, Y, 'ro', 'MarkerSize', 8, 'LineWidth', 2); hold on;
    plot(x_g, y_g, 'm-', 'LineWidth', 1.5);

    title('Interpolação via Vandermonde');
    xlabel('X'); ylabel('Y');
    grid on;
    legend('Pontos', 'Polinômio');
end
