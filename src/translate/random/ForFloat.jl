module ForFloat

include("../../helpers/GetElements.jl")
using .GetElements

function translate_random(file::Array{String,1})
    for i in 1:length(file)
        if (occursin("random.random()",file[i]))
            file[i] = replace(file[i],"random.random()" => "rand()")
        end
    end
end

function translate_uniform(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"random.uniform(.*)",file[i]))
            numbers = GetElements.get_elements(r"random.uniform(.*)",file[i])

            first_num = numbers[1]
            second_num = numbers[2]
            file[i] = replace(file[i],r"random.uniform(.*)" => "rand(Distributions.Uniform($first_num,$second_num))")
        end
    end
end


@inline function run(file::Array{String,1})
    translate_random(file)
    translate_uniform(file)
end
export run

end
