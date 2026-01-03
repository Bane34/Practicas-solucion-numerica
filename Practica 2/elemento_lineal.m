function val = elemento_lineal(x, a, m, b)
    val = NaN;

    if x >= a && x <= b
        val = (x - a) / (m - b);
    else if x >= a 
        val = (b - x) / (b - m);
    end
end