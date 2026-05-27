% =========================================================================
% ELIMINAÇÃO DE GAUSS-JORDAN
% =========================================================================
clear; clc;

% --- ENTRADA DE DADOS ---
A = [2, 1, -1;
     -3, -1, 2;
     -2, 1, 2];
b = [8; -11; -3];

n = length(b);

detA = 1; % <-- NOVO

disp("=== MATRIZ INICIAL [A|b] ===");
disp([A, b]);

% --- PROCESSO DE GAUSS-JORDAN ---
for k = 1 : n
    fprintf("\n--- Normalizando e eliminando com pivô na linha %d ---\n", k);

    % Guarda o pivô original (antes da divisão)
    pivo = A(k, k);
    detA = detA * pivo; % <-- NOVO

    % Divide a linha do pivô
    A(k, :) = A(k, :) / pivo;
    b(k) = b(k) / pivo;

    fprintf("Pivô transformado em 1 na linha %d:\n", k);
    disp([A, b]);

    % Zera todos os outros elementos da coluna k
    for i = 1 : n
        if i ~= k
            m = A(i, k);
            A(i, :) = A(i, :) - m * A(k, :);
            b(i) = b(i) - m * b(k);
        end
    end
    disp("Coluna zerada exceto o pivô:");
    disp([A, b]);
end

disp("=== MATRIX IDENTIDADE FINAL E VETOR DE SOLUÇÕES ===");
disp([A, b]);

disp("=== SOLUÇÃO FINAL ===");
disp(b);

% --- DETERMINANTE ---
disp("=== DETERMINANTE DA MATRIZ A ===");
fprintf("det(A) = %f\n", detA);
