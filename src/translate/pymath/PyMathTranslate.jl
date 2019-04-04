module PyMathTranslate

using PyMathConstants
using PyMathLogarithmic
using PyMathSpecial
using PyMathTheoretic
using PyMathTrigonometric

@inline function run(file::Array{String,1})
    PyMathConstants.run(file)
    PyMathLogarithmic.run(file)
    PyMathSpecial.run(file)
    PyMathTheoretic.run(file)
    PyMathTrigonometric.run(file)
end
export run

end
