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
            extract_member_variables(file[class_start:class_end], class_name)

            #cleanup and extract functions into a separate file
            for i in 1:length(file[class_start:class_end])
                if (occursin(r"function (.*)",file[i]))
                    regex_fxn = match(r"function (.*)",file[i])
                    fxn_name = regex_fxn[1]
                    
                    fxn_start::Int64 = i
                    fxn_end::Int64 = i
                    while(!occursin("#endfxn",file[fxn_end]))
                        fxn_end += 1
                    end
                    extract_function(file[fxn_start:fxn_end], class_name)
                end
            end

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
    f_class::IOStream = open("$class_name"*"Variables.jl","w")
        write(f_class,"mutable struct $class_name\n")

        for i in 1:length(file)
            if(occursin("#member", file[i]))
                file[i] = replace(file[i], "#member" => "")
                file[i] = replace(file[i], r"=(.*)" => "")
                write(f_class,file[i]*"\n")
            end
        end

        write(f_class,"end\n")
    close(f_class)
end

function extract_function(file::Array{String,1}, class_name)
    f_class::IOStream = open("$class_name"*"Functions.jl","w")
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
            write(f_class,file[i]*"\n")
        end
    close(f_class)
end


@inline function run(file::Array{String,1})
    remove_classes(file)
end
export run

end
