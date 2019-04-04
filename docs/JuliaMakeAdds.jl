#py2jul.jl
push!(LOAD_PATH,"../")

#basic module dirctories
push!(LOAD_PATH,"../src")
push!(LOAD_PATH,"../src/helpers")

#mathematics module translation dirctories
push!(LOAD_PATH,"../src/translate/cmath")
push!(LOAD_PATH,"../src/translate/pymath")
push!(LOAD_PATH,"../src/translate/random")

#scientific module translation dirctories
push!(LOAD_PATH,"../src/translate/numpy")
push!(LOAD_PATH,"../src/translate/numpy/array")
push!(LOAD_PATH,"../src/translate/numpy/functions")
push!(LOAD_PATH,"../src/translate/numpy/linalg")
push!(LOAD_PATH,"../src/translate/scipy")
