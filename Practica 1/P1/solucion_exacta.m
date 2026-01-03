function U = solucion_exacta(u, J, N)
    x_vals = [0 : 1 / J : 1];
    
    k = 0.5 / N;

    for n = 0 : N
        U(:, n + 1) = u(x_vals, n * k);
    end
end