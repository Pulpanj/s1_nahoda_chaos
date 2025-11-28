"""
	entropy(p::AbstractVector; base::Real=2)

Compute the information entropy of probability vector `p`.
- `p` may be unnormalized; it will be normalized automatically.
- Negative entries raise an error.
- Zero probabilities are ignored in the sum (0*log 0 -> 0).
- `base` chooses the log base: `2` for bits, `e` for nats, etc.
"""
function entropy(
	p::AbstractVector{<:Real};
	base::Real = 2, 
    verbose::Bool = false
)
	p_float = Float64.(p)
	if any(p_float .< 0)
		throw(ArgumentError("Probabilities must be non-negative"))
	end
	s = sum(p_float)
	p_norm = p_float ./ s
	nz = p_norm .> 0
	if base == 2
		Q = -sum(p_norm[nz] .* log2.(p_norm[nz]))
	else
		Q = -sum(p_norm[nz] .* (log.(p_norm[nz]) ./ log(base)))
	end
	if verbose
		println("Information entropy based on $(length(p)) probabilities : $Q ")
	end
	return Q
end
