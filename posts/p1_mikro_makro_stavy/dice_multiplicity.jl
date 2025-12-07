using StatsBase
# Function generujici v3echny kombinace N kostek 
function hod_kostkami(N::Int)
	values = 1:6
	return collect(Iterators.product(ntuple(_ -> values, N)...))
end

# funkce identifikující makrostavy  
function sum_ok(mikrostav)
	return map(sum, mikrostav)
end

# funkce vracející multiplicitu makrostavu 
function multiplicita(makrostav)
	# Step 1: get unique values and their counts
	pairs = [(v, count(==(v), makrostav)) for v in unique(makrostav)]
	# Step 2: sort by value
	sorted_pairs = sort(pairs, by = x -> x[1])
	# Step 2: convert to matrix (each row: value, frequency)
	mat = hcat([p[1] for p in pairs], [p[2] for p in pairs])'
	return transpose(mat)
end