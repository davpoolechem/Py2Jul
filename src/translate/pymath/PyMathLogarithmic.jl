module PyMathLogarithmic

using GetElements

function translate_logarithmic(file::Array{String,1},fxn::String)
    for i in 1:length(file)
        if (occursin("math.$fxn",file[i]))
            file[i] = replace(file[i],"math.$fxn" => "$fxn")
        end
    end
end

function translate_pow(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"math.pow(.*)",file[i]))
            numbers = GetElements.get_elements(r"math.pow(.*)",file[i])

            first_num = numbers[1]
            second_num = numbers[2]
            file[i] = replace(file[i],r"numpy.pow(.*)" => "$first_num^$second_num")
        end
    end
end

@inline function run(file::Array{String,1})
    translate_logarithmic(file,"exp")
    translate_logarithmic(file,"expm1")
    translate_logarithmic(file,"log")
    translate_logarithmic(file,"log1p")
    translate_logarithmic(file,"log2")
    translate_logarithmic(file,"log10")
    translate_pow(file)
    translate_logarithmic(file,"sqrt")
end
export run

end
