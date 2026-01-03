function [U, tiempo] = euler_implicito(U_0, J, N)
    U = zeros(J + 1, N + 1); % Prealocamos para mayor eficiencia
    U(:, 1) = U_0; %% Fijamos las condiciones iniciales
    

    % construimos la matriz del método explicito
    %D = diag(-2 * ones(J - 1, 1)) + diag(1 * ones(J - 2, 1), 1) + diag(1 * ones(J - 2, 1), -1);
    %I = eye(J - 1);
    %M = I - (0.5 / N) * J^2 * D;
    
    mu = (0.5 / N) * J^2;
    M = spdiags([ -1 * mu * ones(J - 1, 1), (1 + 2 * (0.5 / N) * J^2) * ones(J - 1, 1), -1 * mu * ones(J - 1, 1)], -1 : 1, J - 1, J - 1);
    DM = decomposition(M); 

    tic
    for n = 2 : N + 1
        
        U(2 : J , n) = DM \ U( 2 : J, n - 1); 
    end
    
    tiempo = toc;
end