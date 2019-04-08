module ArrayTranslate

using FromExisting
using ZeroesOnes
using NumericalRanges

@inline function run(file::Array{String,1})
    FromExisting.run(file)
    ZeroesOnes.run(file)
    NumericalRanges.run(file)
end
export run

end
