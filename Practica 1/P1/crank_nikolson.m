function [U, tiempo] = crank_nikolson(U_0, J, N)
    U = zeros(J + 1, N + 1); % Prealocamos para mayor eficiencia
    U(:, 1) = U_0; %% Fijamos las condiciones iniciales

    %D = diag(-2 * ones(J - 1, 1)) + diag(1 * ones(J - 2, 1), 1) + diag(1 * ones(J - 2, 1), -1);
    %I = eye(J - 1);
    %R = I  + 0.5 * (0.5 / N) * J^2 * D;
    %L = I - 0.5 * (0.5 / N) * J^2 * D;

    D = spdiags([ones(J - 1, 1), -2 * ones(J - 1, 1), ones(J - 1, 1)], -1 : 1, J - 1, J - 1);
    mu = 0.5 * (0.5 / N) * J^2;
    I = speye(J - 1);

    R = I + mu * D;
    L = I - mu * D;

    DL = decomposition(L);
        
    tic
    for n = 2 : N + 1
        U(2 : J , n) = DL \ (R * U(2 : J, n - 1)); 
    end

    tiempo = toc;
end