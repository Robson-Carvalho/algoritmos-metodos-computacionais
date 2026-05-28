function cond = numero_condicao(A, usar_vandermonde)

    % ================= CONTROLE DE ENTRADA =================
    if nargin < 2
        usar_vandermonde = false; % padrão: NÃO aplica Vandermonde
    end

    if nargin < 1
        % Se a função for chamada totalmente vazia, roda o padrão 3x3 da prova
        x = [4; 2; 7];
        usar_vandermonde = true;
    else
        x = A; % Guarda a entrada caso seja o vetor de pontos x
    end

    % --- Se a flag for TRUE, constrói a Matriz de Vandermonde Dinâmica NxN ---
    if usar_vandermonde
        N = length(x); % Detecta o tamanho N baseado no número de pontos fornecidos
        A_vander = zeros(N, N);
        for i = 1:N
            for j = 1:N
                % Eleva o ponto x(i) às potências decrescentes: N-1, N-2, ..., 0
                A_vander(i, j) = x(i)^(N - j);
            end
        end
        A = A_vander; % Substitui A pela matriz de Vandermonde gerada
        fprintf('Montando Matriz de Vandermonde Dinâmica de tamanho (%dx%d):\n', N, N);
    else
        fprintf('Usando Matriz Direta fornecida de tamanho (%dx%d):\n', size(A,1), size(A,2));
    end

    % Coleta a dimensão final calculada para alinhar o vetor b da sua inversa
    n_linhas = size(A, 1);

    % ================= INÍCIO DO CÁLCULO =================
    fprintf('\n==================================================\n');
    fprintf('            CÁLCULO DO NÚMERO DE CONDICÃO\n');
    fprintf('==================================================\n');

    % 1. Normas da matriz original A
    fprintf('\n[Passo 1] Calculando normas da Matriz Original A:\n');
    [n1_A, ninf_A] = determinar_normas(A);

    % 2. Inversa usando a sua função do Gauss-Jordan
    fprintf('\n[Passo 2] Calculando a matriz inversa de A via Gauss-Jordan...\n');

    % Alinha o b dinamicamente com o tamanho real Nx1 para não dar "out of bound"
    b_automatico = zeros(n_linhas, 1);
    [A_inv, ~] = inversa_gauss_jordan(A, b_automatico);

    % 3. Normas da matriz inversa A^-1
    fprintf('\n[Passo 3] Calculando normas da Matriz Inversa A^-1:\n');
    [n1_inv, ninf_inv] = determinar_normas(A_inv);

    % 4. Cálculos dos números de condição
    cond_inf = ninf_A * ninf_inv;
    cond_1   = n1_A * n1_inv;

    % ================= OUTPUT FINAL =================
    fprintf('\n==================================================\n');
    fprintf('              DIAGNÓSTICO DO SISTEMA\n');
    fprintf('==================================================\n');

    fprintf('--- Usando Norma Infinito (Linhas) ---\n');
    fprintf('  ||A||_inf       = %.5f\n', ninf_A);
    fprintf('  ||A^-1||_inf    = %.5f\n', ninf_inv);
    fprintf('  Cond_inf        = %.5f\n\n', cond_inf);

    fprintf('--- Usando Norma 1 (Colunas) ---\n');
    fprintf('  ||A||_1         = %.5f\n', n1_A);
    fprintf('  ||A^-1||_1      = %.5f\n', n1_inv);
    fprintf('  Cond_1          = %.5f\n\n', cond_1);

    fprintf('--------------------------------------------------\n');

    if cond_inf < 100
        fprintf('  (Norma inf) Sistema BEM-CONDICIONADO.\n');
    else
        fprintf('  (Norma inf) Sistema MAL-CONDICIONADO.\n');
    end

    if cond_1 < 100
        fprintf('  (Norma 1)   Sistema BEM-CONDICIONADO.\n');
    else
        fprintf('  (Norma 1)   Sistema MAL-CONDICIONADO.\n');
    end

    fprintf('==================================================\n');

    cond = cond_inf;
end
