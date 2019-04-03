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
module NumpyMatrices

function translate_array(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"\[.*\],",file[i]))
            file[i] = replace(file[i],"]," => "];")
            file[i] = replace(file[i],"," => " ")

            file[i] = replace(file[i],"[" => "")
            file[i] = replace(file[i],"]" => "")

            file[i] = replace(file[i],"numpy.array(" => "            [")
            file[i] = replace(file[i],")" => "]")
        end

        if (occursin(r"\[.*\]\]",file[i]))
            file[i] = replace(file[i],"," => " ")

            file[i] = replace(file[i],"[" => "")
            file[i] = replace(file[i],"]]" => "]")

            file[i] = replace(file[i],")" => "")
        end
    end
end

function translate_matrix(file::Array{String,1})
    for i in 1:length(file)
        if (occursin("numpy.zeros",file[i]))
            file[i] = replace(file[i],"numpy.zeros" => "zeros")
            file[i] = replace(file[i],"((" => "(")
            file[i] = replace(file[i],"))" => ")")
        end

        if (occursin("numpy.ones",file[i]))
            file[i] = replace(file[i],"numpy.ones" => "ones")
            file[i] = replace(file[i],"((" => "(")
            file[i] = replace(file[i],"))" => ")")
        end

        if (occursin(r"numpy.full(.*)",file[i]))
            sfirst::Int64 = findnext("l",file[i],1)[1]+4
            efirst::Int64 = findnext(",",file[i],sfirst)[1]-1
            ssec::Int64 = efirst+2
            esec::Int64 = findnext(")",file[i],ssec)[1]-1

            first_dim::Int64 = parse(Int64,file[i][sfirst:efirst])
            second_dim::Int64 = parse(Int64,file[i][ssec:esec])
            dims::Tuple{Int64,Int64} = (first_dim, second_dim)

            number_start::Int64 = findnext(",",file[i],esec)[1]+1
            number_end::Int64= findnext(")",file[i],number_start)[1]-1
            number::String = file[i][number_start:number_end]

            file[i] = replace(file[i],r"numpy.full(.*)" => "fill($number,$dims)")
        end

        if (occursin(r"numpy.eye(.*)",file[i]))
            sfirst = findnext("e",file[i],1)[1]+4
            testing = findnext(",",file[i],sfirst)

            efirst = 0
            if (testing == nothing)
                efirst = findnext(")",file[i],sfirst)[1]-1
            else
                efirst = testing[1]-1
            end

            ssec = 0
            esec = 0
            if (testing == nothing)
                ssec = sfirst
                esec = efirst
            else
                ssec = efirst+2
                esec  = findnext(")",file[i],ssec)[1]-1
            end

            first_num::Int64 = parse(Int64,file[i][sfirst:efirst])
            second_num::Int64 = parse(Int64,file[i][ssec:esec])

            file[i] = replace(file[i],r"numpy.eye(.*)" => "Matrix{Float64}(I,$first_num,$second_num)")
        end
    end
end

@inline function run(file::Array{String,1})
    translate_array(file)
    translate_matrix(file)
end
export run

end
