module CmathLogarithmic

function translate_logarithmic(file::Array{String,1},fxn::String)
    for i in 1:length(file)
        if (occursin("cmath.$fxn",file[i]))
            file[i] = replace(file[i],"cmath.$fxn" => "$fxn")
        end
    end
end

@inline function run(file::Array{String,1})
    translate_logarithmic(file,"exp")
    translate_logarithmic(file,"log")
    translate_logarithmic(file,"log10")
    translate_logarithmic(file,"sqrt")
end
export run

end
