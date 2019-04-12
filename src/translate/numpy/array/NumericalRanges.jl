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
module NumericalRanges

using GetElements

function translate_arange(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"[\w]+\.arange(.*)",file[i]))
            numbers = GetElements.get_elements(r"[\w]+\.arange(.*)",file[i])

            if (length(numbers) == 3)
                first = parse(Float64,numbers[1])
                second = parse(Float64,first)
                second_temp = second
                third_num = parse(Float64,numbers[3])

                while (second < parse(Float64,second_temp)) second += third_num end
                if (second == parse(Float64,second_temp)) second -= third_num end

                file[i] = replace(file[i], r"[\w]+\.arange(.*)"=>"collect($first"*":"*"$third"*":"*"$second)")
            elseif (length(numbers) == 2)
                first = parse(Float64,numbers[1])
                second = parse(Float64,first)
                second_temp = second

                while (second < parse(Float64,second_temp)) second += 1 end
                if (second == parse(Float64,second_temp)) second -= 1 end

                file[i] = replace(file[i], r"[\w]+\.arange(.*)"=>"collect($first"*":"*"$second)")
            elseif (length(numbers) == 1)
                second = parse(Float64,numbers[1])
                second_temp = second

                while (second < parse(Float64,second_temp)) second += 1 end
                if (second == parse(Float64,second_temp)) second -= 1 end

                file[i] = replace(file[i], r"[\w]+\.arange(.*)"=>"collect(0"*":"*"$second)")
            end
        end
    end
end

function translate_linspace(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"[\w]+\.linspace(.*)",file[i]))
            numbers = GetElements.get_elements(r"[\w]+\.linspace(.*)",file[i])

            first_num = 0
            second_num = 0
            num = 50
            if (length(numbers) == 3)
                first_num = parse(Float64,numbers[1])
                second_num = parse(Float64,numbers[2])
                num = parse(Float64,numbers[3])
            elseif (length(numbers) == 2)
                first_num = parse(Float64,numbers[1])
                second_num = parse(Float64,numbers[2])
            end
            step = (second_num-first_num)/(num-1)

            file[i] = replace(file[i], r"[\w]+\.linspace(.*)"=>"collect($first:$step:$second)")
        end
    end
end

@inline function run(file::Array{String,1})
    translate_arange(file)
    translate_linspace(file)
end
export run

end
