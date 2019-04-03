Base.include(@__MODULE__,"ScipyFunctions.jl")
#Base.include(@__MODULE__,"ScipyMatrices.jl")

module ScipyTranslate

    using Main.ScipyFunctions
#    using Main.ScipyMatrices

    function run(file::Array{String,1})
        ScipyFunctions.run(file)
#        ScipyMatrices.run(file)
    end
    export run

end
