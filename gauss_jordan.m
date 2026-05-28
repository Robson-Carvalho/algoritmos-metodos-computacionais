function x = gauss_jordan(A, b)
    % Se você esquecer de passar os dados na main, ele usa essa 3x3 de segurança
    if nargin < 2
        A = [130, -30,    0;
              90, -90,    0;
              40,  60, -120];
        b = [200; 0; -500];
        fprintf('⚠️ Nenhuma entrada fornecida! Carregando dados padrões de teste.\n');
    end

    % O segredo do dinamismo está aqui: 'n' assume o tamanho real do seu sistema
    n = length(b);
    A_ext = [A, b];

    fprintf('\n=============================================================\n');
    fprintf('   MÉTODO: ELIMINAÇÃO DE GAUSS-JORDAN DINÂMICO (%d x %d)\n', n, n);
    fprintf('=============================================================\n');
    fprintf('Matriz estendida inicial:\n');
    disp_formatado(A_ext);

    % O loop vai automaticamente até o tamanho 'n' da sua matriz
    for k = 1:n
        fprintf('\n[PASSO %d] -> Normalizando linha %d pelo pivô e zerando a coluna %d:\n', k, k, k);
        pivo = A_ext(k,k);

        if abs(pivo) < 1e-9
            error('Erro: Pivô nulo detectado na posição (%d,%d). O método falhou.', k, k);
        end

        A_ext(k,:) = A_ext(k,:) / pivo; % Divisão da linha pelo pivô

        for i = 1:n
            if i ~= k
                m = A_ext(i,k);
                A_ext(i,:) = A_ext(i,:) - m * A_ext(k,:);
            end
        end
        disp_formatado(A_ext);
    end

    x = A_ext(:, end);
    fprintf('\n=============================================================\n');
    fprintf('Vetor solução final x encontrado:\n');
    disp_formatado(x);
    fprintf('=============================================================\n');
end

% --- FUNÇÃO AUXILIAR DE FORMATAÇÃO ---
function disp_formatado(M)
    [linhas, colunas] = size(M);
    for i = 1:linhas
        for j = 1:colunas
            fprintf('   %10.4f', M(i,j));
        end
        fprintf('\n');
    end
end
