module Numbers

function translate_norm(file::Array{String,1})
    for i in 1:length(file)
        if (occursin("numpy.linalg.norm",file[i]))
            file[i] = replace(file[i],"numpy.linalg.norm" => "LinearAlgebra.norm")
        end
    end
end

function translate_cond(file::Array{String,1})
    for i in 1:length(file)
        if (occursin("numpy.linalg.cond",file[i]))
            file[i] = replace(file[i],"numpy.linalg.cond" => "LinearAlgebra.cond")
        end
    end
end

function translate_det(file::Array{String,1})
    for i in 1:length(file)
        if (occursin("numpy.linalg.det",file[i]))
            file[i] = replace(file[i],"numpy.linalg.det" => "LinearAlgebra.det")
        end
    end
end

function translate_matrix_rank(file::Array{String,1})
    for i in 1:length(file)
        if (occursin("numpy.linalg.matrix_rank",file[i]))
            file[i] = replace(file[i],"numpy.linalg.matrix_rank" => "LinearAlgebra.rank")
        end
    end
end

function translate_trace(file::Array{String,1})
    for i in 1:length(file)
        if (occursin("numpy.linalg.trace",file[i]))
            file[i] = replace(file[i],"numpy.linalg.trace" => "LinearAlgebra.tr")
        end
    end
end

@inline function run(file::Array{String,1})
    translate_norm(file)
    translate_cond(file)
    translate_det(file)
    translate_matrix_rank(file)
    #ignore slogdet for now
    translate_trace(file)
end
export run

end
