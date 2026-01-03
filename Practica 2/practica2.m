%% Recordar no evaluar errores en los nodos de interpolacion (sino da orden 4 en vez de 3 para elementos cuadraticos)
% Dos conjuntos de nodos: donde discretizas y donde compruebas los errores
% Término fuente
f = @(x) (1 + pi^2) * sin(pi * x);

% Solución exacta
u_e =  @(x) sin(pi * x);

% Extremos del intervalo
a = 0; b = 1;

U_e = solucion_exacta(u_e, h);

%% Practica 1
% se satura el error, uno cae con pediente 2 y el otro con pendiente 1
% verlo más facil fijando un valor y analizando los otros (fijamos uno muy
% fino) para ver las pendientes de los errores por separados
% Para la pendiente usar los errores que no están saturados