"""
    module NumpyMatrices

Summary
========
Contains functions which convert NumPy functionalities to
Julia functionalities.

Functions
==========
translate array = translates numpy array creation

translate matrix = translates numpy functions for creation of specialized matrices

run (exported) = execute all aforementioned functions
"""
module RandomData

include("../../../helpers/GetElements.jl")
using .GetElements

function translate_rand(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"[\w+]\.rand(.*)",file[i]))
            numbers = GetElements.get_elements(r"[\w+]\.rand(.*)",file[i])

            first = numbers[1]
            first = numbers[2]
            file[i] = replace(file[i],r"[\w+]\.rand\(.*\)" => "rand($first:$second)")
        end
    end
end

@inline function run(file::Array{String,1})
    translate_rand(file)
end
export run

end
