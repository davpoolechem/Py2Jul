Base.include(@__MODULE__,"array/ArrayTranslate.jl")
Base.include(@__MODULE__,"functions/FunctionsTranslate.jl")

module NumpyTranslate

using Main.ArrayTranslate
using Main.FunctionsTranslate

@inline function run(file::Array{String,1})
    ArrayTranslate.run(file)
    FunctionsTranslate.run(file)
end
export run

end
