Base.include(@__MODULE__,"src/JuliaDirectoryAdds.jl")

"""
    module Py2Jul

Contains the main function call by which the Py2Jul translation is
executed.
"""
module Py2Jul

using BasicWork
using ClassWork
using ControlFlow
using ModuleWork

using NumpyTranslate
using ScipyTranslate

using PyMathTranslate
using CmathTranslate
using RandomTranslate

"""
    run(filename_py::String)

Execute the core Py2Jul Python->Julia code translation algorithm. This function
inputs a path/to/python/file.py filename and outputs a path/to/python/file.jl
Julia file.
"""
function run(filename_py::String)
    #get simple filename for later use
    filename_regex = match(r"(.*).py",filename_py)
    filename = filename_regex[1]

    #copy python file to julia array object for manipulation
    f_py::IOStream = open(filename*".py")
        file::Array{String,1} = readlines(f_py)
    close(f_py)

    #do basic changes
    BasicWork.run(file)

    #handle control flow constructs
    ControlFlow.run(file)

    #translate scientific module constructs to julia constructs
    for i in 1:length(file)
        if (occursin("import numpy", file[i]))
            NumpyTranslate.run(file)
        end

        if (occursin("import scipy", file[i]))
            ScipyTranslate.run(file)
        end
    end

    #translate mathematic module constructs to julia constructs
    for i in 1:length(file)
        if (occursin("import cmath", file[i]))
            CmathTranslate.run(file)
        end

        if (occursin("import math", file[i]))
            PyMathTranslate.run(file)
        end

        if (occursin("import random", file[i]))
            RandomTranslate.run(file)
        end
    end

    #handle work involving module imports
    ModuleWork.run(file)

    #translate classes
    ClassWork.run(file)

    #final copy
    f_jl::IOStream = open(filename*".jl","w")
        for i in 1:length(file)
            write(f_jl,file[i]*"\n")
        end
    close(f_jl)
end

end
