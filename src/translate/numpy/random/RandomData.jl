"""
    module NumpyMatrices

Summary
========
Contains functions which convert NumPy functionalities to
Julia functionalities.

Functions
==========
translate array = translates numpy array creation

translate matrix = translates numpy functions for creation of specialized matrices

run (exported) = execute all aforementioned functions
"""
module RandomData

using GetElements

function translate_rand(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"[\w+]\.rand(.*)",file[i]))
            numbers = GetElements.get_elements(r"[\w+]\.rand(.*)",file[i])

            inputs = ""
            for j in 1:length(numbers)
                inputs *= numbers[j]
            end

            file[i] = replace(file[i],r"[\w+]\.rand\(.*\)" => "rand($inputs)")
        end
    end
end

function translate_randn(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"[\w+]\.randn(.*)",file[i]))
            numbers = GetElements.get_elements(r"[\w+]\.randn(.*)",file[i])

            inputs = ""
            for j in 1:length(numbers)
                inputs *= numbers[j]
            end

            file[i] = replace(file[i],r"[\w+]\.randn\(.*\)" => "randn($inputs)")
        end
    end
end

function translate_randint(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"[\w+]\.randint(.*)",file[i]))
            numbers = GetElements.get_elements(r"[\w+]\.randint(.*)",file[i])

            low = (length(numbers) == 1) ? 0 : numbers[1]
            high = (length(numbers) == 1) ? numbers[1] - 1 : numbers[2] - 1

            file[i] = replace(file[i],r"[\w+]\.randint\(.*\)" => "randn($low:$high)")
        end
    end
end

function translate_random_sample(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"[\w+]\.random_sample((.*)",file[i]))
            numbers = GetElements.get_elements(r"[\w+]\.random_sample((.*)",file[i])

            inputs = ""
            for j in 1:length(numbers)
                inputs *= numbers[j]
            end

            file[i] = replace(file[i],r"[\w+]\.random_sample(\(.*\)" => "rand($inputs)")
        end
    end
end



@inline function run(file::Array{String,1})
    translate_rand(file)
    translate_randn(file)
    translate_randint(file)
    #skip random_integers for now
    translate_random_sample(file)
    #skip random for now

end
export run

end
