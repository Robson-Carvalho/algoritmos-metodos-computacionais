function [n1, ninf] = determinar_normas(A)
    % Se não passar a matriz, carrega os dados padrão da Q6 da prova
    if nargin < 1
        A = [ 8,  2, -10;
             -9,  1,   3;
              15, -1,   6];
        fprintf('Executando determinar_normas com dados padrões da Q6:\n');
    end

    [linhas, colunas] = size(A);

    fprintf('==================================================\n');
    fprintf('         CÁLCULO DE NORMAS MATRICIAIS\n');
    fprintf('==================================================\n');

    % --- 1. CÁLCULO DA NORMA 1 (SOMA DAS COLUNAS) ---
    somas_colunas = zeros(1, colunas);
    for j = 1:colunas
        soma_atual = 0;
        for i = 1:linhas
            soma_atual = soma_atual + abs(A(i, j));
        end
        somas_colunas(j) = soma_atual;
        fprintf('  Soma absoluta da Coluna %d = %.4f\n', j, soma_atual);
    end
    n1 = max(somas_colunas);
    fprintf('-> NORMA 1 (||A||1) [Máximo das Colunas] = %.4f\n\n', n1);

    % --- 2. CÁLCULO DA NORMA INFINITO (SOMA DAS LINHAS) ---
    somas_linhas = zeros(linhas, 1);
    for i = 1:linhas
        soma_atual = 0;
        for j = 1:colunas
            soma_atual = soma_atual + abs(A(i, j));
        end
        somas_linhas(i) = soma_atual;
        fprintf('  Soma absoluta da Linha %d  = %.4f\n', i, soma_atual);
    end
    ninf = max(somas_linhas);
    fprintf('-> NORMA INFINITO (||A||inf) [Máximo das Linhas] = %.4f\n', ninf);
    fprintf('==================================================\n');
end
