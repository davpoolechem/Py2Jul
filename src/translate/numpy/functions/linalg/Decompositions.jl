module Decompositions

function translate_cholesky(file::Array{String,1})
    for i in 1:length(file)
        if (occursin("numpy.linalg.cholesky",file[i]))
            file[i] = replace(file[i],"numpy.cholesky" => "LinearAlgebra.cholesky")
        end
    end
end

function translate_qr(file::Array{String,1})
    for i in 1:length(file)
        if (occursin("numpy.linalg.qr",file[i]))
            file[i] = replace(file[i],"numpy.qr" => "LinearAlgebra.qr")
        end
    end
end

function translate_svd(file::Array{String,1})
    for i in 1:length(file)
        if (occursin("numpy.linalg.svd",file[i]))
            file[i] = replace(file[i],"numpy.linalg.svd" => "LinearAlgebra.svd")
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
