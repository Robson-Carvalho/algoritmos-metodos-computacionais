% =========================================================================
% ELIMINAÇÃO DE GAUSS COM PIVOTEAMENTO PARCIAL
% =========================================================================
clear; clc;

% --- ENTRADA DE DADOS ---
A = [1, 1, 1;
     2, -1, 4;
     3, 2, -1];
b = [6; 7; 4];

n = length(b);
X = zeros(n, 1);

detA = 1;        % <-- NOVO
trocas = 0;      % <-- NOVO (conta trocas de linha)

disp("=== MATRIZ INICIAL [A|b] ===");
disp([A, b]);

% --- FASE DE ELIMINAÇÃO COM PIVOTEAMENTO ---
for k = 1 : n-1
    fprintf("\n=== PASSO %d ===", k);

    % Procura o maior elemento em valor absoluto na coluna k, da linha k até n
    maior_valor = abs(A(k, k));
    linha_pivo = k;
    for i = k+1 : n
        if abs(A(i, k)) > maior_valor
            maior_valor = abs(A(i, k));
            linha_pivo = i;
        end
    end

    % Se a linha do pivô for diferente da atual, troca as linhas
    if linha_pivo ~= k
        fprintf("\n[PIVOTEAMENTO] Trocando linha %d com a linha %d (Maior elemento: %f)\n", k, linha_pivo, A(linha_pivo, k));

        aux_A = A(k, :);
        A(k, :) = A(linha_pivo, :);
        A(linha_pivo, :) = aux_A;

        aux_b = b(k);
        b(k) = b(linha_pivo);
        b(linha_pivo) = aux_b;

        trocas = trocas + 1; % <-- NOVO

        disp("Matriz após troca de linhas:");
        disp([A, b]);
    else
        fprintf("\n[PIVOTEAMENTO] O elemento A(%d,%d) = %f já é o maior da coluna. Nenhuma troca necessária.\n", k, k, A(k,k));
    end

    fprintf("Pivô A(%d,%d) = %f\n", k, k, A(k,k));
    detA = detA * A(k,k); % <-- NOVO

    % Eliminação normal após o pivoteamento
    for i = k+1 : n
        m = A(i, k) / A(k, k);
        A(i, k:n) = A(i, k:n) - m * A(k, k:n);
        b(i) = b(i) - m * b(k);
    end
    disp("Matriz após eliminação neste passo:");
    disp([A, b]);
end

% último pivô
detA = detA * A(n,n); % <-- NOVO

% ajuste do sinal pelas trocas de linha
detA = detA * (-1)^trocas; % <-- NOVO

% --- FASE DE RETROSUBSTITUIÇÃO ---
disp("=== FASE DE RETROSUBSTITUIÇÃO ===");
X(n) = b(n) / A(n, n);
fprintf("X(%d) = %f\n", n, X(n));

for i = n-1 : -1 : 1
    soma = 0;
    for j = i+1 : n
        soma = soma + A(i, j) * X(j);
    end
    X(i) = (b(i) - soma) / A(i, i);
    fprintf("X(%d) = %f\n", i, X(i));
end

disp("\n=== SOLUÇÃO FINAL ===");
disp(X);

% --- DETERMINANTE ---
disp("=== DETERMINANTE DA MATRIZ A ===");
fprintf("det(A) = %f\n", detA);
