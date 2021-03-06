module LinalgTranslate

using Products
using Decompositions
using Eigensolvers
using Numbers

@inline function run(file::Array{String,1})
    Products.run(file)
    Decompositions.run(file)
    Eigensolvers.run(file)
    Numbers.run(file)
end
export run

end
