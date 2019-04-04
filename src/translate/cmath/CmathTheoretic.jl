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
module CmathTheoretic

function translate_theoretic(file::Array{String,1},fxn::String)
    for i in 1:length(file)
        if (occursin("cmath.$fxn",file[i]))
            file[i] = replace(file[i],"cmath.$fxn" => "$fxn")
        end
    end
end

@inline function run(file::Array{String,1})
    translate_theoretic(file,"isinf")
    translate_theoretic(file,"isnan")
end
export run

end
