Base.include(@__MODULE__,"FromExisting.jl")
Base.include(@__MODULE__,"ZeroesOnes.jl")

module ArrayTranslate

using Main.FromExisting
using Main.ZeroesOnes

@inline function run(file::Array{String,1})
    FromExisting.run(file)
    ZeroesOnes.run(file)
end
export run

end
