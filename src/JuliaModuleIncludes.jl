#import basic module_imports
Base.include(@__MODULE__,"BasicWork.jl")
Base.include(@__MODULE__,"ControlFlow.jl")
Base.include(@__MODULE__,"ModuleWork.jl")

#import numpy modules
Base.include(@__MODULE__,"numpy/NumpyFunctions.jl")
Base.include(@__MODULE__,"numpy/NumpyMatrices.jl")

#import scipy modules
Base.include(@__MODULE__,"scipy/ScipyFunctions.jl")
