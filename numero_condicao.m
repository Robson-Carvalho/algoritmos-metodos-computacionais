function cond = numero_condicao(A)
    % Se não passar a matriz, monta a Vandermonde padrão da Q7 com x1=4, x2=2, x3=7
    if nargin < 1
        x1 = 4; x2 = 2; x3 = 7;
        A = [x1^2, x1, 1;
             x2^2, x2, 1;
             x3^2, x3, 1];
        fprintf('Executando numero_condicao com Vandermonde padrão da Q7:\n');
    end

    fprintf('\n==================================================\n');
    fprintf('            CÁLCULO DO NÚMERO DE CONDICÃO\n');
    fprintf('==================================================\n');

    % 1. Calcula a Norma Infinito da matriz original A
    [~, ninf_A] = determinar_normas(A);
    clc; % Limpa o prompt interno para não poluir a saída final

    % 2. Encontra a Matriz Inversa usando a sua função do menu
    fprintf('-> Calculando a matriz inversa de A via Gauss-Jordan...\n');
    A_inv = inversa_gauss_jordan(A);

    % 3. Calcula a Norma Infinito da matriz inversa
    [~, ninf_inv] = determinar_normas(A_inv);
    clc; % Limpa a tela interna de passos

    % 4. Calcula o número de condição final
    cond = ninf_A * ninf_inv;

    % --- EXIBIÇÃO DO DIAGNÓSTICO ---
    fprintf('\n==================================================\n');
    fprintf('              DIAGNÓSTICO DO SISTEMA\n');
    fprintf('==================================================\n');
    fprintf('  ||A||_inf       = %.4f\n', ninf_A);
    fprintf('  ||A^-1||_inf    = %.4f\n', ninf_inv);
    fprintf('  Número de Condição (Cond) = %.4f\n', cond);
    fprintf('--------------------------------------------------\n');

    if cond < 100
        fprintf('  Interpretação: O sistema é BEM-CONDICIONADO (~= 1).\n');
        fprintf('  Apresenta ótima estabilidade numérica.\n');
    else
        fprintf('  Interpretação: O sistema é MAL-CONDICIONADO (>> 1).\n');
        fprintf('  Retas/planos quase paralelos. Pequenos arredondamentos\n');
        fprintf('  vão propagar erros gigantescos nos resultados!\n');
    end
    fprintf('==================================================\n');
end
