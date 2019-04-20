module RandomTranslate

include("ForFloat.jl")

using .ForFloat

@inline function run(file::Array{String,1})
    ForFloat.run(file)
end
export run

end
