module RandomTranslate

include("RandomData.jl")

using .RandomData

@inline function run(file::Array{String,1})
    RandomData.run(file)
end
export run

end
