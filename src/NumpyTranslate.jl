module NumpyTranslate

function translate_array(file_array::Array{String,1})
    for i in 1:length(file_array)
        if (occursin(r"\[.*\],",file_array[i]))
            file_array[i] = replace(file_array[i],"]," => "];")
            file_array[i] = replace(file_array[i],"," => " ")

            file_array[i] = replace(file_array[i],"[" => "")
            file_array[i] = replace(file_array[i],"]" => "")

            file_array[i] = replace(file_array[i],"numpy.array(" => "            [")
            file_array[i] = replace(file_array[i],")" => "]")
        end

        if (occursin(r"\[.*\]\]",file_array[i]))
            file_array[i] = replace(file_array[i],"," => " ")

            file_array[i] = replace(file_array[i],"[" => "")
            file_array[i] = replace(file_array[i],"]]" => "]")

            file_array[i] = replace(file_array[i],")" => "")
        end
    end
end

function translate_zeros_ones(file_array::Array{String,1})
    for i in 1:length(file_array)
        if (occursin("numpy.zeros",file_array[i]))
            file_array[i] = replace(file_array[i],"numpy.zeros" => "zeros")
            file_array[i] = replace(file_array[i],"((" => "(")
            file_array[i] = replace(file_array[i],"))" => ")")
        end

        if (occursin("numpy.ones",file_array[i]))
            file_array[i] = replace(file_array[i],"numpy.ones" => "ones")
            file_array[i] = replace(file_array[i],"((" => "(")
            file_array[i] = replace(file_array[i],"))" => ")")
        end
    end
end

function translate_numpy_functions(file_array::Array{String,1})
    for i in 1:length(file_array)
        #numpy.dot
        if (occursin("numpy.dot",file_array[i]))
            file_array[i] = replace(file_array[i],"numpy.dot" => "LinearAlgebra.dot")
        end

        #numpy.transpose
        if (occursin("numpy.transpose",file_array[i]))
            file_array[i] = replace(file_array[i],"numpy.transpose" => "transpose")
        end
    end
end

function translate_linalg_functions(file_array::Array{String,1})
    for i in 1:length(file_array)

        #numpy.linalg.inv
        if (occursin("linalg.inv",file_array[i]))
            file_array[i] = replace(file_array[i],"linalg.inv" => "LinearAlgebra.inv")

            if (occursin("numpy.",file_array[i]))
                file_array[i] = replace(file_array[i],"numpy." => "")
            end
        end
    end
end

function run(file_array::Array{String,1})
    translate_array(file_array)
    translate_zeros_ones(file_array)
    translate_numpy_functions(file_array)
    translate_linalg_functions(file_array)
end
export run

end
