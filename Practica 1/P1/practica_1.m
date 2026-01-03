clear;

%% Set up de la práctica
format shortE

% Primera funcion
u_0 = @(x) sin(2 * pi * x);

% Límite de tiempo fijo
T = 0.5;

% Solución exacta del problema
u = @(x, t) sin(2 * pi * x) * exp(-4 * (pi^2) * t);

%% Para saber si el método de euler explicito funciona
% Hacer todo para K /h^2 = \mu constante < 1/2
% dividimos h -> h/2 y k -> k/ 4
% Error = O(k + h^2) = O(h^2) pues k es cosntante (ver que el error se
% divide por 4 E_1 / E_2 ~ 4 -> el método está bien programado (hay una
% mierda que se llama saturación de errores) (también vale para el
% implícito). Ver si hay lio de indices que se pueden joder

h = 0.02;
k = 0.5 * h^2;

h_vals = [h, h / 2, h / 4, h / 8, h / 16];
k_vals = [k, k / 4, k / 16, k / 64, k / (16^2)];

for l = 1 : 5
    J = 1 / h_vals(l);
    U_0 = u_0([0 : h_vals(l) : 1]);
    N = 0.5 / k_vals(l);
    U_exacta = solucion_exacta(u, J, N);
  
    [U, tiempo] = euler_implicito(U_0', J, N);
    
    error(l) = max(max(abs(U(:, end) - U_exacta(:, end))));
end

error

loglog(T ./ k_vals, error)
title('Análisis de la convergencia para h fijo');
xlabel('Valor de N');
ylabel('Error cometido');

p = polyfit(log(0.5 ./ k_vals), log(error), 1);
p = p(1);
p


pause

%% Analisis de la convergencia del método implicito

% Euler implícito

% Fijamos primero un valor de h
h = 0.0015625;

v = 0.05 * ((0.5).^(0:10-1)) / 100;
%k_vals = [h^2 / 2, h^2 / 4, h^2 / 6];

J = 1 / h;

tiempos = zeros(length(v), 1);

for l = 1 : length(v)
    U_0 = u_0([0 : h : 1]);
    N = 0.5 / v(l);
    U_exacta = solucion_exacta(u, J, N);
  
    [U, tiempo] = euler_implicito(U_0', J, N);
    
    error(l) = max(max(abs(U(:, end) - U_exacta(:, end))));
end

% Graficas para la convergencia
loglog(T ./ v, error)
title('Análisis de la convergencia para h fijo');
xlabel('Valor de N');
ylabel('Error cometido');

p = polyfit(log(0.5 ./ v), log(error), 1);
p = p(1);
p

pause

%% Analisis de la convergencia del método crank-nikolson
% Para este no hace falta hacer lo anterior pues el error es O(k^2 + h^2)
% luego solo hay que ver que el error se divide por 4
% Fijamos primero un valor de h
h = 0.0015625;

v = 0.05 * ((0.5).^(0:10-1)) / 100;
%k_vals = [h^2 / 2, h^2 / 4, h^2 / 6];

J = 1 / h;

tiempos = zeros(length(v), 1);

for l = 1 : length(v)
    U_0 = u_0([0 : h : 1]);
    N = 0.5 / v(l);
    U_exacta = solucion_exacta(u, J, N);
  
    [U, tiempo] = crank_nikolson(U_0', J, N);
    
    error(l) = max(max(abs(U(:, end) - U_exacta(:, end))));
end

% Graficas para la convergencia
loglog(T ./ v, error)
title('Análisis de la convergencia para h fijo');
xlabel('Valor de N');
ylabel('Error cometido');

p = polyfit(log(0.5 ./ v), log(error), 1);
p = p(1);
p
