% =========================================================================
% MÉTODO ITERATIVO DE GAUSS-SEIDEL
% =========================================================================
clear; clc;

% --- ENTRADA DE DADOS ---
A = [5, -2;
     -1, 4];
b = [7; 4];

X = [0; 0];       % Aproximação inicial x(0)
tolerancia = 0.005;
max_iter = 50;

n = length(b);

fprintf("=========================================================\n");
fprintf("Iteração | Solução Atual (X) | Distância Relativa (Dr)\n");
fprintf("=========================================================\n");

% Exibe a iteração 0 convertendo o vetor para uma linha de texto limpa
texto_X0 = sprintf("[%.4f; %.4f]", X(1), X(2));
fprintf("   0     | %s | --------\n", texto_X0);

for iter = 1 : max_iter
    X_velho = X; % Guarda o estado do início da iteração

    % Atualiza os valores IMEDIATAMENTE no vetor X
    for i = 1 : n
        soma = 0;
        for j = 1 : n
            if j ~= i
                soma = soma + A(i, j) * X(j);
            end
        end
        X(i) = (b(i) - soma) / A(i, i);
    end

    % Cálculo da Distância entre Vetores (Dr)
    numerador = 0;
    denominador = 0;
    for i = 1 : n
        numerador = numerador + (X(i) - X_velho(i))^2;
        denominador = denominador + (X(i))^2;
    end
    Dr = sqrt(numerador) / sqrt(denominador);

    % Monta o texto de X formatado com 4 casas decimais para a tabela
    texto_X = sprintf("[%.4f; %.4f]", X(1), X(2));

    % Imprime a linha da tabela injetando as variáveis corretamente
    fprintf("   %d     | %s | %.6f\n", iter, texto_X, Dr);

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
