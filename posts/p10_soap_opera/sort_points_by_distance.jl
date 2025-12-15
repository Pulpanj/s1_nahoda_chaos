function sort_points_by_distance(
    points::Vector{GPoint{Float64}}, ref::GPoint{Float64}
)
    """
    sort_points_by_distance(
        points::Vector{GPoint{Float64}}, ref::GPoint{Float64}
        )

    Returns the points sorted by their distance from 
    the reference point `ref`
    """
    distances = [(p, norm(p .- ref)) for p in points]
    # Sort by distance descending
    sorted = sort(distances, by=x -> x[2])
    # Return the points sorted by distances
    return [sorted[i][1] for i in 1:length(points)]
end

