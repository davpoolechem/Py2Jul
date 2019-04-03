#import basic module_imports
Base.include(@__MODULE__,"BasicWork.jl")
Base.include(@__MODULE__,"ControlFlow.jl")
Base.include(@__MODULE__,"ModuleWork.jl")

#import mathematics modules
Base.include(@__MODULE__,"math/MathTranslate.jl")
Base.include(@__MODULE__,"numpy/NumpyTranslate.jl")
Base.include(@__MODULE__,"scipy/ScipyTranslate.jl")
