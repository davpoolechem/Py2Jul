Base.include(@__MODULE__, "../helpers/GetElements.jl")

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
module NumpyMatrices

using Main.GetElements

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

function translate_zeros_ones(file::Array{String,1})
    for i in 1:length(file)
        if (occursin("numpy.zeros",file[i]))
            file[i] = replace(file[i],"numpy.zeros" => "zeros")
            file[i] = replace(file[i],"((" => "(")
            file[i] = replace(file[i],"))" => ")")
        end

        if (occursin("numpy.ones",file[i]))
            file[i] = replace(file[i],"numpy.ones" => "ones")
            file[i] = replace(file[i],"((" => "(")
            file[i] = replace(file[i],"))" => ")")
        end
    end
end

function translate_matrix_full(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"numpy.full(.*)",file[i]))
            regex::RegexMatch = match(r"numpy.full(.*)",file[i])

            first_dim, second_dim, number = GetElements.three(regex[1])
            first_dim = first_dim[2:end]
            second_dim = first_dim[1:end]

            file[i] = replace(file[i],r"numpy.full(.*)" => "fill($number,($first_dim,$second_dim))")
        end
    end
end

function translate_matrix_eye(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"numpy.eye(.*)",file[i]))
            regex = match(r"numpy.eye(.*)",file[i])

            first_num = 0
            second_num = 0
            if (occursin(",",regex[1]) == false)
                first_num = GetElements.one(regex[1])
                second_num = first_num
            else
                first_num, second_num = GetElements.two(regex[1])
            end

            file[i] = replace(file[i],r"numpy.eye(.*)" => "Matrix{Float64}(I,$first_num,$second_num)")
        end
    end
end

@inline function run(file::Array{String,1})
    translate_array(file)
    translate_zeros_ones(file)
    translate_matrix_full(file)
    translate_matrix_eye(file)
end
export run

end
