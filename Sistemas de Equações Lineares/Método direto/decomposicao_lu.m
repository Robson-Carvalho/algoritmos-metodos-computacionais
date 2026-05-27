% =========================================================================
% DECOMPOSIÇÃO LU (SEM PIVOTEAMENTO)
% =========================================================================
clear; clc;

% --- ENTRADA DE DADOS ---
A = [2, 3, 1;
     4, 1, 4;
     3, 4, 6];
b = [13; 15; 23];

n = length(b);

% Inicializa L como identidade e U como zeros
L = eye(n);
U = zeros(n);

disp("=== MATRIZ ORIGINAL A ===");
disp(A);

% --- FATORAÇÃO LU ---
for i = 1 : n
    % Preenche a linha i de U
    for k = i : n
        soma = 0;
        for j = 1 : i-1
            soma = soma + L(i, j) * U(j, k);
        end
        U(i, k) = A(i, k) - soma;
    end

    % Preenche a coluna i de L
    for k = i+1 : n
        soma = 0;
        for j = 1 : i-1
            soma = soma + L(k, j) * U(j, i);
        end
        L(k, i) = (A(k, i) - soma) / U(i, i);
    end

    fprintf("\n--- PASSO %d DA FATORAÇÃO ---\n", i);
    disp("Matriz L parcial:"); disp(L);
    disp("Matriz U parcial:"); disp(U);
end

disp("=== FATORAÇÃO CONCLUÍDA ===");
disp("L final:"); disp(L);
disp("U final:"); disp(U);

% --- PASSO 1: Resolver L*y = b (Substituição Direta) ---
disp("=== RESOLVENDO L*y = b ===");
y = zeros(n, 1);
y(1) = b(1) / L(1, 1);

for i = 2 : n
    soma = 0;
    for j = 1 : i-1
        soma = soma + L(i, j) * y(j);
    end
    y(i) = (b(i) - soma) / L(i, i);
end
disp("Vetor intermediário y:");
disp(y);

% --- PASSO 2: Resolver U*x = y (Substituição Retroativa) ---
disp("=== RESOLVENDO U*x = y ===");
X = zeros(n, 1);
X(n) = y(n) / U(n, n);

for i = n-1 : -1 : 1
    soma = 0;
    for j = i+1 : n
        soma = soma + U(i, j) * X(j);
    end
    X(i) = (y(i) - soma) / U(i, i);
end

disp("=== SOLUÇÃO FINAL X ===");
disp(X);

% --- DETERMINANTE ---
detA = 1;
for i = 1 : n
    detA = detA * U(i,i);
end

disp("=== DETERMINANTE DA MATRIZ A ===");
fprintf("det(A) = %f\n", detA);
