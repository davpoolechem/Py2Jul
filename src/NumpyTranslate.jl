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

        if (occursin(r"numpy.full(.*)",file[i]))
            sfirst::Int64 = findnext("l",file[i],1)[1]+4
            efirst::Int64 = findnext(",",file[i],sfirst)[1]-1
            ssec::Int64 = efirst+2
            esec::Int64 = findnext(")",file[i],ssec)[1]-1

            first_dim::Int64 = parse(Int64,file[i][sfirst:efirst])
            second_dim::Int64 = parse(Int64,file[i][ssec:esec])
            dims::Tuple{Int64,Int64} = (first_dim, second_dim)

            number_start::Int64 = findnext(",",file[i],esec)[1]+1
            number_end::Int64= findnext(")",file[i],number_start)[1]-1
            number::Float64 = parse(Float64,file[i][number_start:number_end])

            file[i] = replace(file[i],r"numpy.full(.*)" => "fill($number,$dims)")
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
