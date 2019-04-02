module ModuleWork

#copy straight module imports
function module_imports(file_array::Array{String,1})
    for i in 1:length(file_array)
        if (occursin("import numpy",file_array[i]))
            file_array[i] = replace(file_array[i],"import numpy" => "import LinearAlgebra")
        elseif (occursin("import ",file_array[i]))
            file_array[i] = replace(file_array[i],"import " => "PyCall.pyimport(\"")
            file_array[i] = file_array[i]*"\")"

            first::Int64 = findfirst("(\"",file_array[i])[2]+1
            last::Int64 = findfirst("\")",file_array[i])[1]-1
            modulename::String = file_array[i][first:last]

            file_array[i] = modulename*" = "*file_array[i]
        end
    end
end

#add PyCall if necessary
function add_pycall(file_array::Array{String,1})
    need_PyCall::Bool = false
    for i in 1:length(file_array)
        need_PyCall = need_PyCall || occursin("pyimport",file_array[i])
    end

    if (need_PyCall)
        pushfirst!(file_array,"import PyCall")
    end
end

function run(file_array::Array{String,1})
    module_imports(file_array)
    add_pycall(file_array)
end
export run

end