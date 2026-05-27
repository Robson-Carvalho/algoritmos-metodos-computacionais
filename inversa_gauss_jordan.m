function A_inv = inversa_gauss_jordan(A)
    if nargin < 1
        A = [4, 1, 2; 1, 3, 0; 2, 0, 5];
        fprintf('Executando cálculo de Inversa com matriz padrão:');
    end

    n = size(A, 1);
    I = zeros(n);
    for i = 1:n, I(i,i) = 1; end
    A_ext = [A, I];

    fprintf('--- 4. MATRIZ INVERSA POR GAUSS-JORDAN ---');
    fprintf('Matriz estendida inicial [A | I]:'); disp(A_ext);

    for k = 1:n
        pivo = A_ext(k,k);
        A_ext(k,:) = A_ext(k,:) / pivo;
        for i = 1:n
            if i ~= k
                m = A_ext(i,k);
                A_ext(i,:) = A_ext(i,:) - m * A_ext(k,:);
            end
        end
    end

    A_inv = A_ext(:, n+1:end);
    fprintf('Matriz Inversa calculada A^-1:'); disp(A_inv);

    fprintf('Verificação passo a passo (Multiplicação A * A^-1):');
    Verif = zeros(n);
    for i = 1:n
        for j = 1:n
            s = 0;
            for r = 1:n
                s = s + A(i,r) * A_inv(r,j);
            end
            Verif(i,j) = s;
        end
    end
    disp(Verif);
end

