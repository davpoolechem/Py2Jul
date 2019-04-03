Base.include(@__MODULE__,"Products.jl")

module LinalgTranslate

using Main.Products

@inline function run(file::Array{String,1})
    Products.run(file)
end
export run

end
