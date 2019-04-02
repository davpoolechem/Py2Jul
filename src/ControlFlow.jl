module ControlFlow

#fix up issues with for loops
function for_loops(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"range(.*,.*)",file[i]) || occursin(r"range(.*,.*,.*)",file[i]))
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

            file[i] = replace(file[i],"and " => "&&")
            file[i] = replace(file[i],"or" => "||")
        end
    end
end

#fix up issues with while loops
function while_loops(file::Array{String,1})
    for i in 1:length(file)
        if (occursin("while ",file[i]))
            file[i] = replace(file[i],"while " => "while (")
            file[i] = file[i]*")"

            file[i] = replace(file[i],"and " => "&&")
            file[i] = replace(file[i],"or" => "||")
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
