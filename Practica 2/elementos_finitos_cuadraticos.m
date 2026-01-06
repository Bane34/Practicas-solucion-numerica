% metodo: 1 -> regla de Simpson
%         2 -> interpolante lineal

function U = elementos_finitos_cuadraticos(f, J, metodo)
    h = 1 / J; % Diametro de la partición extendida

    xx = [h / 2 : h / 2 : 1 - h / 2]; % Partición de [0,1] sin los nodos frontera

    % Construccion de la matriz de masa
    dm_1 = zeros(2 * J - 1 , 1);
    dm_2 = 2 * ones(2 * J - 1, 1);
    dm_3 = -1 * ones(2 * J - 1, 1);
    dm_3(1 : 2 : end) = 0;

    dm_1(1 : 2 : end) = 16;
    dm_1(2 : 2 : end) = 8;

    M = (h / 30) * spdiags([dm_3, dm_2, dm_1, dm_2, dm_3], -2 : 2, 2 * J - 1, 2 * J - 1);

    % Construcción de la matriz de rigidez
    dk_1 = zeros(2 * J - 1, 1);
    dk_2 = -8 * ones(2 * J - 1, 1);
    dk_3 = ones(2 * J - 1, 1);

    dk_1(1 : 2 : end) = 16;
    dk_1(2 : 2 : end) = 14;
    
    dk_3(1 : 2 : end) = 0;
    
    K = (1 / (3 * h)) * spdiags([dk_3, dk_2, dk_1, dk_2, dk_3], -2 : 2, 2 * J - 1, 2 * J - 1);
    
    A = M + K;

    % Construcción del vector de carga
    
    fxx = f(xx)';

    switch metodo
        case 1 % Regla de Simpson
            b = zeros(2 * J - 1, 1);
            b(1 : 2 : end) = (2 / 3) * fxx(1 : 2 : end);
            b(2 : 2 : end) = (1 / 3) * fxx(2 : 2 : end);
            b = h * b;

        case 2 % Interpolante
            b = M * fxx;
    end

    % Resolvemos el sistema
    U = A \ b;
    U = [0; U; 0];
end