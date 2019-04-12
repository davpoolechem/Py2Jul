"""
    module ModuleWork

Contains functions which reformat Python module imports to use PyCall.jl syntax
and clean up imports for modules being translated to Julia syntax.
"""
module ModuleReformat

"""
    module_imports(file::Array{String,1})

Replace "import module" with "module = "PyCall.pyimport(module)" for use with
PyCall.jl.
"""
function module_imports(file::Array{String,1})
    for i in 1:length(file)
        if (occursin("import ",file[i]))

            #properly handle "from a import b" module imports
            if (occursin(r"from (.*) import (.*)",file[i]))
                regex = match(r"from (.*) import (.*)",file[i])

                module_name = regex[1]
                function_name = regex[2]

                for i in 1:length(file)
                    if (occursin("$function_name(",file[i]))
                        file[i] = replace(file[i],"$function_name(" => "$module_name"*"."*"$function_name(")
                    end
                end

                file[i] = replace(file[i],"from $module_name import $function_name" => "import $module_name")
                file[i] = replace(file[i],"import $module_name" => "$module_name = PyCall.pyimport(\"$module_name\")")

            #properly handle "import a as b" module imports
            elseif (occursin(r"import (.*) as (.*)",file[i]))
                regex = match(r"import (.*) as (.*)",file[i])

                module_original = regex[1]
                module_name = regex[2]

                file[i] = replace(file[i],"import $module_original as $module_name" => "import $module_original")
                file[i] = replace(file[i],"import $module_original" => "$module_name = PyCall.pyimport(\"$module_original\")")

            #handle "import a" module imports
            elseif(occursin(r"import (.*)",file[i]))
                regex = match(r"import (.*)",file[i])
                module_name = regex[1]

                #handle "import a.b" module imports
                if (occursin(".",module_name))
                    regex_module = match(r"(\w+)\.(\w+)",module_name)

                    first = regex_module[1]
                    second = regex_module[2]
                    file[i] = replace(file[i],"import $module_name" => "$second = PyCall.pyimport(\"$first"*"."*"$second\")")

                    for j in 1:length(file)
                        if (occursin("$module_name.",file[j]))
                            file[j] = replace(file[j],"$module_name." => "$second.")
                        end
                    end
                #handle regular module imports
                else
                    file[i] = replace(file[i],"import $module_name" => "$module_name = PyCall.pyimport(\"$module_name\")")
                end
            end
        end
    end
end

"""
    run(file::Array{String,1})

Execute all functions in the ModuleWork module.
"""
@inline function run(file::Array{String,1})
    module_imports(file)
end
export run

end
