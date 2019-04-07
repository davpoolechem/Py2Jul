module LinalgTranslate

using Products

@inline function run(file::Array{String,1})
    Products.run(file)
end
export run

end
