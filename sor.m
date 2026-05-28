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

    % ================= CONFERÊNCIA INICIAL DE SASSENFELD =================
    beta = zeros(n, 1);
    for i = 1:n
        soma1 = 0; for j = 1:i-1, soma1 = soma1 + abs(A(i,j)) * beta(j); end
        soma2 = 0; for j = i+1:n, soma2 = soma2 + abs(A(i,j)); end
        beta(i) = (soma1 + soma2) / abs(A(i,i));
    end
    max_beta = max(beta);

    % ================= REARRANJO AUTOMÁTICO (SE NECESSÁRIO) =================
    if max_beta >= 1
        fprintf('\n[AVISO] Sassenfeld inicial falhou (beta_max = %.5f). Ativando rearranjo automático...\n', max_beta);
        fprintf('--------------------------------------------------\n');

        A_nova = zeros(n, n);
        b_novo = zeros(n, 1);
        linhas_usadas = false(n, 1);
        ordem_linhas = zeros(n, 1); % Vetor para monitorar a nova ordem

        % Para cada coluna i, encontra a linha disponível com o maior elemento absoluto
        for i = 1:n
            maior_val = -1;
            linha_escolhida = -1;

            for k = 1:n
                if ~linhas_usadas(k)
                    if abs(A(k, i)) > maior_val
                        maior_val = abs(A(k, i));
                        linha_escolhida = k;
                    end
                end
            end

            if linha_escolhida ~= -1
                A_nova(i, :) = A(linha_escolhida, :);
                b_novo(i) = b(linha_escolhida);
                linhas_usadas(linha_escolhida) = true;
                ordem_linhas(i) = linha_escolhida;

                % Print detalhado mostrando qual linha foi para onde
                fprintf(' -> Linha %d original movida para a Linha %d (Pivô central: %.2f)\n', linha_escolhida, i, A(linha_escolhida, i));
            end
        end

        % Atualiza A e b com a nova estrutura pivotada
        A = A_nova;
        b = b_novo;

        % Re-calcula Sassenfeld para validar a nova estrutura
        beta = zeros(n, 1);
        for i = 1:n
            soma1 = 0; for j = 1:i-1, soma1 = soma1 + abs(A(i,j)) * beta(j); end
            soma2 = 0; for j = i+1:n, soma2 = soma2 + abs(A(i,j)); end
            beta(i) = (soma1 + soma2) / abs(A(i,i));
        end
        max_beta = max(beta);
    end

    % ================= OUTPUT DE CONFIGURAÇÃO =================
    fprintf('\n==================================================\n');
    fprintf('        MÉTODO SOR (SUPER-RELAXAÇÃO SUCESSIVA)\n');
    fprintf('==================================================\n');
    fprintf(' Fator de relaxação (omega) = %.5f\n', omega);

    if max_beta < 1
        fprintf(' Critério de Sassenfeld: ATENDIDO (beta_max = %.5f < 1)\n', max_beta);
    else
        fprintf(' AVISO SASSENFELD: Mesmo após rearranjo, convergência não é garantida (beta_max = %.5f)\n', max_beta);
    end
    fprintf('--------------------------------------------------\n');
    fprintf(' %-5s | %-10s | %s\n', 'Iter', 'Dr (Erro)', 'Vetor Solução x');
    fprintf('--------------------------------------------------\n');

    x = x0;

    % ================= LOOP PRINCIPAL ITERATIVO =================
    for iter = 1:max_iter
        x_old = x;

        for i = 1:n
            soma = 0;
            for j = 1:n
                if j ~= i
                    soma = soma + A(i,j) * x(j);
                end
            end

            x_gs = (b(i) - soma) / A(i,i);
            x(i) = (1 - omega) * x_old(i) + omega * x_gs;
        end

        % Erro relativo (Dr)
        max_diff = max(abs(x - x_old));
        max_val = max(abs(x));
        if max_val == 0
            max_val = 1;
        end
        Dr = max_diff / max_val;

        % Impressão na tabela limpa
        fprintf('  %3d  |   %.5f   | [ ', iter, Dr);
        for idx = 1:n
            fprintf('%.5f ', x(idx));
        end
        fprintf(']\n');

        % Condição de parada
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
