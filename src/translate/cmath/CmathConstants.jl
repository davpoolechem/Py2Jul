module CmathConstants

function translate_pi(file::Array{String,1})
    for i in 1:length(file)
        if (occursin("cmath.pi",file[i]))
            file[i] = replace(file[i],"cmath.pi" => "π")
        end
    end
end

function translate_e(file::Array{String,1})
    for i in 1:length(file)
        if (occursin("cmath.e",file[i]))
            file[i] = replace(file[i],"cmath.e" => "ℯ")
        end
    end
end

@inline function run(file::Array{String,1})
    translate_pi(file)
    translate_e(file)
end
export run


end
