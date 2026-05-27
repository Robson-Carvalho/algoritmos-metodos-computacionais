function coefs_celula = reg_polinomial(X, Y, graus_mostrar)
    if nargin < 3
        X = [1, 2, 3, 4, 5];
        Y = [2.2, 5.1, 11.2, 19.8, 30.1];
        graus_mostrar = [1];
        fprintf('Executando Regressão Polinomial com dados padrões.\n');
    end

    n = length(X);
    X = X(:); Y = Y(:);

    % Criamos a figura
    figure;

    % LISTA DE CORES: Linhas com espessura 2 para dar bom destaque
    cores = {'b-', 'm-', 'g-', 'c-', 'k-'};

    % ALTERAÇÃO: Inicializa o vetor de legendas vazio para preencher na ordem certa
    legendas = {};

    coefs_celula = cell(length(graus_mostrar), 1);

    for idx = 1:length(graus_mostrar)
        grau = graus_mostrar(idx);
        m = grau + 1;
        M = zeros(m, m);
        B = zeros(m, 1);

        fprintf('\n--- CALCULANDO REGRESSÃO POLINOMIAL DE GRAU %d ---\n', grau);

        somas_x = zeros(2*grau + 1, 1);
        for k = 0:2*grau
            s = 0;
            for i = 1:n, s = s + X(i)^k; end
            somas_x(k+1) = s;
        end

        for i = 1:m
            for j = 1:m
                M(i,j) = somas_x((i-1) + (j-1) + 1);
            end
            s = 0;
            for k = 1:n, s = s + Y(k) * X(k)^(i-1); end
            B(i) = s;
        end

        A_ext = [M, B];
        n_sys = length(B);
        for k = 1:n_sys-1
            for i = k+1:n_sys
                m_fac = A_ext(i,k) / A_ext(k,k);
                A_ext(i,k:end) = A_ext(i,k:end) - m_fac * A_ext(k,k:end);
            end
        end
        coefs = zeros(n_sys, 1);
        coefs(n_sys) = A_ext(n_sys,end) / A_ext(n_sys,n_sys);
        for i = n_sys-1:-1:1
            soma = 0;
            for j = i+1:n_sys
                soma = soma + A_ext(i,j) * coefs(j);
            end
            coefs(i) = (A_ext(i,end) - soma) / A_ext(i,i);
        end

        coefs_celula{idx} = coefs;
        fprintf('Coeficientes obtidos [a0, a1, a2...]: ');
        fprintf('%.4f  ', coefs); fprintf('\n');

        x_g = linspace(min(X), max(X), 200);
        y_g = zeros(size(x_g));
        for k = 1:length(x_g)
            val = 0;
            for j = 1:m
                val = val + coefs(j) * x_g(k)^(j-1);
            end
            y_g(k) = val;
        end

        cor_atual = cores{mod(idx-1, length(cores)) + 1};

        % 1. Plota a curva do polinômio atual
        plot(x_g, y_g, cor_atual, 'LineWidth', 2); hold on;

        % 2. Adiciona o nome do ajuste respectivo na mesma ordem do plot
        legendas{end+1} = sprintf('Ajuste Grau %d', grau);
    end

    % 3. Plota os pontos por último (Bolinhas pretas)
    plot(X, Y, 'ko', 'MarkerSize', 4, 'LineWidth', 1, 'MarkerFaceColor', 'k');

    % 4. Adiciona o nome dos dados reais no final da lista para casar com o plot acima
    legendas{end+1} = 'Dados Reais';

    % ==========================================================
    % BLOCO DE CONTROLE INTELIGENTE DE ZOOM E AJUSTE VISUAL
    % ==========================================================
    margem_x = (max(X) - min(X)) * 0.10;
    if margem_x == 0, margem_x = 1; end
    xlim([min(X) - margem_x, max(X) + margem_x]);

    margem_y = (max(Y) - min(Y)) * 0.20;
    if margem_y == 0, margem_y = 1; end
    ylim([min(Y) - margem_y, max(Y) + margem_y]);
    % ==========================================================

    title('Comparativo de Regressões Polinomiais', 'FontSize', 12);
    xlabel('X'); ylabel('Y'); grid on;

    legend(legendas, 'Location', 'northeast');
    hold off;
end
