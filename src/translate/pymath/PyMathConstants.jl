module PyMathConstants

function translate_pi(file::Array{String,1})
    for i in 1:length(file)
        if (occursin("math.pi",file[i]))
            file[i] = replace(file[i],"math.pi" => "π")
        end
    end
end

function translate_e(file::Array{String,1})
    for i in 1:length(file)
        if (occursin("math.e",file[i]))
            file[i] = replace(file[i],"math.e" => "ℯ")
        end
    end
end

function translate_tau(file::Array{String,1})
    for i in 1:length(file)
        if (occursin("math.tau",file[i]))
            file[i] = replace(file[i],"math.tau" => "2π")
        end
    end
end

function translate_inf(file::Array{String,1})
    for i in 1:length(file)
        if (occursin("math.inf",file[i]))
            file[i] = replace(file[i],"math.inf" => "Inf")
        end
    end
end

function translate_nan(file::Array{String,1})
    for i in 1:length(file)
        if (occursin("math.nan",file[i]))
            file[i] = replace(file[i],"math.nan" => "NaN")
        end
    end
end

@inline function run(file::Array{String,1})
    translate_pi(file)
    translate_e(file)
    translate_tau(file)
    translate_inf(file)
    translate_nan(file)
end
export run


end
