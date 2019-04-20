module ScipyTranslate

include("ScipyFunctions.jl")

using .ScipyFunctions

@inline function run(file::Array{String,1})
    ScipyFunctions.run(file)
end
export run

end
