#import basic module_imports
Base.include(@__MODULE__,"BasicWork.jl")
Base.include(@__MODULE__,"ControlFlow.jl")
Base.include(@__MODULE__,"ModuleWork.jl")

#import scientific modules
Base.include(@__MODULE__,"translate/numpy/NumpyTranslate.jl")
Base.include(@__MODULE__,"translate/scipy/ScipyTranslate.jl")

#import mathematics modules
Base.include(@__MODULE__,"translate/math/MathTranslate.jl")
Base.include(@__MODULE__,"translate/cmath/CmathTranslate.jl")
