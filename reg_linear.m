function coefs = reg_linear(X, Y)

    if nargin < 2
        X = [1 2 3 4 5 6 7 8 9 10];
        Y = [1.3 3.5 4.2 5.0 7.0 8.8 10.1 12.5 13.0 15.6];
        fprintf('Executando Regressão Linear Simples com dados de teste\n\n');
    end

    n = length(X);
    sum_x = 0; sum_y = 0; sum_x2 = 0; sum_xy = 0;

    fprintf('========================================\n');
    fprintf('  REGRESSÃO LINEAR (MÍNIMOS QUADRADOS)\n');
    fprintf('========================================\n\n');

    fprintf('Passo a passo dos somatórios:\n\n');

    for i = 1:n
        sum_x = sum_x + X(i);
        sum_y = sum_y + Y(i);
        sum_x2 = sum_x2 + X(i)^2;
        sum_xy = sum_xy + X(i) * Y(i);

        fprintf('Dado %d -> X=%6.2f | Y=%6.2f\n', i, X(i), Y(i));
        fprintf('   SumX = %8.2f | SumY = %8.2f | SumX2 = %8.2f | SumXY = %8.2f\n\n', ...
            sum_x, sum_y, sum_x2, sum_xy);
    end

    % Sistema normal
    M = [n, sum_x; sum_x, sum_x2];
    B = [sum_y; sum_xy];

    det_M = M(1,1)*M(2,2) - M(1,2)*M(2,1);

    coefs = zeros(2,1);
    coefs(1) = (B(1)*M(2,2) - M(1,2)*B(2)) / det_M; % a0 (intercepto)
    coefs(2) = (M(1,1)*B(2) - B(1)*M(2,1)) / det_M; % a1 (inclinação)

    % ==========================================================
    % TRECHO NOVO: ANÁLISE ESTATÍSTICA (CONFORME ENUNCIADO)
    % ==========================================================
    media_y = sum_y / n;
    St = 0;
    Sr = 0;

    for i = 1:n
        St = St + (Y(i) - media_y)^2;             % Soma dos quadrados total
        y_pred = coefs(1) + coefs(2) * X(i);      % Valor estimado pela reta
        Sr = Sr + (Y(i) - y_pred)^2;              % Soma dos quadrados dos resíduos
    end

    sy = sqrt(St / (n - 1));                      % Desvio padrão total
    syx = sqrt(Sr / (n - 2));                     % Erro-padrão da estimativa
    r2 = (St - Sr) / St;                          % Coeficiente de determinação (R²)
    % ==========================================================

    fprintf('========================================\n');
    fprintf('RESULTADO FINAL DA EQUAÇÃO:\n');
    fprintf('y = %.4f + %.4f x\n', coefs(1), coefs(2));
    fprintf('========================================\n\n');

    fprintf('========================================\n');
    fprintf('AVALIAÇÃO ESTATÍSTICA DO AJUSTE:\n');
    fprintf('========================================\n');
    fprintf('Desvio Padrão Total (sy)         = %.4f\n', sy);
    fprintf('Erro-Padrão da Estimativa (syx)  = %.4f\n', syx);
    fprintf('Coeficiente de Determinação (r2) = %.4f (%.2f%%)\n', r2, r2 * 100);
    fprintf('========================================\n');

    % gráfico
    x_g = linspace(min(X), max(X), 200);
    y_g = coefs(1) + coefs(2) * x_g;

    figure;
    plot(X, Y, 'ro', 'MarkerSize', 8, 'LineWidth', 2, 'MarkerFaceColor', 'r'); hold on;
    plot(x_g, y_g, 'b-', 'LineWidth', 2);
    title('Regressão Linear (Mínimos Quadrados)');
    xlabel('X'); ylabel('Y'); grid on;
    legend('Dados Originais', sprintf('Reta de Ajuste (r² = %.4f)', r2), 'Location', 'Southeast');

end
