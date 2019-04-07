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
module Finalize

#uncomment '#end' annotations
function uncomment_ends(file::Array{String,1})
    for i in 1:length(file)
        file[i] = replace(file[i],"#endfxn" => "end")
        file[i] = replace(file[i],"#end" => "end")
    end
end

@inline function run(file::Array{String,1})
    uncomment_ends(file)
end
export run

end
