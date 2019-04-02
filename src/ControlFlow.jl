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

#fix up issues with for loops
function for_loops(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"range(.*,.*,.*)",file[i]))
            #swap second and third numbers
            sfirst::Int64 = findnext("(",file[i],1)[1]+1
            efirst::Int64 = findnext(",",file[i],sfirst)[1]-1

            ssec::Int64 = findnext(",",file[i],sfirst)[1]+1
            esec::Int64 = findnext(",",file[i],ssec)[1]-1

            sthird::Int64 = findnext(",",file[i],ssec)[1]+1
            ethird::Int64 = findnext(")",file[i],sthird)[1]-1

            first::String = file[i][sfirst:efirst]
            second::String = file[i][ssec:esec]
            third::String = file[i][sthird:ethird]

            file[i] = replace(file[i], r"range(.*,.*,.*)"=>"$first:$third:$second")
        elseif (occursin(r"range(.*,.*)",file[i]))
            file[i] = replace(file[i],"range(" => "")
            file[i] = replace(file[i],"," => ":")
            file[i] = replace(file[i],")" => "")
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

function run(file::Array{String,1})
    for_loops(file)
    if_loops(file)
    while_loops(file)
end
export run

end
