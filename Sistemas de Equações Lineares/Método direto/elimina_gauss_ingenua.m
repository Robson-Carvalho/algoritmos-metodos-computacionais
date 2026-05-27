% =========================================================================
% ELIMINAÇÃO DE GAUSS INGÊNUA
% =========================================================================
clear; clc;

% --- ENTRADA DE DADOS (Altere aqui para qualquer tamanho) ---
A = [3, 2, 4;
     1, 1, 2;
     4, 3, 2];
b = [1; 2; 3];

n = length(b);
X = zeros(n, 1);

detA = 1; % <-- NOVO (para determinante)

disp("=== MATRIZ INICIAL [A|b] ===");
disp([A, b]);

% --- FASE DE ELIMINAÇÃO ---
for k = 1 : n-1
    fprintf("\n--- Pivotamento na coluna %d ---\n", k);

    fprintf("Pivô A(%d,%d) = %f\n", k, k, A(k,k));
    detA = detA * A(k,k); % <-- NOVO

    for i = k+1 : n
        % Calcula o fator multiplicador
        m = A(i, k) / A(k, k);
        fprintf("Multiplicador m(%d,%d) = %f / %f = %f\n", i, k, A(i, k), A(k, k), m);

        % Aplica a operação na linha da matriz A e no vetor b
        A(i, k:n) = A(i, k:n) - m * A(k, k:n);
        b(i) = b(i) - m * b(k);

        disp("Matriz atualizada:");
        disp([A, b]);
    end
end

% último pivô também entra no determinante
detA = detA * A(n,n); % <-- NOVO

disp("\n=== MATRIZ TRIANGULARIZADA FINAL ===");
disp([A, b]);

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
