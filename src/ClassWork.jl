module ClassWork

include("helpers/GetElements.jl")
using .GetElements

function remove_classes(file::Array{String,1})
    class_start::Int64 = 0
    class_end::Int64 = 0
    for i in 1:length(file)
        if (occursin(r"class (.*)",file[i]))
            class = GetElements.get_elements(r"class (.*)",file[i])
            class_name = class[1]
            base_name = ""

            class_start = i
            class_end = i
            while(!occursin("#endclass",file[class_end]))
                class_end += 1
            end

            #account for single inheritance
            if (occursin(r"class (.*)(\(.*\))",file[i]))
                class_inherit = GetElements.get_elements(r"class (.*)(\(.*\))",file[i])
                class_name= class_inherit[1]
                base_name = GetElements.one(regex_inherit[2])
            end

            #extract member variables into a separate structure
            member_variables = extract_member_variables(file[class_start:class_end],
                class_name, base_name)

            #cleanup and extract functions into a separate file
            member_fxns = extract_functions(file[class_start:class_end], class_name)

            #perform write to separate file
            write_class_file(class_name, base_name, member_variables, member_fxns)

            #get rid of class in original file
            for line in class_start:class_end
                file[line] = ""
            end
            file[class_start] = "Base.include(@__MODULE__,\"$class_name.jl\")"
        end
    end
end

function extract_member_variables(file::Array{String,1}, class_name, base_name)
    member_variables = []
    if (base_name != "")
        push!(member_variables, "$base_name"*"::"*"$base_name")
    end
    for i in 1:length(file)
        if(occursin("#member", file[i]))
            file[i] = replace(file[i], "#member" => "")
            file[i] = replace(file[i], r"=(.*)" => "")
            push!(member_variables, file[i])
        end
    end

    return member_variables
end

function extract_functions(file::Array{String,1}, class_name)
    member_fxns = [[]]
    fxn_index::Int64 = 1
    for i in 1:length(file)
        if (occursin(r"function (.*)",file[i]))
            fxn = GetElements.get_elements(r"function (.*)",file[i])
            fxn_name = fxn[1]

            push!(member_fxns,[])
            fxn_start::Int64 = i
            fxn_end::Int64 = i
            while(!occursin("#endfxn",file[fxn_end]))
                fxn_end += 1
            end

            for ifxn in file[fxn_start:fxn_end]
                #file[i] = replace(file[i],"(self" => "(self::$class_name")
                #file[i] = replace(file[i],"self." => "")

                #rename init if function is constructor
                if(occursin("__init__",ifxn))
                    ifxn = replace(ifxn,"__init__" => "$class_name"*"_Constructor")
                else
                    ifxn = replace(ifxn,"$fxn_name" => "$class_name"*"_"*"$fxn_name")
                end
                if(occursin("#endfxn",ifxn))
                    ifxn = replace(ifxn,"#endfxn" => "end")
                end

                push!(member_fxns[fxn_index], ifxn)
            end
            fxn_index += 1
        end
    end

    return member_fxns
end

function write_class_file(class_name, base_name, member_variables, member_fxns)
    f_class::IOStream = open("$class_name.jl","w")
        #account for inheritance
        if (base_name != "")
            write(f_class,"Base.include(@__MODULE__,\"$base_name.jl\")\n")
            write(f_class,"\n")
        end

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
end

@inline function run(file::Array{String,1})
    remove_classes(file)
end
export run

end
