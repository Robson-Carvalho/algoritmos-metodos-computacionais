function x = gauss_ingenua(A, b)
    if nargin < 2
        % Dados de teste padrão caso executado diretamente
        A = [6, 2, -1; 1, 4, 1; 2, -1, 5];
        b = [11; 4; 16];
        fprintf('Executando Gauss Ingênua com matriz de teste padrão:');
    end

    n = length(b);
    A_ext = [A, b];
    fprintf('--- 1. ELIMINAÇÃO DE GAUSS INGÊNUA ---');
    fprintf('Matriz estendida inicial [A|b]:'); disp(A_ext);

    % Eliminação progressiva
    for k = 1:n-1
        fprintf('Passo %d - Eliminando abaixo da diagonal na coluna %d:', k, k);
        for i = k+1:n
            m = A_ext(i,k) / A_ext(k,k);
            fprintf('  Linha %d: multiplicador m = %f', i, m);
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

    fprintf('Vetor solução final x encontrado:');
    disp(x);
end

