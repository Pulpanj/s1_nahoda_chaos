function doba_k_zachrane(y, label="")
    L1 = sqrt(x^2 + y^2)
    L2 = sqrt((xt - x)^2 + (yt - y)^2)
    T1 = L1 / vp
    T2 = L2 / vm
    Ty = T1 + T2
    if label != ""
        println(
            "$label: y:$(f_digits(y)) [m] celkem: $(f_digits(Ty))[s] \
            (L1+L2=$(f_digits(L1+L2))[m]), \
            \n pláž: $(f_digits(T1))[s] (L1=$(f_digits(L1))[m]), \
            \n moře: $(f_digits(T2))[s] (L2=$(f_digits(L2))[m])"
        )
    end
    return [y, Ty, L1, L2, T1, T2, L1 + L2]
end;