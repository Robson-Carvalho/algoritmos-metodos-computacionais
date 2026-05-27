function coefs = reg_linear_multipla(X_mult, Y)
    % Se não passar dados, carrega a tabela padrão do enunciado
    if nargin < 2
        % Dados padrões: [x1, x2]
        X_mult = [ 0,   0;
                   2,   1;
                   2.5, 2;
                   1,   3;
                   4,   6;
                   7,   2 ];
        % Y padrão
        Y = [5; 10; 9; 0; 3; 27];
        fprintf('Executando Regressão Múltipla com dados padrões.\n');
    end

    % Armazena dimensões básicas
    N = size(X_mult, 1);       % Número de pontos (amostras)
    num_vars = size(X_mult, 2); % Número de variáveis independentes (ex: 2 para x1 e x2)

    % Garante que Y seja um vetor coluna
    Y = Y(:);

    % O tamanho do sistema será o número de variáveis + 1 (por causa do intercepto b0)
    tamanho_sistema = num_vars + 1;

    % Monta a matriz de design (X_design) adicionando uma coluna de 1s para o b0
    X_design = [ones(N, 1), X_mult];

    % Construção do Sistema Normal (M * coefs = B) utilizando loops nativos
    M = zeros(tamanho_sistema, tamanho_sistema);
    B = zeros(tamanho_sistema, 1);

    fprintf('\n==================================================\n');
    fprintf('   REGRESSÃO LINEAR MÚLTIPLA (SISTEMA NATIVO)\n');
    fprintf('==================================================\n');

    % Preenche a matriz de somatórios M e o vetor B usando multiplicação ponto a ponto
    for i = 1:tamanho_sistema
        for j = 1:tamanho_sistema
            M(i,j) = sum(X_design(:, i) .* X_design(:, j));
        end
        B(i) = sum(X_design(:, i) .* Y);
    end

    disp('-> MATRIZ DE SOMATÓRIOS (M):'); disp(M);
    disp('-> VETOR SOMA DE PRODUTOS (B):'); disp(B);

    % ==========================================================
    % SOLUÇÃO POR GAUSS NATIVO COM PIVOTEAMENTO PARCIAL
    % ==========================================================
    A_ext = [M, B];
    n_sys = tamanho_sistema;

    % Fase de Eliminação
    for k = 1:n_sys-1
        % Busca o maior elemento em valor absoluto na coluna k (Pivoteamento)
        maior_valor = abs(A_ext(k, k));
        linha_pivo = k;
        for i = k+1:n_sys
            if abs(A_ext(i, k)) > maior_valor
                maior_valor = abs(A_ext(i, k));
                linha_pivo = i;
            end
        end

        % Troca de linhas se necessário
        if linha_pivo ~= k
            aux_linha = A_ext(k, :);
            A_ext(k, :) = A_ext(linha_pivo, :);
            A_ext(linha_pivo, :) = aux_linha;
        end

        % Eliminação por pivô
        for i = k+1:n_sys
            m_fac = A_ext(i, k) / A_ext(k, k);
            A_ext(i, k:end) = A_ext(i, k:end) - m_fac * A_ext(k, k:end);
        end
    end

    % Fase de Retrosubstituição
    coefs = zeros(n_sys, 1);
    coefs(n_sys) = A_ext(n_sys, end) / A_ext(n_sys, n_sys);
    for i = n_sys-1:-1:1
        soma = 0;
        for j = i+1:n_sys
            soma = soma + A_ext(i, j) * coefs(j);
        end
        coefs(i) = (A_ext(i, end) - soma) / A_ext(i, i);
    end

    % --- EXIBIÇÃO DOS RESULTADOS NO PROMPT ---
    disp('-> COEFICIENTES DA REGRESSÃO COMPUTADOS:');
    for i = 1:tamanho_sistema
        fprintf('  b%d = %10.4f\n', i-1, coefs(i));
    end

    % ==========================================================
    % CÁLCULO ESTATÍSTICO (R²)
    % ==========================================================
    y_pred = X_design * coefs;
    y_barra = mean(Y);

    SQres = sum((Y - y_pred).^2);
    SQtot = sum((Y - y_barra).^2);
    R2 = 1 - (SQres / SQtot);

    fprintf('\n -> Coeficiente de Determinação (R²): %7.4f\n\n', R2);

    % ==========================================================
    % PLOTAGEM DO GRÁFICO (Apenas se for o modelo bidimensional X1 e X2)
    % ==========================================================
    if num_vars == 2
        figure('Name', 'Regressão Linear Múltipla', 'NumberTitle', 'off');

        % 1. Criando uma malha para desenhar o plano contínuo primeiro
        x1_dados = X_mult(:, 1);
        x2_dados = X_mult(:, 2);

        [X1_mesh, X2_mesh] = meshgrid(linspace(min(x1_dados), max(x1_dados), 20), ...
                                      linspace(min(x2_dados), max(x2_dados), 20));

        % Calcula a superfície do plano baseado nos coeficientes achados
        Y_mesh = coefs(1) + coefs(2).*X1_mesh + coefs(3).*X2_mesh;

        % Desenha o plano suave com transparência
        mesh(X1_mesh, X2_mesh, Y_mesh, 'FaceAlpha', 0.4);
        hold on;
        grid on;

        % 2. Desenha os pontos pretos pequenos por cima do plano
        plot3(x1_dados, x2_dados, Y, 'ko', 'MarkerSize', 5, 'LineWidth', 1.5, 'MarkerFaceColor', 'k');

        % Configurações estéticas
        title(sprintf('Regressão Linear Múltipla (R² = %.4f)', R2), 'FontSize', 12);
        xlabel('Variável Independente (x_1)');
        ylabel('Variável Independente (x_2)');
        zlabel('Variável Dependente (y)');

        % Legenda na ordem correta de desenho
        legend({'Plano de Ajuste', 'Dados Reais'}, 'Location', 'northwest');
        view(3);
        hold off;
    else
        disp('Aviso: Gráfico 3D não gerado pois o modelo possui número de variáveis diferente de 2.');
    end
end
