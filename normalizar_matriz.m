function A_norm = normalizar_matriz(A)
    % Se não passar a matriz, carrega os dados padrão da Q6 da prova
    if nargin < 1
        A = [ 8,  2, -10;
             -9,  1,   3;
              15, -1,   6];
        fprintf('Executando normalizar_matriz com dados padrões da Q6:\n');
    end

    A_norm = A; % Cria uma cópia para preservar a matriz original
    [linhas, ~] = size(A_norm);

    fprintf('\n--- NORMALIZANDO MATRIZ POR LINHAS (Maior elemento absoluto = 1) ---\n');
    for i = 1:linhas
        max_linha = max(abs(A_norm(i, :)));
        if max_linha == 0
            error('Erro: A linha %d da matriz contém apenas zeros. Não é possível normalizar.', i);
        end
        A_norm(i, :) = A_norm(i, :) / max_linha;
    end

    disp('Matriz resultante da normalização:');
    disp(A_norm);
end
