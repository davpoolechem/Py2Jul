module CmathTranslate

Base.include(@__MODULE__,"Constants.jl")
Base.include(@__MODULE__,"Logarithmic.jl")
Base.include(@__MODULE__,"Special.jl")
Base.include(@__MODULE__,"Theoretic.jl")
Base.include(@__MODULE__,"Trigonometric.jl")

using Main.CmathTranslate.Constants
using Main.CmathTranslate.Logarithmic
using Main.CmathTranslate.Special
using Main.CmathTranslate.Theoretic
using Main.CmathTranslate.Trigonometric

@inline function run(file::Array{String,1})
    Constants.run(file)
    Logarithmic.run(file)
    Special.run(file)
    Theoretic.run(file)
    Trigonometric.run(file)
end
export run

end
