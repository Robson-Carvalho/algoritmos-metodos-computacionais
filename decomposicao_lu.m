function x = decomposicao_lu(A, b)
    format short; % Define a exibição para 4 casas decimais (Posso tirar para aparecer mais casas)

    if nargin < 2
        A = [3, 2, 4; 1, 1, 2; 4, 3, 2];
        b = [1; 2; 3];
        fprintf('Executando Decomposição LU com sistema padrão:\n');
    end

    n = length(b);
    L = zeros(n);
    for i = 1:n
        L(i,i) = 1;
    end
    U = A;

    fprintf('--- 5. DECOMPOSIÇÃO LU ---\n');

    % Fatoração LU
    for k = 1:n-1
        for i = k+1:n
            m = U(i,k) / U(k,k);
            L(i,k) = m;
            U(i,k:end) = U(i,k:end) - m * U(k,k:end);
        end
    end
    fprintf('Matriz Triangular Inferior L:\n'); disp(L);
    fprintf('Matriz Triangular Superior U:\n'); disp(U);

    % Passo 1: Resolver Ly = b (Substituição progressiva)
    y = zeros(n, 1);
    y(1) = b(1) / L(1,1);
    for i = 2:n
        soma = 0;
        for j = 1:i-1
            soma = soma + L(i,j) * y(j);
        end
        y(i) = (b(i) - soma) / L(i,i);
    end
    fprintf('Vetor intermediário y resolvido (L*y = b):\n'); disp(y);

    % Passo 2: Resolver Ux = y (Substituição retroativa)
    x = zeros(n, 1);
    x(n) = y(n) / U(n,n);
    for i = n-1:-1:1
        soma = 0;
        for j = i+1:n
            soma = soma + U(i,j) * x(j);
        end
        x(i) = (y(i) - soma) / U(i,i);
    end
    fprintf('Solução final x (U*x = y):\n'); disp(x);
end
