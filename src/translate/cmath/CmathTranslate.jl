module CmathTranslate

include("CmathConstants.jl")
include("CmathLogarithmic.jl")
include("CmathTheoretic.jl")
include("CmathTrigonometric.jl")

using .CmathConstants
using .CmathLogarithmic
using .CmathTheoretic
using .CmathTrigonometric

@inline function run(file::Array{String,1})
    CmathConstants.run(file)
    CmathLogarithmic.run(file)
    CmathTheoretic.run(file)
    CmathTrigonometric.run(file)
end
export run

end
