module ClassWork

function remove_classes(file::Array{String,1})
    class_start::Int64 = 0
    class_end::Int64 = 0
    for i in 1:length(file)
        if (occursin(r"class (.*)",file[i]))
            regex_class = match(r"class (.*)",file[i])
            class_name = regex_class[1]

            class_start = i
            class_end = i
            while(!occursin("#endclass",file[class_end]))
                class_end += 1
            end

            #extract member variables into a separate structure
            member_variables = extract_member_variables(file[class_start:class_end], class_name)

            #cleanup and extract functions into a separate file
            member_fxns = [[]]
            fxn_index::Int64 = 1
            for i in 1:length(file[class_start:class_end])
                if (occursin(r"function (.*)",file[i]))
                    regex_fxn = match(r"function (.*)",file[i])
                    fxn_name = regex_fxn[1]

                    push!(member_fxns,[])
                    fxn_start::Int64 = i
                    fxn_end::Int64 = i
                    while(!occursin("#endfxn",file[fxn_end]))
                        fxn_end += 1
                    end

                    member_fxns[fxn_index] = extract_function(file[fxn_start:fxn_end], class_name)
                    fxn_index += 1
                end
            end

            #perform write to separate file
            f_class::IOStream = open("$class_name.jl","w")
                #member variables
                write(f_class,"mutable struct $class_name\n")

                for i in 1:length(member_variables)
                    write(f_class,member_variables[i]*"\n")
                end
                write(f_class,"end\n")
                write(f_class,"\n")

                #member functions
                for fxn in member_fxns
                    for i in 1:length(fxn)
                        write(f_class,fxn[i]*"\n")
                    end
                    write(f_class,"\n")
                end
            close(f_class)

            #get rid of class in original file
            for line in class_start:class_end
                file[line] = ""
            end
            file[class_start] = "Base.include(@__MODULE__,\"$class_name"*"Variables.jl\")"
            file[class_start+1] = "Base.include(@__MODULE__,\"$class_name"*"Functions.jl\")"
        end
    end
end

function extract_member_variables(file::Array{String,1}, class_name)
    member_variables = []
    for i in 1:length(file)
        if(occursin("#member", file[i]))
            file[i] = replace(file[i], "#member" => "")
            file[i] = replace(file[i], r"=(.*)" => "")
            push!(member_variables, file[i])
        end
    end

    return member_variables
end

function extract_function(file::Array{String,1}, class_name)

    member_fxns = []
    for i in 1:length(file)
        file[i] = replace(file[i],"(self)" => "()")
        file[i] = replace(file[i],"(self," => "(")
        file[i] = replace(file[i],"self." => "")

        #rename init if function is constructor
        if(occursin("__init__",file[i]))
            file[i] = replace(file[i],"__init__" => "$class_name"*"Constructor")
        end
        if(occursin("#endfxn",file[i]))
            file[i] = replace(file[i],"#endfxn" => "end")
        end

        push!(member_fxns, file[i])
    end

    return member_fxns
end


@inline function run(file::Array{String,1})
    remove_classes(file)
end
export run

end
