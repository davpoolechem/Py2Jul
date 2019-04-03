Base.include(@__MODULE__,"Constants.jl")
Base.include(@__MODULE__,"Logarithmic.jl")
Base.include(@__MODULE__,"Special.jl")
Base.include(@__MODULE__,"Theoretic.jl")
Base.include(@__MODULE__,"Trigonometric.jl")

module MathTranslate

using Main.Constants
using Main.Logarithmic
using Main.Special
using Main.Theoretic
using Main.Trigonometric

@inline function run(file::Array{String,1})
    Constants.run(file)
    Logarithmic.run(file)
    Special.run(file)
    Theoretic.run(file)
    Trigonometric.run(file)
end
export run

end
