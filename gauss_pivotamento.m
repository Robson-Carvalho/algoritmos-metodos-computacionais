function x = gauss_pivotamento(A, b)
    if nargin < 2
        A = [2, -6, -1; -3, -1, 7; -8, 1, -2];
        b = [-38; -34; -20];
        fprintf('Executando Gauss com Pivotamento Parcial com dados padrões:\n');
    end

    n = length(b);
    A_ext = [A, b];
    fprintf('\n--- 2. ELIMINAÇÃO DE GAUSS COM PIVOTAMENTO PARCIAL ---\n');
    fprintf('Matriz estendida inicial [A|b]:\n');
    disp_formatado(A_ext);

    for k = 1:n-1
        fprintf('\nPasso %d - Analisando coluna %d para pivotamento:\n', k, k);

        % Localizar maior pivô na coluna k da linha k em diante
        [val, idx] = max(abs(A_ext(k:n, k)));
        p = idx + k - 1;

        if p ~= k
            fprintf('  Trocando linha %d com linha %d (Maior valor absoluto encontrado = %.4f)\n', k, p, val);
            temp = A_ext(k,:);
            A_ext(k,:) = A_ext(p,:);
            A_ext(p,:) = temp;
            disp_formatado(A_ext);
        else
            fprintf('  Troca desnecessária. O pivô atual já é o maior em módulo.\n');
        end

        % Eliminação comum
        fprintf('  Eliminação de elementos:\n');
        for i = k+1:n
            m = A_ext(i,k) / A_ext(k,k);
            fprintf('    Linha %d: m = %.4f\n', i, m);
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
