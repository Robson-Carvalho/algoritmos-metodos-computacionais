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

    fprintf('\n==================================================\n');
    fprintf('               MÉTODO DE GAUSS-SEIDEL\n');
    fprintf('==================================================\n');
    if max_beta < 1
        fprintf('Critério de Sassenfeld ATENDIDO (beta_max = %.5f < 1)\n', max_beta);
    else
        fprintf('AVISO: Critério de Sassenfeld NÃO atendido (beta_max = %.5f >= 1)\n', max_beta);
    end
    fprintf('--------------------------------------------------\n');

    % Cabeçalho alinhado para a tabela de iterações
    fprintf(' %-5s | %-10s | %s\n', 'Iter', 'Dr (Erro)', 'Vetor Solução x');
    fprintf('--------------------------------------------------\n');

    x = x0;

    for iter = 1:max_iter
        x_old = x; % Salva o x do início da iteração para comparar o erro real

        % Atualização do vetor x linha por linha
        for i = 1:n
            soma = 0;
            for j = 1:n
                if j ~= i
                    soma = soma + A(i,j) * x(j);
                end
            end
            x(i) = (b(i) - soma) / A(i,i);
        end

        % CÁLCULO DO ERRO RELATIVO CORRETO (Comparando o novo x com o x_old do início do passo)
        max_diff = max(abs(x - x_old));
        max_val = max(abs(x));
        if max_val == 0
            max_val = 1;
        end
        Dr = max_diff / max_val;

        % Impressão no formato limpo de 5 casas decimais solicitado
        fprintf('  %3d  |   %.5f   | [ ', iter, Dr);
        for idx = 1:n
            fprintf('%.5f ', x(idx));
        end
        fprintf(']\n');

        % Condição de parada rigorosa
        if Dr < tol
            fprintf('--------------------------------------------------\n');
            fprintf('Convergência atingida em %d iterações.\n', iter);
            fprintf('==================================================\n');
            return;
        end
    end

    fprintf('--------------------------------------------------\n');
    fprintf('Aviso: Limite máximo de %d iterações atingido sem convergência.\n', max_iter);
    fprintf('==================================================\n');
end
