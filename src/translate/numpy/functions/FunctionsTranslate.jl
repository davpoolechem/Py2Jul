module FunctionsTranslate

using NumpyFunctions

@inline function run(file::Array{String,1})
    NumpyFunctions.run(file)
end
export run

end
