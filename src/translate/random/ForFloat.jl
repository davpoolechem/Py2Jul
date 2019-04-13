module ForFloat

using GetElements

function translate_random(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"[\w+]\.random()",file[i]))
            file[i] = replace(file[i],r"[\w+]\.random()" => "rand()")
        end
    end
end

function translate_uniform(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"[\w+]\.uniform(.*)",file[i]))
            numbers = GetElements.get_elements(r"[\w+]\.uniform(.*)",file[i])

            first_num = numbers[1]
            second_num = numbers[2]
            file[i] = replace(file[i],r"[\w+]\.uniform(.*)" => "rand(Distributions.Uniform($first_num,$second_num))")
        end
    end
end

function translate_expovariate(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"[\w+]\.expovariate(.*)",file[i]))
            file[i] = replace(file[i],r"[\w+]\.expovariate(.*)" => "randexp(1.0)")
        end
    end
end


@inline function run(file::Array{String,1})
    translate_random(file)
    translate_uniform(file)
    translate_expovariate(file)
end
export run

end
