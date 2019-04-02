Base.include(@__MODULE__,"src/JuliaModuleIncludes.jl")

module Py2Jul

using Main.ControlFlow
using Main.ModuleWork
using Main.BasicWork
using Main.NumpyTranslate
using Main.ScipyTranslate

function run(filename::String)

    #copy python file to julia array object for manipulation
    f_py::IOStream = open(filename*".py")
        file::Array{String,1} = readlines(f_py)
    close(f_py)

    #do basic changes
    BasicWork.run(file)

    #handle control flow constructs
    ControlFlow.run(file)

    #handle work involving module imports
    ModuleWork.run(file)

    #translate scientific module constructs to julia constructs
    NumpyTranslate.run(file)
    ScipyTranslate.run(file)

    #final copy
    f_jl::IOStream = open(filename*".jl","w")
        for i in 1:length(file)
            write(f_jl,file[i]*"\n")
        end
    close(f_jl)
end

end

file = ARGS[1]
Py2Jul.run(file)
