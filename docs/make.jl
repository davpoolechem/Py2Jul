Base.include(@__MODULE__,"src/JuliaMakeAdds.jl")

using Documenter, Py2Jul, ModuleWork

makedocs(
    sitename="Py2Jul Documentation",
    modules = [Py2Jul,
               ModuleWork],
)
