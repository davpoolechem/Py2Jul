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
        if (occursin(r"[\w]+\.empty(.*)",file[i]))
            numbers = GetElements.get_elements(r"[\w]+\.empty(.*)",file[i])

            first_dim = numbers[1]
            second_dim = numbers[2]
            file[i] = replace(file[i],r"[\w]+\.empty(.*)" => "fill(undef,($first_dim,$second_dim))")
        end
    end
end

function translate_empty_like(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"[\w]+\.empty_like(.*)",file[i]))
            numbers = GetElements.get_elements(r"[\w]+\.empty_like(.*)",file[i])

            array = numbers[1]
            file[i] = replace(file[i],r"[\w]+\.empty_like(.*)" => "fill(undef,size($array)")
        end
    end
end

function translate_eye(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"[\w]+\.eye(.*)",file[i]))
            numbers = GetElements.get_elements(r"[\w]+\.eye(.*)",file[i])

            first_num = numbers[1]
            second_num = (length(numbers) > 1) ? numbers[2] : numbers[1]
            file[i] = replace(file[i],r"[\w]+\.eye(.*)" => "Matrix{Float64}(I,$first_num,$second_num)")
        end
    end
end

function translate_identity(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"[\w]+\.identity(.*)",file[i]))
            numbers = GetElements.get_elements(r"[\w]+\.identity(.*)",file[i])

            first_num = numbers[1]
            file[i] = replace(file[i],r"[\w]+\.identity(.*)" => "Matrix{Float64}(I,$first_num,$first_num)")
        end
    end
end

function translate_ones(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"[\w]+\.ones(.*)",file[i]))
            numbers = GetElements.get_elements(r"[\w]+\.ones(.*)",file[i])

            first_num = numbers[1]
            second_num = numbers[2]
            file[i] = replace(file[i],r"[\w]+\.ones(.*)" => "fill(1,($first_dim,$second_dim))")
        end
    end
end

function translate_ones_like(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"[\w]+\.ones_like(.*)",file[i]))
            numbers = GetElements.get_elements(r"[\w]+\.ones_like(.*)",file[i])

            array = numbers[1]
            file[i] = replace(file[i],r"[\w]+\.ones_like(.*)" => "fill(1,size($array)")
        end
    end
end

function translate_zeros(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"[\w]+\.zeros(.*)",file[i]))
            numbers = GetElements.get_elements(r"[\w]+\.zeros(.*)",file[i])

            first_num = numbers[1]
            second_num = numbers[2]
            file[i] = replace(file[i],r"[\w]+\.zeros(.*)" => "fill(0,($first_dim,$second_dim))")
        end
    end
end

function translate_zeros_like(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"[\w]+\.zeros_like(.*)",file[i]))
            numbers = GetElements.get_elements(r"[\w]+\.zeros_like(.*)",file[i])

            array = numbers[1]
            file[i] = replace(file[i],r"[\w]+\.zeros_like(.*)" => "fill(0,(size($array)[1],size($array)[2]))")
        end
    end
end

function translate_full(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"[\w]+\.full(.*)",file[i]))
            numbers = GetElements.get_elements(r"[\w]+\.full(.*)",file[i])

            first_dim = numbers[1]
            second_dim = numbers[2]
            number = numbers[3]
            file[i] = replace(file[i],r"[\w]+\.full(.*)" => "fill($number,($first_dim,$second_dim))")
        end
    end
end

function translate_full_like(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"[\w]+\.full_like(.*)",file[i]))
            numbers = GetElements.get_elements(r"[\w]+\.full_like(.*)",file[i])

            array = numbers[1]
            number = numbers[2]
            file[i] = replace(file[i],r"[\w]+\.full_like(.*)" => "fill($number,(size($array)[1],size($array)[2]))")
        end
    end
end

@inline function run(file::Array{String,1})
    translate_empty_like(file)
    translate_empty(file)
    translate_eye(file)
    translate_identity(file)
    translate_ones_like(file)
    translate_ones(file)
    translate_zeros_like(file)
    translate_zeros(file)
    translate_full_like(file)
    translate_full(file)
end
export run

end
