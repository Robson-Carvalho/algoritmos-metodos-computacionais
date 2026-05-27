% =========================================================================
% ELIMINAÇÃO DE GAUSS COM PIVOTEAMENTO TOTAL
% =========================================================================
clear; clc;

% --- ENTRADA DE DADOS ---
A = [1, 1, 1;
     2, -1, 4;
     3, 2, -1];
b = [6; 7; 4];

n = length(b);
X = zeros(n, 1);

detA = 1;          % <-- NOVO
troca_linhas = 0;  % <-- NOVO
troca_colunas = 0; % <-- NOVO

% Vetor para rastrear a ordem original das variáveis (X1, X2, X3...)
ordem_var = 1:n;

disp("=== MATRIZ INICIAL [A|b] ===");
disp([A, b]);

% --- FASE DE ELIMINAÇÃO COM PIVOTEAMENTO TOTAL ---
for k = 1 : n-1
    fprintf("\n=== PASSO %d ===", k);

    maior_valor = abs(A(k, k));
    linha_pivo = k;
    coluna_pivo = k;

    % Busca o maior elemento absoluto em toda a submatriz restante
    for i = k : n
        for j = k : n
            if abs(A(i, j)) > maior_valor
                maior_valor = abs(A(i, j));
                linha_pivo = i;
                coluna_pivo = j;
            end
        end
    end

    % Troca de Linhas
    if linha_pivo ~= k
        fprintf("\n[TROCA LINHAS] Trocando linha %d com %d\n", k, linha_pivo);
        A([k, linha_pivo], :) = A([linha_pivo, k], :);
        b([k, linha_pivo]) = b([linha_pivo, k]);
        troca_linhas = troca_linhas + 1; % <-- NOVO
    end

    % Troca de Colunas
    if coluna_pivo ~= k
        fprintf("[TROCA COLUNAS] Trocando coluna %d com %d\n", k, coluna_pivo);
        A(:, [k, coluna_pivo]) = A(:, [coluna_pivo, k]);

        ordem_var([k, coluna_pivo]) = ordem_var([coluna_pivo, k]);
        troca_colunas = troca_colunas + 1; % <-- NOVO
    end

    disp("Matriz após pivoteamento total:");
    disp([A, b]);
    fprintf("Ordem atual das variáveis no vetor: X_%s\n", mat2str(ordem_var));

    fprintf("Pivô A(%d,%d) = %f\n", k, k, A(k,k));
    detA = detA * A(k,k); % <-- NOVO

    % Eliminação
    for i = k+1 : n
        m = A(i, k) / A(k, k);
        A(i, k:n) = A(i, k:n) - m * A(k, k:n);
        b(i) = b(i) - m * b(k);
    end
    disp("Matriz após eliminação:");
    disp([A, b]);
end

% último pivô
detA = detA * A(n,n); % <-- NOVO

% ajuste do sinal
detA = detA * (-1)^(troca_linhas + troca_colunas); % <-- NOVO

% --- RETROSUBSTITUIÇÃO ---
disp("\n=== RETROSUBSTITUIÇÃO ===");
X_aux = zeros(n, 1);
X_aux(n) = b(n) / A(n, n);

for i = n-1 : -1 : 1
    soma = 0;
    for j = i+1 : n
        soma = soma + A(i, j) * X_aux(j);
    end
    X_aux(i) = (b(i) - soma) / A(i, i);
end

% --- REORDENAÇÃO DAS VARIÁVEIS ---
for i = 1 : n
    posicao_original = ordem_var(i);
    X(posicao_original) = X_aux(i);
end

disp("=== SOLUÇÃO FINAL ORDENADA (X1, X2, X3...) ===");
disp(X);

% --- DETERMINANTE ---
disp("=== DETERMINANTE DA MATRIZ A ===");
fprintf("det(A) = %f\n", detA);
