Base.include(@__MODULE__,"NumpyFunctions.jl")

module FunctionsTranslate

using Main.NumpyFunctions

@inline function run(file::Array{String,1})
    NumpyFunctions.run(file)
end
export run

end
