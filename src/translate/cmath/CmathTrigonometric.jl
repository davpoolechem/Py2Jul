module CmathTrigonometric

function translate_trigonometric(file::Array{String,1},fxn::String)
    for i in 1:length(file)
        if (occursin("cmath.$fxn",file[i]))
            file[i] = replace(file[i],"cmath.$fxn" => "$fxn")
        end
    end
end

@inline function run(file::Array{String,1})
    #trigonometric functions
    translate_trigonometric(file,"acos")
    translate_trigonometric(file,"asin")
    translate_trigonometric(file,"atan")
    #keep atan2 for now
    translate_trigonometric(file,"cos")
    translate_trigonometric(file,"sin")
    translate_trigonometric(file,"tan")

    #hyperbolic functions
    translate_trigonometric(file,"acosh")
    translate_trigonometric(file,"asinh")
    translate_trigonometric(file,"atanh")
    translate_trigonometric(file,"cosh")
    translate_trigonometric(file,"sinh")
    translate_trigonometric(file,"tanh")
end
export run


end
