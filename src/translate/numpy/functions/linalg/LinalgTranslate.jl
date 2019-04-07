module LinalgTranslate

using Products
using Decompositions

@inline function run(file::Array{String,1})
    Products.run(file)
    Decompositions.run(file)
end
export run

end
