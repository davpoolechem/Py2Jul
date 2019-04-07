module ClassWork

function remove_classes(file::Array{String,1})
    for i in 1:length(file)
        if (occursin(r"class (.*):",file[i]))
            regex = match(r"class (.*):",file[i])
            class_name = regex[1]

            class_start::Int64 = i
            class_end::Int64 = i
            while(!occursin("#endclass",file[class_end]))
                class_end += 1
            end

            #do cleanup related to init and self references
            file[class_start:class_end] = constructor_cleanup(file[class_start:class_end], class_name)

            #for i in 1:length(file)
                #replace class construction with constructor function
            #    if(occursin("$class_name"*"(",file[i]))
            #        file[i] = replace(file[i],"$class_name"*"(" => "$class_name"*"Constructor(")
            #    end
            #end

            #extract member variables into a separate structure
            extract_member_variables(file[class_start:class_end], class_name)

            #get rid of class bounds
            for line in class_start:class_end
                file[line] = ""
            end
            file[class_start] = "Base.include(@__MODULE__,\"$class_name.jl\")"
        end
    end
end

function constructor_cleanup(file::Array{String,1}, class_name)
    #cleanup references to self and init
    for i in 1:length(file)
        file[i] = replace(file[i],"(self)" => "()")
        file[i] = replace(file[i],"(self," => "(")

        if(occursin("__init__",file[i]))
            file[i] = replace(file[i],"__init__" => "$class_name"*"Constructor")
        end
    end

    return file
end

function extract_member_variables(file::Array{String,1}, class_name)
    f_class = open("$class_name.jl","w")
        write(f_class,"mutable struct $class_name\n")

        for i in 1:length(file)
            if(occursin("#member", file[i]))
                write(f_class,file[i]*"\n")
                file[i] = replace(file[i], "#member" => "")
            end
        end

        write(f_class,"end\n")
    close(f_class)
end


@inline function run(file::Array{String,1})
    remove_classes(file)
end
export run

end
