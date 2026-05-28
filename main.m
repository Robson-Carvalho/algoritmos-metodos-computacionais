clc; clear; format long;

% =========================================================================
%                  MENU INTERATIVO - MÉTODOS NUMÉRICOS
% =========================================================================
disp('===========================================================');
disp('                MENU - MÉTODOS NUMÉRICOS                   ');
disp('===========================================================');
disp(' 1 - Gauss com Pivotamento (Q1)');
disp(' 2 - Gauss-Jordan (Q2)');
disp(' 3 - Gauss Ingênua (Q3)');
disp(' 4 - Decomposição LU (Q4)');
disp(' 5 - Matriz Inversa (Q5)');
disp(' 6 - Normalização de Matriz por Linha (Q6 - Parte 1)');
disp(' 7 - Número de Condição Manual Antigo (Q7 - Rascunho)');
disp(' 8 - Gauss-Seidel (Q8)');
disp(' 9 - Jacobi (Q9)');
disp('10 - SOR (Q10)');
disp('11 - Interpolação de Newton com gerador');
disp('12 - Interpolação de Lagrange com gerador');
disp('13 - Polinômio via Vandermonde Completo');
disp('14 - Ajuste de Potência Linearizada [ln(x), ln(y)]');
disp('15 - Regressão Polinomial (Múltiplos Graus na mesma Curva)');
disp('16 - Regressão Linear Múltipla (Ajuste de Plano 3D)');
disp('17 - Cálculo de Normas Matriciais (||A||1 e ||A||inf Nativo)');
disp('18 - Diagnóstico Completo de Condicionamento (Nativo Q7)');
disp('===========================================================');

opcao = 12; % <<< DIGITE O NÚMERO DA QUESTÃO AQUI PARA EXECUTAR

