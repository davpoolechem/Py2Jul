module ScipyTranslate

function translate_scipy_functions(file::Array{String,1})
end

function translate_linalg_functions(file::Array{String,1})
    for i in 1:length(file)
        #Scipy.linalg.sqrtm
        if (occursin("linalg.sqrtm",file[i]))
            file[i] = replace(file[i],"linalg.sqrtm" => "LinearAlgebra.sqrt")

            if (occursin("scipy.",file[i]))
                file[i] = replace(file[i],"scipy." => "")
            end
        end
    end
end

function run(file::Array{String,1})
    translate_scipy_functions(file)
    translate_linalg_functions(file)
end
export run

end
