module ArrayTranslate

using FromExisting
using ZeroesOnes

@inline function run(file::Array{String,1})
    FromExisting.run(file)
    ZeroesOnes.run(file)
end
export run

end
