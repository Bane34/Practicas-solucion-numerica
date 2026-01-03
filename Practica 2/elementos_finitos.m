function U = elementos_finitos(u_0, f, h) 
    N = 1 / h;

    % Construccion de la matriz de rigidez
    K = diag(N * ones(N, 1)) + diag(2 * N * ones(N - 1, 1), 1) + diag(2 * N * ones(N - 1, 1), -1)
end