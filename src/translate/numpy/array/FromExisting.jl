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
module FromExisting

using GetElements

function translate_array(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"\[.*\],",file[i]))
            file[i] = replace(file[i],"]," => "];")
            file[i] = replace(file[i],"," => " ")

            file[i] = replace(file[i],"[" => "")
            file[i] = replace(file[i],"]" => "")

            file[i] = replace(file[i],"numpy.array(" => "            [")
            file[i] = replace(file[i],")" => "]")
        end

        if (occursin(r"\[.*\]\]",file[i]))
            file[i] = replace(file[i],"," => " ")

            file[i] = replace(file[i],"[" => "")
            file[i] = replace(file[i],"]]" => "]")

            file[i] = replace(file[i],")" => "")
        end
    end
end

@inline function run(file::Array{String,1})
    translate_array(file)
end
export run

end
