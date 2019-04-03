Base.include(@__MODULE__,"NumpyFunctions.jl")
Base.include(@__MODULE__,"NumpyMatrices.jl")

module NumpyTranslate

    using Main.NumpyFunctions
    using Main.NumpyMatrices

    function run(file::Array{String,1})
        NumpyFunctions.run(file)
        NumpyMatrices.run(file)
    end
    export run

end
