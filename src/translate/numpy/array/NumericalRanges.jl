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
        if (occursin(r"numpy.arange(.*,.*,.*)",file[i]))
            regex = match(r"numpy.arange(.*,.*,.*)",file[i])
            first, second_temp, third = GetElements.three(regex[1])

            second = parse(Float64,first)
            third_num = parse(Float64,third)
            while (second < parse(Float64,second_temp)) second += third_num end
            if (second == parse(Float64,second_temp)) second -= third_num end

            file[i] = replace(file[i], r"numpy.arange(.*,.*,.*)"=>"collect($first"*":"*"$third"*":"*"$second)")
        elseif (occursin(r"numpy.arange(.*,.*)",file[i]))
            regex = match(r"numpy.arange(.*,.*)",file[i])
            first, second_temp = GetElements.two(regex[1])

            second = parse(Float64,first)
            while (second < parse(Float64,second_temp)) second += 1 end
            if (second == parse(Float64,second_temp)) second -= 1 end

            file[i] = replace(file[i], r"numpy.arange(.*,.*)"=>"collect($first"*":"*"$second)")
        elseif (occursin(r"numpy.arange(.*)",file[i]))
            regex = match(r"numpy.arange(.*)",file[i])
            second_temp = GetElements.one(regex[1])

            second = 0
            while (second < parse(Float64,second_temp)) second += 1 end
            if (second == parse(Float64,second_temp)) second -= 1 end

            file[i] = replace(file[i], r"numpy.arange(.*)"=>"collect(0"*":"*"$second)")
        end
    end
end

function translate_linspace(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"numpy.linspace(.*,.*,.*)",file[i]))
            regex = match(r"numpy.linspace(.*,.*,.*)",file[i])
            first, second, num_string = GetElements.three(regex[1])

            first_num = parse(Float64,first)
            second_num = parse(Float64,second)

            regex_num = match(r"num=(.*)\)",file[i])
            num = parse(Float64,regex_num[1])

            step = (second_num-first_num)/(num-1)

            file[i] = replace(file[i], r"numpy.linspace(.*,.*)"=>"collect($first:$step:$second)")
        elseif (occursin(r"numpy.linspace(.*,.*)",file[i]))
            regex = match(r"numpy.linspace(.*,.*)",file[i])
            first, second = GetElements.two(regex[1])

            first_num = parse(Float64,first)
            second_num = parse(Float64,second)
            num = 50

            step = (second_num-first_num)/(num-1)

            file[i] = replace(file[i], r"numpy.linspace(.*,.*)"=>"collect($first:$step:$second)")
        end
    end
end

@inline function run(file::Array{String,1})
    translate_arange(file)
    translate_linspace(file)
end
export run

end
