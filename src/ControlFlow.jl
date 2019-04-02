module ControlFlow

#fix up issues with for loops
function for_loops(file_array::Array{String,1})
    for i in 1:length(file_array)
        if (occursin(r"range(.*,.*)",file_array[i]) || occursin(r"range(.*,.*,.*)",file_array[i]))
            file_array[i] = replace(file_array[i],"range(" => "")
            file_array[i] = replace(file_array[i],"," => ":")
            file_array[i] = replace(file_array[i],")" => "")
        end
    end
end

#fix up issues with if loops
function if_loops(file_array::Array{String,1})
    for i in 1:length(file_array)
        file_array[i] = replace(file_array[i],"elif" => "elseif")
        if (occursin("if ",file_array[i]))
            file_array[i] = replace(file_array[i],"if " => "if (")
            file_array[i] = file_array[i]*")"

            file_array[i] = replace(file_array[i],"and " => "&&")
            file_array[i] = replace(file_array[i],"or" => "||")
        end
    end
end

#fix up issues with while loops
function while_loops(file_array::Array{String,1})
    for i in 1:length(file_array)
        if (occursin("while ",file_array[i]))
            file_array[i] = replace(file_array[i],"while " => "while (")
            file_array[i] = file_array[i]*")"

            file_array[i] = replace(file_array[i],"and " => "&&")
            file_array[i] = replace(file_array[i],"or" => "||")
        end
    end
end

function run(file_array::Array{String,1})
    for_loops(file_array)
    if_loops(file_array)
    while_loops(file_array)
end
export run

end
