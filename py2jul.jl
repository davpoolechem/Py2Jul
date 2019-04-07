#Base.include(@__MODULE__,"src/JuliaDirectoryAdds.jl")
"""
    module Py2Jul

Summary
========
Contains core py2jul algorithm

Functions
==========

run = execute py2jul
"""
module Py2Jul

using BasicWork
using ClassWork
using ControlFlow
using ModuleReformat
using ModuleRemove

using NumpyTranslate
using ScipyTranslate

using PyMathTranslate
using CmathTranslate
using RandomTranslate

function run(filename_py::String)
    #get simple filename for later use
    filename_regex = match(r"(.*).py",filename_py)
    filename = filename_regex[1]

    #copy python file to julia array object for manipulation
    f_py::IOStream = open(filename*".py")
        file::Array{String,1} = readlines(f_py)
    close(f_py)

    #handle control flow constructs
    ControlFlow.run(file)

    #handle work involving module import reformatting
    ModuleReformat.run(file)

    #translate scientific module constructs to julia constructs
    for i in 1:length(file)
        if (occursin("pyimport(\"numpy\")", file[i]))
            NumpyTranslate.run(file)
        end

        if (occursin("pyimport(\"scipy\")", file[i]))
            ScipyTranslate.run(file)
        end
    end

    #translate mathematic module constructs to julia constructs
    for i in 1:length(file)
        if (occursin("pyimport(\"cmath\")", file[i]))
            CmathTranslate.run(file)
        end

        if (occursin("pyimport(\"math\")", file[i]))
            PyMathTranslate.run(file)
        end

        if (occursin("pyimport(\"random\")", file[i]))
            RandomTranslate.run(file)
        end
    end

    #handle work involving module import removal
    ModuleRemove.run(file)

    #translate classes
    #ClassWork.run(file)

    #final basic changes
    BasicWork.run(file)

    #final copy
    f_jl::IOStream = open(filename*".jl","w")
        for i in 1:length(file)
            write(f_jl,file[i]*"\n")
        end
    close(f_jl)
end

end
