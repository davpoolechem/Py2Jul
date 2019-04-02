module BasicWork

#do basic function structure conversion
function basic_functions(file_array::Array{String,1})
    for i in 1:length(file_array)
        file_array[i] = replace(file_array[i],"def" => "function")
        file_array[i] = replace(file_array[i],":" => "")
        file_array[i] = replace(file_array[i],";" => "end")
    end
end

#conversions from pythontojulia.md
function python_to_julia(file_array::Array{String,1})
    for i in 1:length(file_array)
        file_array[i] = replace(file_array[i],"True" => "true")
        file_array[i] = replace(file_array[i],"False" => "false")
        file_array[i] = replace(file_array[i],"None" => "nothing")
        file_array[i] = replace(file_array[i],"type(" => "typeof(")
    end
end

#fix up issues with printing
function printing(file_array::Array{String,1})
    for i in 1:length(file_array)
        if (occursin("print ",file_array[i]))
            file_array[i] = replace(file_array[i],"print " => "println(")
            file_array[i] = file_array[i]*")"

            file_array[i] = replace(file_array[i],"print(" => "println(")
        end
    end
end

#other random fixes
function misc_work(file_array::Array{String,1})
    for i in 1:length(file_array)
        #file_array[i] = replace(file_array[i],"int(" => "Int64(")
        #file_array[i] = replace(file_array[i],"float(" => "Float64(")
    end
end

function run(file_array::Array{String,1})
    basic_functions(file_array)
    python_to_julia(file_array)
    printing(file_array)
    misc_work(file_array)
end
export run

end
