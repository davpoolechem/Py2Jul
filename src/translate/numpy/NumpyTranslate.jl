module NumpyTranslate

using ArrayTranslate
using FunctionsTranslate

@inline function run(file::Array{String,1})
    ArrayTranslate.run(file)
    FunctionsTranslate.run(file)
end
export run

end
