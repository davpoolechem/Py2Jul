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
        file_array::Array{String,1} = readlines(f_py)
    close(f_py)

    #do basic changes
    BasicWork.run(file_array)

    #handle control flow constructs
    ControlFlow.run(file_array)

    #handle work involving module imports
    ModuleWork.run(file_array)

    #translate scientific module constructs to julia constructs
    NumpyTranslate.run(file_array)
    ScipyTranslate.run(file_array)

    #final copy
    f_jl::IOStream = open(filename*".jl","w")
        for i in 1:length(file_array)
            write(f_jl,file_array[i]*"\n")
        end
    close(f_jl)
end

end

file = ARGS[1]
Py2Jul.run(file)
