% Término fuente
f = @(x) (1 + pi^2) * sin(pi * x);

% Solución exacta
u_e =  @(x) sin(pi * x);

%% Gráficas para elementos finitos lineales

tiledlayout(1, 2);
nexttile

J = 7;
h = 1 / (J);

xx = [h : h : 1 - h];
xx = [0, xx, 1];
U = elementos_finitos_lineales(f, J, 1);
xx = linspace(0, 1, J);
plot(xx, U);

hold on;
uu = [0 : 0.01 : 1];
plot(uu, u_e(uu));
hold off;

legend('Aproximación', 'Solución exacta');
title('Aproximación para J=7');

nexttile

J = 15;
h = 1 / (J);

xx = [h : h : 1 - h];
xx = [0, xx, 1];
U = elementos_finitos_lineales(f, J, 1);
xx = linspace(0, 1, J);
plot(xx, U);

hold on;
uu = [0 : 0.01 : 1];
plot(uu, u_e(uu));
hold off;

legend('Aproximación', 'Solución exacta');
title('Aproximación para J=15');

pause
close all;

%% Gráficas para elementos finitos cuadraticos

tiledlayout(1, 2);
nexttile

J = 7;
h = 1 / J;

xx = [h / 2: h / 2 : 1 - (h / 2)];
xx = [0, xx, 1];
U = elementos_finitos_cuadraticos(f, J, 1);
plot(xx, U);

hold on;
uu = [0 : 0.01 : 1];
plot(uu, u_e(uu));
hold off;

legend('Aproximación', 'Solución exacta');
title('Aproximación para J=7');

nexttile

J = 15;
h = 1 / J;

xx = [h / 2: h / 2 : 1 - (h / 2)];
xx = [0, xx, 1];
U = elementos_finitos_cuadraticos(f, J, 1);
plot(xx, U);

hold on;
uu = [0 : 0.01 : 1];
plot(uu, u_e(uu));
hold off;

legend('Aproximación', 'Solución exacta');
title('Aproximación para J=15');

pause 
close all
pause


%% Cálculo del error en norma L^2 para elementos finitos lineales

% Error para la regla de los trapecios
error = zeros(500, 1);
J_vals = zeros(500, 1);
for i = 1: 500
    J = 10 + i;
    J_vals(i, 1) = J;
    U = elementos_finitos_lineales(f, J, 1);
    error(i, 1) = error_L2_lin(U, u_e, J);
end

% Pintamos el error en L^2
loglog(J_vals, error);
title('Convergencia de los elementos lineales con regla de los trapecios');
xlabel('Valores de J');
ylabel('Error cometido');

% Calculamos la pendiente para ver el orden de convergencia del método
p = polyfit(log(J_vals), log(error), 1);
p(1)

pause
close all;

% Error para el interpolante lineal
error = zeros(500, 1);
J_vals = zeros(500, 1);
for i = 1: 500
    J = 10 + i;
    J_vals(i, 1) = J;
    U = elementos_finitos_lineales(f, J, 2);
    error(i, 1) = error_L2_lin(U, u_e, J);
end

% Pintamos el error en L^2
loglog(J_vals, error);
title('Convergencia de los elementos lineales con interpolante lineal');
xlabel('Valores de J');
ylabel('Error cometido');

% Calculamos la pendiente para ver el orden de convergencia del método
p = polyfit(log(J_vals), log(error), 1);
p(1)

pause 
close all;

%% Cálculo del error en norma L^2 para elementos finitos cuadráticos
error = zeros(500, 1);
J_vals = zeros(500, 1);

for i = 1: 500
    J = 10 + i;
    J_vals(i, 1) = J;
    U = elementos_finitos_cuadraticos(f, J, 1);
    error(i, 1) = error_L2_cuad(U, u_e, J);
end
% Pintamos el error en L^2
loglog(J_vals, error);
title('Convergencia de los elementos cuadraticos con regla de Simpson');
xlabel('Valores de J');
ylabel('Error cometido');

% Calculamos la pendiente para ver el orden de convergencia del método
p = polyfit(log(J_vals), log(error), 1);
p(1)

pause 
close all;

for i = 1: 500
    J = 10 + i;
    J_vals(i, 1) = J;
    U = elementos_finitos_cuadraticos(f, J, 2);
    error(i, 1) = error_L2_cuad(U, u_e, J);
end
% Pintamos el error en L^2
loglog(J_vals, error);
title('Convergencia de los elementos cuadraticos con interpolante cuadrático');
xlabel('Valores de J');
ylabel('Error cometido');

% Calculamos la pendiente para ver el orden de convergencia del método
p = polyfit(log(J_vals), log(error), 1);
p(1)