module Eigensolvers

function translate_eig(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"[\w]+\.eig",file[i]))
            file[i] = replace(file[i],r"[\w]+\.eig" => "eigvecs")
        end
    end
end

function translate_eigh(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"[\w]+\.eigh\((.*)\)",file[i]))
            matrix = match(r"[\w]+\.eigh\((.*)\)",file[i])[1]
            file[i] = replace(file[i],"numpy.linalg.eigh" => "eigvecs(LinearAlgebra.Symmetric($matrix))")
        end
    end
end

function translate_eigvals(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"[\w]+\.eigvals",file[i]))
            file[i] = replace(file[i],r"[\w]+\.eigvals" => "eigvals")
        end
    end
end

function translate_eigvalsh(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"[\w]+\.eigvalsh\((.*)\)",file[i]))
            matrix = match(r"[\w]+\.eigvalsh\((.*)\)",file[i])[1]
            file[i] = replace(file[i],r"[\w]+\.eigvalsh" => "eigvals(LinearAlgebra.Symmetric($matrix))")
        end
    end
end

@inline function run(file::Array{String,1})
    translate_eig(file)
    translate_eigh(file)
    translate_eigvals(file)
    translate_eigvalsh(file)
end
export run

end
