module BasicWork

#do basic function structure conversion
function basic_functions(file::Array{String,1})
    for i in 1:length(file)
        file[i] = replace(file[i],"def" => "function")
        file[i] = replace(file[i],":" => "")
        file[i] = replace(file[i],";" => "end")
    end
end

#conversions from pythontojulia.md
function python_to_julia(file::Array{String,1})
    for i in 1:length(file)
        file[i] = replace(file[i],"True" => "true")
        file[i] = replace(file[i],"False" => "false")
        file[i] = replace(file[i],"None" => "nothing")
        file[i] = replace(file[i],"type(" => "typeof(")
    end
end

#fix up issues with printing
function printing(file::Array{String,1})
    for i in 1:length(file)
        if (occursin("print ",file[i]))
            file[i] = replace(file[i],"print " => "println(")
            file[i] = file[i]*")"

            file[i] = replace(file[i],"print(" => "println(")
        end
    end
end

#other random fixes
function misc_work(file::Array{String,1})
    for i in 1:length(file)
        #file[i] = replace(file[i],"int(" => "Int64(")
        #file[i] = replace(file[i],"float(" => "Float64(")
    end
end

function run(file::Array{String,1})
    basic_functions(file)
    python_to_julia(file)
    printing(file)
    misc_work(file)
end
export run

end
