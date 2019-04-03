"""
    module NumpyFunctions

Summary
========
Contains functions which convert NumPy functionalities to
Julia functionalities.

Functions
==========
translate array = translates numpy array creation

translate matrix = translates numpy functions for creation of specialized matrices

translate numpy functions = translate numpy matrix/array functions

translate linalg functions = translate functions from the linalg submodule

run (exported) = execute all aforementioned functions
"""
module NumpyFunctions

function translate_numpy_functions(file::Array{String,1})
    for i in 1:length(file)
        #numpy.dot
        if (occursin("numpy.dot",file[i]))
            file[i] = replace(file[i],"numpy.dot" => "LinearAlgebra.dot")
        end

        #numpy.transpose
        if (occursin("numpy.transpose",file[i]))
            file[i] = replace(file[i],"numpy.transpose" => "transpose")
        end
    end
end

function translate_linalg_functions(file::Array{String,1})
    for i in 1:length(file)

        #numpy.linalg.inv
        if (occursin("linalg.inv",file[i]))
            file[i] = replace(file[i],"linalg.inv" => "LinearAlgebra.inv")

            if (occursin("numpy.",file[i]))
                file[i] = replace(file[i],"numpy." => "")
            end
        end
    end
end

@inline function run(file::Array{String,1})
    translate_numpy_functions(file)
    translate_linalg_functions(file)
end
export run

end
