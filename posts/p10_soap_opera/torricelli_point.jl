using Optim, GeometryBasics, LinearAlgebra

const GPoint = GeometryBasics.Point2

function torricelli_point(
    AP::GPoint{Float64}, BP::GPoint{Float64}, CP::GPoint{Float64}
)
    """
    torricelli_point(
        AP::GPoint{Float64}, BP::GPoint{Float64}, CP::GPoint{Float64}
    )
    
    Returns Fermat–Torricelli point of triangle ABC with vertices AP, BP, CP
    Fermat–Torricelli point is such that the sum of the three distances from
    each of the three vertices of the triangle to the point is the smallest
    possible, see <https://en.wikipedia.org/wiki/Fermat_point> 
    """



    # Euclidean distance sum
    function sum_distances(
        P::GPoint{Float64}, vertices::Vector{GPoint{Float64}}
    )
        total_dist = 0.0
        for V in vertices
            total_dist += norm(P .- V)
        end
        return total_dist
    end

    # Compute angle at vertex A given triangle ABC
    function angle(
        A::GPoint{Float64}, B::GPoint{Float64}, C::GPoint{Float64}
    )
        u = B .- A
        v = C .- A
        return acos(dot(u, v) / (norm(u) * norm(v)))
    end



    # Check angles
    α = angle(AP, BP, CP)
    β = angle(BP, AP, CP)
    γ = angle(CP, AP, BP)

    if α ≥ 2π / 3   # 120°
        return AP
    elseif β ≥ 2π / 3
        return BP
    elseif γ ≥ 2π / 3
        return CP
    else
        # Otherwise, optimize
        # Fermat point solver
        vertices = [AP, BP, CP]
        initial_guess = GPoint(sum(v[1] for v in vertices) / 3,
            sum(v[2] for v in vertices) / 3)
        result = optimize(p -> sum_distances(GPoint(p...), vertices),
            [initial_guess[1], initial_guess[2]], NelderMead())
        return GPoint(result.minimizer...)
    end
end

