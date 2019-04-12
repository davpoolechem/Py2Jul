module Products

function translate_dot(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"[\w]+\.dot(.*)",file[i]))
            matrix_temp = GetElements.get_elements(r"[\w]+\.dot(.*)",file[i])

            matrix = matrix_temp[1]
            file[i] = replace(file[i],r"[\w]+\.dot" => "LinearAlgebra.dot")
        end
    end
end

#note that vdot is translated to dot here
function translate_vdot(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"[\w]+\.vdot(.*)",file[i]))
            matrix_temp = GetElements.get_elements(r"[\w]+\.vdot(.*)",file[i])

            matrix = matrix_temp[1]
            file[i] = replace(file[i],r"[\w]+\.vdot" => "LinearAlgebra.dot")
        end
    end
end

function translate_matmul(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"[\w]+\.matmul(.*)",file[i]))
            numbers = GetElements.get_elements(r"[\w]+\.matmul(.*)",file[i])

            matrix_a = numbers[1]
            matrix_b = numbers[2]
            file[i] = replace(file[i],r"[\w]+\.matmul(.*)" => "$matrix_a"*"*"*"$matrix_b")
        end
    end
end

function translate_matrix_power(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"[\w]+\.atrix_power(.*)",file[i]))
            numbers = GetElements.get_elements(r"[\w]+\.matrix_power(.*)",file[i])

            matrix = numbers[1]
            power = numbers[2]
            file[i] = replace(file[i],r"[\w]+\.matrix_power(.*)" => "$matrix^$power")
        end
    end
end

function translate_kron(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"[\w]+\.kron(.*)",file[i]))
            matrix_temp = GetElements.get_elements(r"[\w]+\.kron(.*)",file[i])

            matrix = matrix_temp[1]
            file[i] = replace(file[i],r"[\w]+\.kron" => "LinearAlgebra.dot")
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
