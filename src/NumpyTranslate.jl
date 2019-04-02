module NumpyTranslate

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

function translate_matrix_make(file::Array{String,1})
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

        if (occursin("numpy.full(.*,.*)",file[i]))
            dim_first_start::Int64 = findfirst("(",file[1])
            file[i] = replace(file[i],"numpy.ones" => "ones")
            file[i] = replace(file[i],"((" => "(")
            file[i] = replace(file[i],"))" => ")")
        end
    end
end

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

function run(file::Array{String,1})
    translate_array(file)
    translate_matrix_make(file)
    translate_numpy_functions(file)
    translate_linalg_functions(file)
end
export run

end
