function x = gauss_ingenua(A, b)
    if nargin < 2
        % Dados de teste padrão caso executado diretamente
        A = [6,  2, -1;
             1,  4,  1;
             2, -1,  5];
        b = [11; 4; 16];
        fprintf('Executando Gauss Ingênua com matriz de teste padrão:\n');
    end

    % --- BLINDAGEM CONTRA ERRO DE DIMENSÃO ---
    % Transforma o vetor b em um vetor coluna (em pé), não importa como foi digitado
    b = b(:);
    % -----------------------------------------

    n = length(b);
    A_ext = [A, b]; % Agora a colagem das dimensões nunca mais vai falhar!

    fprintf('\n--- 1. ELIMINAÇÃO DE GAUSS INGÊNUA ---\n');
    fprintf('Matriz estendida inicial [A|b]:\n');
    disp_formatado(A_ext);

    % Eliminação progressiva
    for k = 1:n-1
        fprintf('\nPasso %d - Eliminando abaixo da diagonal na coluna %d:\n', k, k);
        for i = k+1:n
            m = A_ext(i,k) / A_ext(k,k);
            fprintf('  Linha %d: multiplicador m = %.4f\n', i, m);
            A_ext(i,k:end) = A_ext(i,k:end) - m * A_ext(k,k:end);
        end
        disp_formatado(A_ext);
    end

    % Substituição retroativa
    x = zeros(n, 1);
    x(n) = A_ext(n,end) / A_ext(n,n);
    for i = n-1:-1:1
        soma = 0;
        for j = i+1:n
            soma = soma + A_ext(i,j) * x(j);
        end
        x(i) = (A_ext(i,end) - soma) / A_ext(i,i);
    end

    fprintf('\nVetor solução final x encontrado:\n');
    disp_formatado(x);
end

% --- FUNÇÃO AUXILIAR DE FORMATAÇÃO ---
function disp_formatado(M)
    % Força a exibição de qualquer matriz ou vetor com exatamente 4 casas decimais
    [linhas, colunas] = size(M);
    for i = 1:linhas
        for j = 1:colunas
            fprintf('   %10.4f', M(i,j));
        end
        fprintf('\n');
    end
end
