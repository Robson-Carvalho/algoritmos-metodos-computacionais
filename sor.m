function x = sor(A, b, x0, tol, max_iter, omega)
    if nargin < 6
        A = [4, 1, 1; 1, 5, 2; 1, 2, 5];
        b = [6; 8; 8];
        x0 = [0; 0; 0];
        tol = 1e-5;
        max_iter = 100;
        omega = 1.15;
        fprintf('Executando Método SOR com dados padrões:\n');
    end

    n = length(b);

    fprintf('\n--- MÉTODO SOR (SUPER-RELAXAÇÃO SUCESSIVA) ---\n');
    fprintf('Fator de relaxação (omega) = %.4f\n\n', omega);

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

            x_gs = (b(i) - soma) / A(i,i); % Gauss-Seidel
            x(i) = (1 - omega) * x(i) + omega * x_gs;
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

    fprintf('\nNúmero máximo de iterações atingido.\n');
end
