module Trigonometric

function translate_trigonometric(file::Array{String,1},fxn::String)
    for i in 1:length(file)
        if (occursin("math.$fxn",file[i]))
            file[i] = replace(file[i],"numpy.$fxn" => "$fxn")
        end
    end
end

end
