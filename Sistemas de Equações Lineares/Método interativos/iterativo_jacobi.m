% =========================================================================
% MÉTODO ITERATIVO DE GAUSS-JACOBI
% =========================================================================
clear; clc;

% --- ENTRADA DE DADOS ---
A = [10, 2, 1;
     1, 5, 1;
     2, 3, 10];
b = [7; -8; 6];

% Parâmetros de controle
X = [0; 0; 0];       % Aproximação inicial x(0)  - Ficar atento com qual vetor o professor pode solicitar
tolerancia = 0.001;  % Erro tolerável
max_iter = 50;       % Trava de segurança para não travar o computador

n = length(b);
X_novo = zeros(n, 1);

fprintf("=========================================================\n");
fprintf("Iteração | Solução Atual (X) | Distância Relativa (Dr)\n");
fprintf("=========================================================\n");
fprintf("   0     | %s | --------\n", mat2str(X, 4));

for iter = 1 : max_iter
    % Calcula o novo vetor baseado INTEGRALMENTE no vetor antigo X
    for i = 1 : n
        soma = 0;
        for j = 1 : n
            if j ~= i
                soma = soma + A(i, j) * X(j);
            end
        end
        X_novo(i) = (b(i) - soma) / A(i, i);
    end

    % Cálculo da Distância entre Vetores (Dr = Norma do erro relativo)
    numerador = 0;
    denominador = 0;
    for i = 1 : n
        numerador = numerador + (X_novo(i) - X(i))^2;
        denominador = denominador + (X_novo(i))^2;
    end
    Dr = sqrt(numerador) / sqrt(denominador);

    % Atualiza o vetor para a próxima rodada
    X = X_novo;

    % Printa a linha da tabela
    fprintf("   %d     | %s | %f\n", iter, mat2str(X, 4), Dr);

    % Critério de parada
    if Dr < tolerancia
        fprintf("=========================================================\n");
        fprintf("CONVERGIU! Critério atingido na iteração %d.\n", iter);
        break;
    end
end

if iter == max_iter && Dr >= tolerancia
    fprintf("=========================================================\n");
    fprintf("ATENÇÃO: Atingiu o número máximo de iterações sem convergir.\n");
end

disp("\nSolução Final:");
disp(X);
