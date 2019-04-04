Base.include(@__MODULE__,"ForFloat.jl")

module RandomTranslate

using Main.ForFloat

@inline function run(file::Array{String,1})
    ForFloat.run(file)
end
export run

end
