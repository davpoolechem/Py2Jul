#Base.include(@__MODULE__,"helpers/GetElements.jl")

"""
    module ControlFlow

Summary
========
Contains functions which reformat for, if, and while loops to use Julia syntax

Functions
==========
for loops = reformat for loops

if loops = reformat if statements

while loops = reformat while loops

run (exported) = execute all aforementioned functions
"""
module ControlFlow

include("helpers/GetElements.jl")
using .GetElements

#fix up issues with for loops
function for_loops(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"range(.*)",file[i]))

            range_args = GetElements.get_elements(r"range(.*)",file[i])
            first = (length(range_args) > 1) ? range_args[1] : 1
            second = (length(range_args) >= 2) ? range_args[2] : range_args[1]
            third = (length(range_args) == 3) ? range_args[3] : 1

            file[i] = replace(file[i], r"range(.*)"=>"$first:$third:$second")
        end
    end
end

#fix up issues with if loops
function if_loops(file::Array{String,1})
    for i in 1:length(file)
        file[i] = replace(file[i],"elif" => "elseif")
        if (occursin("if ",file[i]))
            file[i] = replace(file[i],"if " => "if (")
            file[i] = file[i]*")"

            file[i] = replace(file[i]," and " => " && ")
            file[i] = replace(file[i]," or " => " || ")
        end
    end
end

#fix up issues with while loops
function while_loops(file::Array{String,1})
    for i in 1:length(file)
        if (occursin("while ",file[i]))
            file[i] = replace(file[i],"while " => "while (")
            file[i] = file[i]*")"

            file[i] = replace(file[i]," and " => " && ")
            file[i] = replace(file[i]," or " => " || ")
        end
    end
end

@inline function run(file::Array{String,1})
    for_loops(file)
    if_loops(file)
    while_loops(file)
end
export run

end
