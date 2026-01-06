function error = error_L2_cuad(U, u_e, J)
    % Vamos a usar la regla de Simpson para aproximar el error en L^2
    % Para aproximar la cuadratura se usan nodos distintos a los usados
    % para calcular la aproximacion de elementos finitos

    n = 4 * J + 1;
    xx = linspace(0, 1, n);
    
    error = 0;
    
    % Creamos un handle de u - u_h
    u = @(x) abs(u_e(x) - u_hc(U, x, J))^2; 

    for i = 1 : n - 1
        % Aplicamos la regla de Simpson
        h = xx(i + 1) - xx(i);
        error = error +  (h / 6) * ( u(xx(i)) + 4 * u((xx(i) + xx(i + 1)) / 2) + u(xx(i + 1)) );
    end

    error = sqrt(error);
end

function val = u_hc(U, x, J)
    h = 1 / (J); 
    x_el = [0 : h : 1];

    val = 0;

    for j = 2 : J - 1
        val = val + U(j) * el_cuad(x_el(j - 1), x_el(j), x_el(j + 1), x);
    end
    
end