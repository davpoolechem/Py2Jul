module Decompositions

using GetElements

function translate_cholesky(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"[\w]+\.cholesky(.*)",file[i]))
            matrix_temp = GetElements.get_elements(r"[\w]+\.cholesky(.*)",file[i])

            matrix = matrix_temp[1]
            file[i] = replace(file[i],r"[\w]+\.cholesky" => "LinearAlgebra.cholesky")
        end
    end
end

function translate_qr(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"[\w]+\.qr(.*)",file[i]))
            matrix_temp = GetElements.get_elements(r"[\w]+\.qr(.*)",file[i])

            matrix = matrix_temp[1]
            file[i] = replace(file[i],r"[\w]+\.qr" => "LinearAlgebra.qr")
        end
    end
end

function translate_svd(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"[\w]+\.svd(.*)",file[i]))
            matrix_temp = GetElements.get_elements(r"[\w]+\.svd(.*)",file[i])

            matrix = matrix_temp[1]
            file[i] = replace(file[i],r"[\w]+\.svd" => "LinearAlgebra.svd")
        end
    end
end

@inline function run(file::Array{String,1})
    translate_cholesky(file)
    translate_qr(file)
    translate_svd(file)
end
export run

end
