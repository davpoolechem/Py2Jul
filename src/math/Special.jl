module Special

function translate_special(file::Array{String,1},fxn::String)
    for i in 1:length(file)
        if (occursin("math.$fxn",file[i]))
            file[i] = replace(file[i],"math.$fxn" => "SpecialFunctions.$fxn")
        end
    end
end

@inline function run(file::Array{String,1})
    translate_special(file,erf)
    translate_special(file,erfc)
    translate_special(file,gamma)
    translate_special(file,lgamma)
end
export run

end
