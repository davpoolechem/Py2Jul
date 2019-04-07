"""
    module BasicWork

Summary
========
Contains functions which handle basic, general reformatting of code

Functions
==========
basic_functions = reformat function declarations

python_to_julia = general changes inspired by https://gist.github.com/svaksha/bf2b287e85967dcaad03a26d8b1e523d

printing = reformat print statements

misc_work = miscallaneous changes

run (exported) = execute all aforementioned functions
"""
module Initialize

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
        end

        file[i] = replace(file[i],"print(" => "println(")
    end
end

#replace python typecasts with Julia typecasts
function typecast_fixes(file::Array{String,1})
    for i in 1:length(file)
        file[i] = replace(file[i],"float(" => "Float64(")

        if (occursin("int(",file[i]) && !occursin(r"[\w]int\(",file[i]))
            file[i] = replace(file[i],"int(" => "Int64(")
        end
    end
end

@inline function run(file::Array{String,1})
    basic_functions(file)
    python_to_julia(file)
    printing(file)
    typecast_fixes(file)
end
export run

end
