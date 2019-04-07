module Products

function translate_dot(file::Array{String,1})
    for i in 1:length(file)
        if (occursin("numpy.dot",file[i]))
            file[i] = replace(file[i],"numpy.dot" => "LinearAlgebra.dot")
        end
    end
end

#note that vdot is translated to dot here
function translate_vdot(file::Array{String,1})
    for i in 1:length(file)
        if (occursin("numpy.vdot",file[i]))
            file[i] = replace(file[i],"numpy.vdot" => "LinearAlgebra.dot")
        end
    end
end

function translate_matmul(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"numpy.matmul(.*)",file[i]))
            regex = match(r"numpy.matmul(.*)",file[i])

            matrix_a, matrix_b = GetElements.two(regex[1])
            file[i] = replace(file[i],r"numpy.matmul(.*)" => "$matrix_a"*"*"*"$matrix_b")
        end
    end
end

function translate_matrix_power(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"numpy.linalg.matrix_power(.*)",file[i]))
            regex = match(r"numpy.linalg.matrix_power(.*)",file[i])

            matrix, power = GetElements.two(regex[1])
            file[i] = replace(file[i],r"numpy.linalg.matrix_power(.*)" => "$matrix^$power")
        end
    end
end

function translate_kron(file::Array{String,1})
    for i in 1:length(file)
        if (occursin("numpy.kron",file[i]))
            file[i] = replace(file[i],"numpy.kron" => "LinearAlgebra.kron")
        end
    end
end

#function translate_inv(file::Array{String,1})
#    for i in 1:length(file)
#        if (occursin("linalg.inv",file[i]))
#            file[i] = replace(file[i],"linalg.inv" => "LinearAlgebra.inv")
#
#            if (occursin("numpy.",file[i]))
#                file[i] = replace(file[i],"numpy." => "")
#            end
#        end
#    end
#end

@inline function run(file::Array{String,1})
    translate_dot(file)
    #ignore multi_dot for now
    translate_vdot(file)
    #ignore inner for now
    #ignore outer for now
    translate_matmul(file)
    #skip tensordot for now
    #skip einsum for now
    #skip einsum_path for now
    translate_matrix_power(file)
    translate_kron(file)
end
export run

end
