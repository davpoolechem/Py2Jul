module FunctionsTranslate

using LinalgTranslate

@inline function run(file::Array{String,1})
    LinalgTranslate.run(file)
end
export run

end
