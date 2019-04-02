module ModuleWork

#copy straight module imports
function module_imports(file::Array{String,1})
    for i in 1:length(file)
        if (occursin("import numpy",file[i]))
            for i in 1:length(file)
                if (!occursin("import LinearAlgebra",file[i]))
                    file[i] = replace(file[i],"import numpy" => "import LinearAlgebra")
                else
                    file[i] = replace(file[i],"import numpy" => "")
                end
            end
        elseif (occursin("import scipy",file[i]))
            for i in 1:length(file)
                if (!occursin("import scipy",file[i]))
                    file[i] = replace(file[i],"import scipy" => "import LinearAlgebra")
                else
                    file[i] = replace(file[i],"import scipy" => "")
                end
            end
        elseif (occursin("import linalg",file[i]))
            for i in 1:length(file)
                if (!occursin("import linalg",file[i]))
                    file[i] = replace(file[i],"import linalg" => "import LinearAlgebra")
                else
                    file[i] = replace(file[i],"import linalg" => "")
                end

                if (occursin(r"from.*",file[i]))
                    file[i] = replace(file[i],file[i] => "")
                end
            end
        elseif (occursin("import ",file[i]))
            #get rid of from module imports
            if (occursin(r"from.*",file[i]))
                first = 1
                last = findfirst("import",file[i])[1]-1
                file[i] = replace(file[i],file[i][first:last] => "")
            end

            file[i] = replace(file[i],"import " => "PyCall.pyimport(\"")
            file[i] = file[i]*"\")"

            first::Int64 = findfirst("(\"",file[i])[2]+1
            last::Int64 = findfirst("\")",file[i])[1]-1
            modulename::String = file[i][first:last]

            file[i] = modulename*" = "*file[i]
        end
    end
end

#add PyCall if necessary
function add_pycall(file::Array{String,1})
    need_PyCall::Bool = false
    for i in 1:length(file)
        need_PyCall = need_PyCall || occursin("pyimport",file[i])
    end

    if (need_PyCall)
        pushfirst!(file,"import PyCall")
    end
end

function run(file::Array{String,1})
    module_imports(file)
    add_pycall(file)
end
export run

end
