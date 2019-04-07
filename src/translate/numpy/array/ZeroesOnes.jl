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
module ZeroesOnes

using GetElements

function translate_empty(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"numpy.empty(.*)",file[i]))
            regex::RegexMatch = match(r"numpy.empty(.*)",file[i])

            first_dim, second_dim = GetElements.two(regex[1])
            first_dim = first_dim[2:end]
            second_dim = first_dim[1:end]

            file[i] = replace(file[i],r"numpy.empty(.*)" => "fill(undef,($first_dim,$second_dim))")
        end
    end
end

function translate_empty_like(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"numpy.empty_like(.*)",file[i]))
            regex = match(r"numpy.empty_like(.*)",file[i])

            array = GetElements.one(regex[1])

            file[i] = replace(file[i],r"numpy.empty_like(.*)" => "fill(undef,(size($array)[1],size($array)[2]))")
        end
    end
end

function translate_eye(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"numpy.eye(.*)",file[i]))
            regex = match(r"numpy.eye(.*)",file[i])

            first_num = 0
            second_num = 0
            if (occursin(",",regex[1]) == false)
                first_num = GetElements.one(regex[1])
                second_num = first_num
            else
                first_num, second_num = GetElements.two(regex[1])
            end

            file[i] = replace(file[i],r"numpy.eye(.*)" => "Matrix{Float64}(I,$first_num,$second_num)")
        end
    end
end

function translate_identity(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"numpy.identity(.*)",file[i]))
            regex = match(r"numpy.identity(.*)",file[i])

            first_num = GetElements.one(regex[1])
            file[i] = replace(file[i],r"numpy.identity(.*)" => "Matrix{Float64}(I,$first_num,$first_num)")
        end
    end
end

function translate_ones(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"numpy.ones(.*)",file[i]))
            regex::RegexMatch = match(r"numpy.ones(.*)",file[i])

            first_dim, second_dim = GetElements.two(regex[1])
            first_dim = first_dim[2:end]
            second_dim = first_dim[1:end]

            file[i] = replace(file[i],r"numpy.ones(.*)" => "fill(1,($first_dim,$second_dim))")
        end
    end
end

function translate_ones_like(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"numpy.ones_like(.*)",file[i]))
            regex = match(r"numpy.ones_like(.*)",file[i])

            array = GetElements.one(regex[1])

            file[i] = replace(file[i],r"numpy.ones_like(.*)" => "fill(1,(size($array)[1],size($array)[2]))")
        end
    end
end

function translate_zeros(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"numpy.zeros(.*)",file[i]))
            regex::RegexMatch = match(r"numpy.zeros(.*)",file[i])

            first_dim, second_dim = GetElements.two(regex[1])
            first_dim = first_dim[2:end]
            second_dim = first_dim[1:end]

            file[i] = replace(file[i],r"numpy.zeros(.*)" => "fill(0,($first_dim,$second_dim))")
        end
    end
end

function translate_zeros_like(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"numpy.zeros_like(.*)",file[i]))
            regex = match(r"numpy.zeros_like(.*)",file[i])

            array = GetElements.one(regex[1])

            file[i] = replace(file[i],r"numpy.zeros_like(.*)" => "fill(0,(size($array)[1],size($array)[2]))")
        end
    end
end

function translate_full(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"numpy.full(.*)",file[i]))
            regex::RegexMatch = match(r"numpy.full(.*)",file[i])

            first_dim, second_dim, number = GetElements.three(regex[1])
            first_dim = first_dim[2:end]
            second_dim = first_dim[1:end]

            file[i] = replace(file[i],r"numpy.full(.*)" => "fill($number,($first_dim,$second_dim))")
        end
    end
end

function translate_full_like(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"numpy.full_like(.*)",file[i]))
            regex = match(r"numpy.full_like(.*)",file[i])

            array, number = GetElements.two(regex[1])
            number = first_dim[1:end]

            file[i] = replace(file[i],r"numpy.full_like(.*)" => "fill($number,(size($array)[1],size($array)[2]))")
        end
    end
end

@inline function run(file::Array{String,1})
    translate_empty(file)
    translate_empty_like(file)
    translate_eye(file)
    translate_identity(file)
    translate_ones(file)
    translate_ones_like(file)
    translate_zeros(file)
    translate_zeros_like(file)
    translate_full(file)
    translate_full_like(file)
end
export run

end
