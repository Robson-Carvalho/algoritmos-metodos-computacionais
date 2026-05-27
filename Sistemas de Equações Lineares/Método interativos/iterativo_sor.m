% =========================================================================
% MÉTODO ITERATIVO SOR (SUCCESSIVE OVER-RELAXATION)
% =========================================================================
clear; clc;

% --- ENTRADA DE DADOS ---
A = [10, 2, 1;
     1, 5, 1;
     2, 3, 10];
b = [7; -8; 6];

X = [0; 0; 0];       % Aproximação inicial x(0)
w = 1.05;            % Fator de relaxação Ômega (Normalmente entre 1 e 2) - Usar 1 se não for entregue
tolerancia = 0.001;
max_iter = 50;

n = length(b);

fprintf("=========================================================\n");
fprintf("Usando Fator de Relaxação Ômega (w) = %f\n", w);
fprintf("Iteração | Solução Atual (X) | Distância Relativa (Dr)\n");
fprintf("=========================================================\n");
fprintf("   0     | %s | --------\n", mat2str(X, 4));

for iter = 1 : max_iter
    X_velho = X;

    for i = 1 : n
        soma = 0;
        for j = 1 : n
            if j ~= i
                soma = soma + A(i, j) * X(j);
            end
        end
        % Calcula o valor que seria obtido pelo método Gauss-Seidel padrão
        x_seidel = (b(i) - soma) / A(i, i);

        % Aplica a fórmula do SOR (Mistura ponderada com o valor anterior)
        X(i) = (1 - w) * X_velho(i) + w * x_seidel;
    end

    % Cálculo da Distância entre Vetores (Dr)
    numerador = 0;
    denominador = 0;
    for i = 1 : n
        numerador = numerador + (X(i) - X_velho(i))^2;
        denominador = denominador + (X(i))^2;
    end
    Dr = sqrt(numerador) / sqrt(denominador);

    fprintf("   %d     | %s | %f\n", iter, mat2str(X, 4), Dr);

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
