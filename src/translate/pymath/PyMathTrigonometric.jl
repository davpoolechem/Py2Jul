module PyMathTrigonometric

using GetElements

function translate_trigonometric(file::Array{String,1},fxn::String)
    for i in 1:length(file)
        if (occursin("math.$fxn",file[i]))
            file[i] = replace(file[i],"math.$fxn" => "$fxn")
        end
    end
end

function translate_degrees(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"math.degrees(.*)",file[i]))
            regex = match(r"math.degrees(.*)",file[i])

            radians = GetElements.one(regex[1])
            file[i] = replace(file[i],r"numpy.degrees(.*)" => "(360/(2π))*$radians")
        end
    end
end

function translate_radians(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"math.radians(.*)",file[i]))
            regex = match(r"math.radians(.*)",file[i])

            degrees = GetElements.one(regex[1])
            file[i] = replace(file[i],r"numpy.radians(.*)" => "(2π/360)*$degrees")
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
    translate_trigonometric(file,"hypot")
    translate_trigonometric(file,"sin")
    translate_trigonometric(file,"tan")

    #angular conversion
    translate_degrees(file)
    translate_radians(file)

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
