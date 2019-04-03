"""
    module ModuleWork

Summary
========
Contains functions which reformat Python module imports to use PyCall.jl syntax

Functions
==========
module imports = reformat "import module" statements to use PyCall syntax

add pycall = add "import PyCall" to beginning of file

run (exported) = execute all aforementioned functions
"""
module ModuleWork

#copy straight module imports
function module_imports(file::Array{String,1})
    for i in 1:length(file)
        if (occursin("import ",file[i]))
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

#add LinearAlgebra if necessary
function add_linearalgebra(file::Array{String,1})
    need_LinearAlgebra::Bool = false
    for i in 1:length(file)
        need_LinearAlgebra = need_LinearAlgebra || occursin("LinearAlgebra.",file[i])
        need_LinearAlgebra = need_LinearAlgebra || occursin("numpy = PyCall.pyimport(\"numpy\")",file[i])
        need_LinearAlgebra = need_LinearAlgebra || occursin("scipy = PyCall.pyimport(\"scipy\")",file[i])

    end

    if (need_LinearAlgebra)
        pushfirst!(file,"using LinearAlgebra")
    end

    #for i in 1:length(file)
    #    file[i] = replace(file[i],"numpy = PyCall.pyimport(\"numpy\")" => "")
    #    file[i] = replace(file[i],"scipy = PyCall.pyimport(\"scipy\")" => "")
    #    file[i] = replace(file[i],"math = PyCall.pyimport(\"math\")" => "")
    #end
end

#add SpecialFunctions if necessary
function add_specialfunctions(file::Array{String,1})
    need_SpecialFunctions::Bool = false
    for i in 1:length(file)
        need_SpecialFunctions = need_SpecialFunctions || occursin("SpecialFunctions.",file[i])
    end

    if (need_SpecialFunctions)
        pushfirst!(file,"import SpecialFunctions")
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

@inline function run(file::Array{String,1})
    module_imports(file)
    add_linearalgebra(file)
    add_specialfunctions(file)
    add_pycall(file)
end
export run

end
