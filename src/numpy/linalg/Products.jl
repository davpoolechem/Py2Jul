module Products

function translate_inv(file::Array{String,1})
    for i in 1:length(file)
        if (occursin("linalg.inv",file[i]))
            file[i] = replace(file[i],"linalg.inv" => "LinearAlgebra.inv")

            if (occursin("numpy.",file[i]))
                file[i] = replace(file[i],"numpy." => "")
            end
        end
    end
end

function translate_matrix_power(file::Array{String,1})
    if (occursin(r"numpy.linalg.matrix_power(.*)",file[i]))
        regex = match(r"numpy.linalg.matrix_power(.*)",file[i])

        matrix, power = GetElements.two(regex[1])
        file[i] = replace(file[i],r"numpy.linalg.matrix_power(.*)" => "$matrix^$power")
end
