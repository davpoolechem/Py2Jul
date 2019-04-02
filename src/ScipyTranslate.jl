module ScipyTranslate

function translate_scipy_functions(file_array::Array{String,1})
end

function translate_linalg_functions(file_array::Array{String,1})
    for i in 1:length(file_array)
        #Scipy.linalg.sqrtm
        if (occursin("linalg.sqrtm",file_array[i]))
            file_array[i] = replace(file_array[i],"linalg.sqrtm" => "LinearAlgebra.sqrt")

            if (occursin("scipy.",file_array[i]))
                file_array[i] = replace(file_array[i],"scipy." => "")
            end
        end
    end
end

function run(file_array::Array{String,1})
    translate_scipy_functions(file_array)
    translate_linalg_functions(file_array)
end
export run

end
