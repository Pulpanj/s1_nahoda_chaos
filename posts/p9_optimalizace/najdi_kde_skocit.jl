using Polynomials

function najdi_kde_skocit(xt, yt, vp, vm)
    # najdi optimalni misto kde skocit do vody
    A = vm^2 - vp^2
    B = 2 * yt * (vp^2 - vm^2)
    C = vm^2 * ((xt - x)^2 + yt^2) - vp^2 * (x^2 + yt^2)
    D = 2 * vp^2 * x^2 * yt
    E = -vp^2 * x^2 * yt^2

    # E + D*y + C*y^2 + B*y^3 + A*y^4
    p = Polynomial([E, D, C, B, A]) 
    roots_all = roots(p)    # complex roots
    roots_real = real.(filter(r -> isreal(r), roots_all))
    ystar = filter(r -> (r < yt), roots_real)
    return ystar[1]
end
