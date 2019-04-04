Base.include(@__MODULE__, "../../helpers/GetElements.jl")

module ForFloat

using Main.GetElements

function translate_random(file::Array{String,1},fxn::String)
    for i in 1:length(file)
        if (occursin("random.random()",file[i]))
            file[i] = replace(file[i],"random.random()" => "rand()")
        end
    end
end

function translate_uniform(file::Array{String,1},fxn::String)
    for i in 1:length(file)
        if (occursin(r"random.uniform(.*)",file[i]))
            regex = match(r"random.uniform(.*)",file[i])

            first_num, second_num = GetElements.two(regex[1])
            file[i] = replace(file[i],r"random.uniform(.*)" => "rand(Distributions.Uniform($first_num,$second_num))")
        end
    end
end


@inline function run(file::Array{String,1})
    translate_random(file,"exp")
    translate_uniform(file,"expm1")
end
export run

end
