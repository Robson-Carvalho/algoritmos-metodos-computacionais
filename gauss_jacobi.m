function x = gauss_jacobi(A, b, x0, tol, max_iter)
    if nargin < 5
        A = [10, 2, 1; 1, 5, 1; 2, 3, 10];
        b = [13; 7; 15];
        x0 = [0; 0; 0];
        tol = 1e-5;
        max_iter = 100;
        fprintf('Executando Gauss-Jacobi com dados padrões:\n');
    end

    n = length(b);

    % Verificação da diagonal dominante
    dd = true;
    for i = 1:n
        soma = 0;
        for j = 1:n
            if j ~= i
                soma = soma + abs(A(i,j));
            end
        end
        if abs(A(i,i)) <= soma
            dd = false;
        end
    end

    fprintf('\n==================================================\n');
    fprintf('               MÉTODO DE GAUSS-JACOBI\n');
    fprintf('==================================================\n');
    if dd
        fprintf('Critério de Diagonal Dominante ATENDIDO.\n');
    else
        fprintf('AVISO: Matriz NÃO é diagonal dominante.\n');
    end
    fprintf('--------------------------------------------------\n');

    % Cabeçalho alinhado para a tabela de iterações
    fprintf(' %-5s | %-10s | %s\n', 'Iter', 'Dr (Erro)', 'Vetor Solução x');
    fprintf('--------------------------------------------------\n');

    x = x0;
    x_new = zeros(n, 1);

    for iter = 1:max_iter
        for i = 1:n
            soma = 0;
            for j = 1:n
                if j ~= i
                    soma = soma + A(i,j) * x(j);
                end
            end
            x_new(i) = (b(i) - soma) / A(i,i);
        end

        % Erro relativo (Dr)
        max_diff = max(abs(x_new - x));
        max_val = max(abs(x_new));
        if max_val == 0
            max_val = 1;
        end
        Dr = max_diff / max_val;

        % Impressão no formato limpo de 5 casas decimais solicitado
        fprintf('  %3d  |   %.5f   | [ ', iter, Dr);
        for idx = 1:n
            fprintf('%.5f ', x_new(idx));
        end
        fprintf(']\n');

        % Condição de parada rigorosa
        if Dr < tol
            fprintf('--------------------------------------------------\n');
            fprintf('Convergência atingida em %d iterações.\n', iter);
            fprintf('==================================================\n');
            x = x_new;
            return;
        end

        x = x_new;
    end

    fprintf('--------------------------------------------------\n');
    fprintf('Aviso: Limite máximo de %d iterações atingido sem convergência.\n', max_iter);
    fprintf('==================================================\n');
end