switch opcao

    % =========================================================================
    case 1  % Q1 - Gauss com Pivotamento Parcial
        A = [ 1 -1  2;
              2  1 -1;
             -1  1  1];
        b = [2; 1; 1];

        x = gauss_pivotamento(A, b);
        disp('>> DICA: Determinante = produto da diagonal da matriz triangularizada <<');

    % =========================================================================
    case 2  % Q2 - Gauss-Jordan
       A = [130 -30 0; 90 -90 0; 40 60 -120];
       b = [200; 0; -500];


        x = gauss_jordan(A, b);

    % =========================================================================
    case 3  % Q3 - Gauss Ingênua (Sem pivô)
        A = [ 2,  1, -1,  2;
              4,  4,  1,  3;
             -2, -3,  1, -1;
              2,  1,  3, -2 ];

        % Vetor b (4x1)
        b = [ 11;
              20;
              -9;
               1 ];

        x = gauss_ingenua(A, b);

    % =========================================================================
    case 4  % Q4 - Decomposição LU
        A = [7 2 -3;
             2 5 -3;
             1 -1 -6];
        b = [-12; -20; -26];

        x = decomposicao_lu(A, b);

        % resolva o sistema para um vetor do lado direito alternativo aproveitando as matrizes L e U obtidas em (a):

        b_b = [12; 18; -6];
        x_b = decomposicao_lu(A, b_b);

    % =========================================================================
    case 5  % Q5 - Matriz Inversa via Gauss-Jordan (Não precisa passar a matriz aumentada)
      A = [10,  2, -1;
             -3, -6,  2;
              1,  1,  5];

        % Vetor dos termos independentes da imagem
        b = [27; -61.5; -21.5];
        A_inv = inversa_gauss_jordan(A, b);

    % =========================================================================
    case 6  % Q6 - Normalização por Linha (Maior elemento de cada linha = 1)
        A = [ 8  2 -10;
             -9  1   3;
              15 -1  6];

        % Executa a divisão de cada linha pelo seu maior valor absoluto
        for i = 1:size(A,1)
            max_linha = max(abs(A(i,:)));
            A(i,:) = A(i,:) / max_linha;
        end

        disp('-> Matriz normalizada individualmente por linhas:');
        disp(A);
        [n1, ninf] = determinar_normas(A);

    % =========================================================================
    case 7  % Q7 - Número de condição (Versão Rascunho)
        x1 = 4; x2 = 2; x3 = 7;
        A = [x1^2, x1, 1;
             x2^2, x2, 1;
             x3^2, x3, 1];

        cond = numero_condicao(A);

    % =========================================================================
    case 8  % Q8 - Método Iterativo de Gauss-Seidel
         A = [0.8  -0.4  0;
             -0.4  0.8  -0.4;
             0  -0.4 0.8];

        b = [41; 25; 105];

        x0 = [0; 0; 0]; % Estimativa inicial

        % Parâmetros: (A, b, x0, tolerância, max_iterações)
        x = gauss_seidel(A, b, x0, 0.05, 100);

    % =========================================================================
    case 9  % Q9 - Método Iterativo de Jacobi
        A = [10  2  -1;
            -3  -6  2;
             1  1 5];

        b = [27; -61.5; -21.5];

        x0 = [0; 0; 0];

        x = gauss_jacobi(A, b, x0, 0.05, 100);

    % =========================================================================
    case 10 % Q10 - Método Iterativo SOR (Sucessivas Sobrerrelaxações) OTIMIZADO
        disp('--- RESOLVENDO Q10 COM REARRANJO DE LINHAS ---');

        % Matriz rotacionada manualmente para garantir diagonal dominante
        A = [2 -6 -1;
              -3 -1 7;
             -8 1 -2];

        % Vetor b acompanhando a mesma troca de linhas
        b = [-38; -34; -20];

        x0 = [0; 0; 0];

        % Definindo a tolerância de 5% pedida no enunciado (5% = 0.05)
        tol = 0.05;
        max_iter = 100;

        % Fator omega escolhido para o teste
        omega = 1.2;

        x = sor(A, b, x0, tol, max_iter, omega);

    % =========================================================================
    case 11 % Interpolação de Newton (Diferenças Divididas)
        disp('--- Buscando coordenadas do Gerador de Pontos ---');
        [X, Y] = gerar_pontos();

        % Restringe para 3 pontos (Grau 2) para simular prova manual
        X = X(1:3); Y = Y(1:3);
        disp('Pontos ativos para a interpolação [X | Y]:'); disp([X', Y']);

        coefs = interp_newton(X, Y);

    % =========================================================================
    case 12 % Interpolação Polinomial de Lagrange
        disp('--- Buscando coordenadas do Gerador de Pontos ---');
        [X, Y] = gerar_pontos();

        X = X(1:3); Y = Y(1:3);
        disp('Pontos ativos para a interpolação [X | Y]:'); disp([X', Y']);

        mostrar_L = [1 2]; % Índices dos polinômios de suporte Li a exibir
        interp_lagrange(X, Y, mostrar_L);

    % =========================================================================
    case 13 % Polinômio via Sistema de Vandermonde Completo
        X = [1, 50, 100];
        Y = [1, 50, 100];
        disp('Pontos aplicados à matriz:'); disp([X', Y'])

        V = matriz_vandermonde(X);
        Y = Y(:); % Garante vetor coluna rígido

        coefs = gauss_ingenua(V, Y);

        disp('Coeficientes reais calculados [a0, a1, a2]:');
        fprintf('  a0 (termo indep.) = %.6f\n', coefs(1));
        fprintf('  a1 (termo x^1)   = %.6f\n', coefs(2));
        fprintf('  a2 (termo x^2)   = %.6f\n', coefs(3));

    % =========================================================================
    case 14 % Ajuste Não-Linear de Potência Linearizada (y = alfa * x^beta)
        X = [10; 20; 30; 40; 50; 60; 70; 80];
        Y = [25; 70; 380; 550; 610; 1220; 830; 1450];

        disp('Dados originais da tabela:'); disp([X, Y]);

        % Transforma dados originais aplicando ln(X) e ln(Y)
        M = matriz_potencia_linearizada(X, Y);

        X_lin = M(:, 1);
        Y_lin = M(:, 2);

        % Ajusta a reta nos dados transformados logaritmicamente
        coefs_linearizados = reg_linear(X_lin, Y_lin);

        % Deslinearização (Retorna para a escala física original)
        alfa = exp(coefs_linearizados(1)); % b0 = ln(alfa) -> alfa = e^(b0)
        beta = coefs_linearizados(2);      % b1 = beta

        fprintf('\n--- COEFICIENTES DO MODELO DE POTÊNCIA ---\n');
        fprintf('  Alfa (Escalar Multiplicativo) = %.6f\n', alfa);
        fprintf('  Beta (Expoente do Ajuste)     = %.6f\n', beta);
        fprintf('  Equação Final Curva: y = %.6f * x^(%.6f)\n\n', alfa, beta);

    % =========================================================================
    case 15 % Regressão Polinomial Avançada (Múltiplos Graus Simultâneos)
        disp('--- Buscando coordenadas do Gerador de Pontos ---');
        [X, Y] = gerar_pontos();
        X = X(:); Y = Y(:);

        % Defina aqui quais graus quer sobrepor no mesmo gráfico comparativo
        graus_mostrar = [1, 3, 10];
        fprintf('Processando curvas para os graus: %s\n', num2str(graus_mostrar));

        reg_polinomial(X, Y, graus_mostrar);

    % =========================================================================
    case 16 % Regressão Linear Múltipla (Superfície 3D: y = b0 + b1*x1 + b2*x2)
        % Matriz X_dados onde cada coluna é uma variável independente [x1, x2]
        X_dados = [ 0,   0;
                    2,   1;
                    2.5, 2;
                    1,   3;
                    4,   6;
                    7,   2 ];
        Y_dados = [5; 10; 9; 0; 3; 27];

        disp('Dados em colunas para regressão [X1, X2 | Y]:'); disp([X_dados, Y_dados]);

        coefs_multiplos = reg_linear_multipla(X_dados, Y_dados);

    % =========================================================================
    case 17 % Q6 - Determinação de Normas Matriciais Puras (||A||1 e ||A||inf)
        disp('--- MODO SEGURO ATIVO ---');
        % Roda direto os dados salvos dentro da função se chamada vazia.
        % Se quiser rodar outra matriz, descomente as duas linhas abaixo:
        A_teste = [8 2 -10; -9 1 3; 15 -1 6];
        % [n1, ninf] = determinar_normas(A_teste);

        A_normalizada = normalizar_matriz(A_teste);

        % 2. Passa a matriz já normalizada para calcular as normas

        [n1, ninf] = determinar_normas(A_normalizada);

    % =========================================================================
    case 18 % Q7 - Diagnóstico Completo de Condicionamento (Cond Nativo via Inversa)
        disp('--- MODO SEGURO ATIVO ---');

        x_provas = [4; 2; 7]; % 3 pontos geram uma matriz 3x3 de Vandermonde

        % Ativando como TRUE: A função transforma o vetor x_provas em matriz
        cond = numero_condicao(x_provas, true);

        %A_prova = [ 5, -1,  2; 3,  8, -2; 1,  1,  4 ];
        % Ativando como FALSE: A função usa a matriz A_prova exatamente como ela é
        %cond = numero_condicao(A_prova, false);

    % =========================================================================
    otherwise
        disp('Erro: Opção não cadastrada no menu! Verifique o valor da variável "opcao".');
end
