f = @(x, t) cos(pi * x / 2) / ((t + 1)^2) + pi^2 * t * cos(pi * x) / (2 * (t + 1));

u_e = @(x, t) (t / (t + 1)) * (cos(pi * x / 2))^2;

