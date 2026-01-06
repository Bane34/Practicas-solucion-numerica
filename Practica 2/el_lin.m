function val = el_lin(a, m, b, x)
    h = m - a;
    
    val = 0;

    if a <= x && x <= m
        val = x - a;
    else 
        if  x > m && x <= b
            
            val = b - x;
        end
    end

    val = val / h;  
end
