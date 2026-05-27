function x = gauss_pivotamento(A, b)
    if nargin < 2
        A = [1, -1, 2; 2, 1, -1; -1, 1, 1];
        b = [2; 1; 1];
        fprintf('Executando Gauss com Pivotamento Parcial com dados padrões:');
    end

    n = length(b);
    A_ext = [A, b];
    fprintf('--- 2. ELIMINAÇÃO DE GAUSS COM PIVOTAMENTO PARCIAL ---');
    fprintf('Matriz estendida inicial [A|b]:'); disp(A_ext);

    for k = 1:n-1
        fprintf('Passo %d - Analisando coluna %d para pivotamento:', k, k);
        % Localizar maior pivô na coluna k da linha k em diante
        [val, idx] = max(abs(A_ext(k:n, k)));
        p = idx + k - 1;

        if p ~= k
            fprintf('  Trocando linha %d com linha %d (Maior valor absoluto encontrado = %f)', k, p, val);
            temp = A_ext(k,:);
            A_ext(k,:) = A_ext(p,:);
            A_ext(p,:) = temp;
            disp(A_ext);
        else
            fprintf('  Troca desnecessária. O pivô atual já é o maior em módulo.');
        end

        % Eliminação comum
        for i = k+1:n
            m = A_ext(i,k) / A_ext(k,k);
            fprintf('  Linha %d: m = %f', i, m);
            A_ext(i,k:end) = A_ext(i,k:end) - m * A_ext(k,k:end);
        end
        disp(A_ext);
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

    fprintf('Vetor solução final x encontrado:'); disp(x);
end

