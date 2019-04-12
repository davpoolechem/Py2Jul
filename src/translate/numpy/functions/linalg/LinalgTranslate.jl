module LinalgTranslate

using Products
using Decompositions
using Eigensolvers

@inline function run(file::Array{String,1})
    Products.run(file)
    Decompositions.run(file)
    Eigensolvers.run(file)
end
export run

end
