function [A_inv, x_final] = inversa_gauss_jordan(A, b)
    % nargin == 1 significa que você passou A, mas esqueceu o b
    % nargin < 1 significa que você chamou a função vazia
    if nargin < 2
        A = [10, 2, -1;
             -3, -6, 2;
              1,  1, 5];
        b = [27; -61.5; -21.5];
        fprintf('Executando cálculo de Inversa e Solução com matriz padrão da Q5 (3x3):\n');
    else
        % Se você passou os dados novos (4x4 ou 5x5), ele avisa o tamanho real!
        fprintf('Executando cálculo para matriz customizada de tamanho (%dx%d):\n', size(A,1), size(A,2));
    end

    n = size(A, 1);
    I = zeros(n);
    for i = 1:n
        I(i,i) = 1;
    end
    A_ext = [A, I];

    fprintf('--- 4. MATRIZ INVERSA POR GAUSS-JORDAN ---\n');

    % ---- NOVIDADE: Print dinâmico da matriz estendida [A | I] ----
    fprintf('Matriz estendida inicial [A | I]:\n');
    for i = 1:n
        % Printa a parte da matriz A
        for j = 1:n
            fprintf('  %8.4f', A_ext(i, j));
        end
        fprintf('  |');
        % Printa a parte da matriz Identidade I
        for j = (n+1):(2*n)
            fprintf('  %8.4f', A_ext(i, j));
        end
        fprintf('\n');
    end

    % Algoritmo de Gauss-Jordan para inverter a matriz
    for k = 1:n
        pivo = A_ext(k,k);
        A_ext(k,:) = A_ext(k,:) / pivo;
        for i = 1:n
            if i ~= k
                m = A_ext(i,k);
                A_ext(i,:) = A_ext(i,:) - m * A_ext(k,:);
            end
        end
    end

    % Separa a metade direita que virou a inversa
    A_inv = A_ext(:, n+1:end);

    % ---- NOVIDADE: Print dinâmico da Matriz Inversa ----
    fprintf('Matriz Inversa calculada A^-1:\n');
    for i = 1:n
        for j = 1:n
            fprintf('  %8.4f', A_inv(i, j));
        end
        fprintf('\n');
    end

    % Verificação passo a passo (Multiplicação A * A^-1)
    fprintf('Verificação passo a passo (Multiplicação A * A^-1):\n');
    Verif = zeros(n);
    for i = 1:n
        for j = 1:n
            s = 0;
            for r = 1:n
                s = s + A(i,r) * A_inv(r,j);
            end
            Verif(i,j) = s;
        end
    end

    % ---- NOVIDADE: Print dinâmico da Verificação ----
    for i = 1:n
        for j = 1:n
            fprintf('  %8.4f', Verif(i, j));
        end
        fprintf('\n');
    end

    % Calculando a solução do sistema usando a Inversa (x = A^-1 * b)
    x_final = zeros(n, 1);
    for i = 1:n
        soma = 0;
        for j = 1:n
            soma = soma + A_inv(i,j) * b(j);
        end
        x_final(i) = soma;
    end

    % Print formatado do vetor x_final
    fprintf('Solução final do sistema x (A^-1 * b):\n');
    for i = 1:n
        fprintf('  %8.4f\n', x_final(i));
    end
end
