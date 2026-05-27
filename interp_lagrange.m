function interp_lagrange(X, Y, mostrar_L)
    if nargin < 2
        X = [0, 0.5, 1];
        Y = [1.3, 2.5, 0.9];
        fprintf('Executando Interpolação de Lagrange com pontos padrões:\n');
    end

    if nargin < 3
        mostrar_L = 1:length(X); % mostra todos por padrão
    end

    n = length(X);

    fprintf('\n===============================\n');
    fprintf(' INTERPOLAÇÃO DE LAGRANGE\n');
    fprintf('===============================\n\n');

    % ============================
    % PASSO 1 - Mostrar pontos
    % ============================
    fprintf('Pontos fornecidos:\n');
    for i = 1:n
        fprintf('  P%d = (%.4f, %.4f)\n', i, X(i), Y(i));
    end
    fprintf('\n');

    % ============================
    % PASSO 2 - Mostrar Li(x)
    % ============================
    fprintf('Construção dos polinômios base Li(x):\n\n');

    for i = mostrar_L
        fprintf('L_%d(x) = ', i);

        for j = 1:n
            if j ~= i
                fprintf('(x - %.2f)/(%.2f - %.2f)', X(j), X(i), X(j));
                if j < n
                    fprintf(' * ');
                end
            end
        end
        fprintf('\n');
    end

    fprintf('\n');

    % ============================
    % PASSO 3 - DR (erro)
    % ============================
    Dr = 0;
    for k = 1:n
        val = 0;

        for i = 1:n
            L = 1;
            for j = 1:n
                if j ~= i
                    L = L * (X(k) - X(j)) / (X(i) - X(j));
                end
            end
            val = val + Y(i) * L;
        end

        res = abs(Y(k) - val);
        if res > Dr
            Dr = res;
        end
    end

    fprintf('>> DR = %.6e <<\n\n', Dr);

    % ============================
    % PASSO 4 - POLINÔMIO FINAL
    % ============================
    fprintf('Polinômio final:\n');
    fprintf('P(x) = ');

    for i = 1:n
        fprintf('(%.4f)*L_%d(x)', Y(i), i);
        if i < n
            fprintf(' + ');
        end
    end
    fprintf('\n\n');

    % ============================
    % PASSO 5 - GRÁFICO
    % ============================
    x_g = linspace(min(X), max(X), 200);
    y_g = zeros(size(x_g));

    % Polinômio final
    for k = 1:length(x_g)
        val = 0;
        for i = 1:n
            L = 1;
            for j = 1:n
                if j ~= i
                    L = L * (x_g(k) - X(j)) / (X(i) - X(j));
                end
            end
            val = val + Y(i) * L;
        end
        y_g(k) = val;
    end

    figure;
    plot(X, Y, 'ro', 'MarkerSize', 8, 'LineWidth', 2); hold on;
    plot(x_g, y_g, 'k-', 'LineWidth', 2);

    % Plot dos Li
    for idx = mostrar_L
        Li_vals = zeros(size(x_g));

        for k = 1:length(x_g)
            L = 1;
            for j = 1:n
                if j ~= idx
                    L = L * (x_g(k) - X(j)) / (X(idx) - X(j));
                end
            end
            Li_vals(k) = L;
        end

        plot(x_g, Li_vals, '--', 'LineWidth', 1.5);
    end

    title('Interpolação de Lagrange (com Li)');
    xlabel('X'); ylabel('Y');
    grid on;

    legend_labels = {'Pontos', 'P(x)'};

    for idx = mostrar_L
        legend_labels{end+1} = sprintf('L_%d(x)', idx);
    end

    legend(legend_labels);
end
