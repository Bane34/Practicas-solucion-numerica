% metodo: 1 -> regla del punto medio
%         2 -> interpolante lineal

function C = elementos_finitos_lineales(f, J, metodo) 
    h = 1 / (J - 1);
    xx = [h : h : 1 - h];
    % Al ser mallas uniformes no hace falta ensamblar las matrices dado su
    % simplicidad

    % Construcción de la matriz de masa 
    M = (h / 6) * spdiags([1, 4, 1], -1 : 1, J - 2, J - 2);
    
    % Construcción de la matriz de rigidez
    K = (J - 1) * spdiags([-1, 2, -1], -1 : 1, J - 2, J - 2);

    A = M + K;
    % Construcción del vector de carga
    if metodo  == 1
        b = h * f(xx)';
    else
        b = M * f(xx)';
    end
    
    % Tenemos que resolver A C = b

    C = A \ b;
    C = [0; C; 0];
end