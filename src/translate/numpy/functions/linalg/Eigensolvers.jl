module Eigensolvers

function translate_eig(file::Array{String,1})
    for i in 1:length(file)
        if (occursin("numpy.linalg.eig",file[i]))
            file[i] = replace(file[i],"numpy.linalg.eig" => "eigvecs")
        end
    end
end

function translate_eigh(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"numpy.linalg.eigh\((.*)\)",file[i]))
            matrix = match(r"numpy.linalg.eigh\((.*)\)",file[i])[1]
            file[i] = replace(file[i],"numpy.linalg.eigh" => "eigvecs(LinearAlgebra.Symmetric($matrix))")
        end
    end
end

function translate_eigvals(file::Array{String,1})
    for i in 1:length(file)
        if (occursin("numpy.linalg.eigvals",file[i]))
            file[i] = replace(file[i],"numpy.linalg.eigvals" => "eigvals")
        end
    end
end

function translate_eigvalsh(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"numpy.linalg.eigvalsh\((.*)\)",file[i]))
            matrix = match(r"numpy.linalg.eigvalsh\((.*)\)",file[i])[1]
            file[i] = replace(file[i],"numpy.linalg.eigvalsh" => "eigvals(LinearAlgebra.Symmetric($matrix))")
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
