function x = gauss_jordan(A, b)
    if nargin < 2
        A = [2, 1, -1; -3, -1, 2; -2, 1, 2];
        b = [8; -11; -3];
        fprintf('Executando Gauss-Jordan com dados de teste padrão:');
    end

    n = length(b);
    A_ext = [A, b];
    fprintf('--- 3. ELIMINAÇÃO DE GAUSS-JORDAN ---');
    fprintf('Matriz estendida inicial:'); disp(A_ext);

    for k = 1:n
        fprintf('Passo %d - Normalizando a linha %d pelo pivô e zerando a coluna %d:', k, k, k);
        pivo = A_ext(k,k);
        A_ext(k,:) = A_ext(k,:) / pivo; % Transforma o pivô em 1

        for i = 1:n
            if i ~= k
                m = A_ext(i,k);
                A_ext(i,:) = A_ext(i,:) - m * A_ext(k,:);
            end
        end
        disp(A_ext);
    end

    x = A_ext(:, end);
    fprintf('Vetor solução final x encontrado:'); disp(x);
end

