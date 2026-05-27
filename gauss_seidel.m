function x = gauss_seidel(A, b, x0, tol, max_iter)
    if nargin < 5
        A = [10, 2, 1; 1, 5, 1; 2, 3, 10];
        b = [13; 7; 15];
        x0 = [0; 0; 0];
        tol = 1e-5;
        max_iter = 100;
        fprintf('Executando Gauss-Seidel com dados padrões:\n');
    end

    n = length(b);

    % Critério de Sassenfeld
    beta = zeros(n, 1);
    for i = 1:n
        soma1 = 0;
        for j = 1:i-1
            soma1 = soma1 + abs(A(i,j)) * beta(j);
        end

        soma2 = 0;
        for j = i+1:n
            soma2 = soma2 + abs(A(i,j));
        end

        beta(i) = (soma1 + soma2) / abs(A(i,i));
    end

    max_beta = max(beta);

    fprintf('\n--- MÉTODO DE GAUSS-SEIDEL ---\n');
    if max_beta < 1
        fprintf('Critério de Sassenfeld ATENDIDO (beta_max = %.6f < 1)\n', max_beta);
    else
        fprintf('AVISO: Critério de Sassenfeld NÃO atendido (beta_max = %.6f >= 1)\n', max_beta);
    end
    fprintf('\n');

    x = x0;

    for iter = 1:max_iter
        x_old = x;

        for i = 1:n
            soma = 0;
            for j = 1:n
                if j ~= i
                    soma = soma + A(i,j) * x(j);
                end
            end
            x(i) = (b(i) - soma) / A(i,i);
        end

        % Erro relativo
        max_diff = max(abs(x - x_old));
        max_val = max(abs(x));
        if max_val == 0
            max_val = 1;
        end
        Dr = max_diff / max_val;

        % Impressão organizada
        fprintf('Iter %2d | Dr = %.6e | x = [ ', iter, Dr);
        for idx = 1:n
            fprintf('%.6f ', x(idx));
        end
        fprintf(']\n');

        if Dr < tol
            fprintf('\nConvergência atingida em %d iterações.\n', iter);
            return;
        end
    end
end
