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
module Theoretic

function translate_theoretic(file::Array{String,1},fxn::String)
    for i in 1:length(file)
        if (occursin("math.$fxn",file[i]))
            file[i] = replace(file[i],"math.$fxn" => "$fxn")
        end
    end
end

function translate_fabs(file::Array{String,1},)
    for i in 1:length(file)
        if (occursin("math.fabs",file[i]))
            file[i] = replace(file[i],"math.fabs" => "abs")
        end
    end
end

function translate_isclose(file::Array{String,1},)
    for i in 1:length(file)
        if (occursin("math.isclose",file[i]))
            file[i] = replace(file[i],"math.isclose" => "isapprox")
        end
    end
end

function translate_remainder(file::Array{String,1},)
    for i in 1:length(file)
        if (occursin("math.remainder",file[i]))
            file[i] = replace(file[i],"math.remainder" => "rem")
        end
    end
end

@inline function run(file::Array{String,1})
    translate_theoretic(file,ceil)
    translate_theoretic(file,copysign)
    translate_abs(file)
    translate_theoretic(file,factorial)
    translate_theoretic(file,floor)
    #keep fmod for now
    translate_theoretic(file,frexp)
    #keep fsum for now
    translate_theoretic(file,gcd)
    translate_isclose(file)
    translate_theoretic(file,isfinite)
    translate_theoretic(file,isinf)
    translate_theoretic(file,isnan)
    translate_theoretic(file,ldexp)
    translate_theoretic(file,modf)
    translate_rem(file)
    translate_theoretic(file,trunc)
end
export run

end
