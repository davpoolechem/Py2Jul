module NumpyTranslate

include("array/ArrayTranslate.jl")
include("functions/FunctionsTranslate.jl")
include("random/RandomTranslate.jl")

using .ArrayTranslate
using .FunctionsTranslate
using .RandomTranslate

@inline function run(file::Array{String,1})
    ArrayTranslate.run(file)
    FunctionsTranslate.run(file)
    RandomTranslate.run(file)
end
export run

end
