"""
    module ModuleWork

Contains functions which reformat Python module imports to use PyCall.jl syntax
and clean up imports for modules being translated to Julia syntax.
"""
module ModuleRemove
"""
    add_linearalgebra(file::Array{String,1})

Import LinearAlgebra Julia module if code requires it. This will generally be
the case if a scientific module such as NumPy or SciPy is used in the Python
code.
"""
function add_linearalgebra(file::Array{String,1})
    need_LinearAlgebra::Bool = false
    for i in 1:length(file)
        need_LinearAlgebra = need_LinearAlgebra || occursin("LinearAlgebra.",file[i])
        need_LinearAlgebra = need_LinearAlgebra || occursin(r"(.*) = PyCall.pyimport(\"numpy\")",file[i])
        need_LinearAlgebra = need_LinearAlgebra || occursin(r"(.*) = PyCall.pyimport(\"scipy\")",file[i])
    end

    if (need_LinearAlgebra)
        pushfirst!(file,"using LinearAlgebra")
    end
end

"""
    add_specialfunctions(file::Array{String,1})

Import SpecialFunctions Julia module if code requires it. This is required for
the translation of certain functions in the Python math module.
"""
function add_specialfunctions(file::Array{String,1})
    need_SpecialFunctions::Bool = false
    for i in 1:length(file)
        need_SpecialFunctions = need_SpecialFunctions || occursin("SpecialFunctions.",file[i])
    end

    if (need_SpecialFunctions)
        pushfirst!(file,"import SpecialFunctions")
    end
end

"""
    add_distributions(file::Array{String,1})

Import Distributions Julia module if code requires it. This will generally be
the case if random nnumber generator functions are used.
"""
function add_distributions(file::Array{String,1})
    need_Distributions::Bool = false
    for i in 1:length(file)
        need_Distributions = need_Distributions || occursin("Distributions.",file[i])
    end

    if (need_Distributions)
        pushfirst!(file,"import Distributions")
    end
end

"""
    add_pycall(file::Array{String,1})

Import PyCall Julia module if code requires it. This will be the case if other
Python modules, that haven't been translated to Julia functionalities, are used.
"""
function add_pycall(file::Array{String,1})
    need_PyCall::Bool = false
    for i in 1:length(file)
        need_PyCall = need_PyCall || occursin("pyimport",file[i])
    end

    if (need_PyCall)
        pushfirst!(file,"import PyCall")
    end
end

"""
    remove modules(file::Array{String,1})

Remove any unnecessary Python modules from the list.
"""
function remove_module(file::Array{String,1}, module_name::String)
    need_module::Bool = false

    for i in 1:length(file)
        need_module = need_module || occursin("$module_name"*".",file[i])
    end

    module_string = "\"$module_name\""
    for i in 1:length(file)
        if (!need_module && occursin("$module_name = PyCall.pyimport($module_string)", file[i]))
            file[i] = replace(file[i],"$module_name = PyCall.pyimport($module_string)" => "")
        end
    end
end

"""
    run(file::Array{String,1})

Execute all functions in the ModuleWork module.
"""
@inline function run(file::Array{String,1})
    add_linearalgebra(file)
    add_specialfunctions(file)
    add_distributions(file)

    remove_module(file,"numpy")
    remove_module(file,"scipy")
    remove_module(file,"cmath")
    remove_module(file,"math")
    remove_module(file,"random")

    add_pycall(file)
end
export run

end