module GetElements

function get_elements(regex::Regex, string::String)
    index = 1
    numbers = []
    while (match(regex,string,2*index)[1] != "")
        push!(numbers,match(regex,string,2*index)[1])
        index += 1
    end

    return numbers
end
export get_elements
#=
function one(regex::SubString{String})
    first_start::Int64 = 2
    first_end::Int64 = findnext(")",regex,first_start)[1]-1

    first_num = regex[first_start:first_end]

    return first_num
end
export one

function two(regex::SubString{String})
    first_start::Int64 = 2
    first_end::Int64 = findnext(",",regex,first_start)[1]-1

    second_start::Int64 = findnext(",",regex,first_start)[1]+1
    second_end::Int64 = findnext(")",regex,second_start)[1]-1

    first_num = regex[first_start:first_end]
    second_num = regex[second_start:second_end]

    return (first_num, second_num)
end
export two

function three(regex::SubString{String})
    first_start::Int64 = 2
    first_end::Int64 = findnext(",",regex,first_start)[1]-1

    second_start::Int64 = findnext(",",regex,first_start)[1]+1
    second_end::Int64 = findnext(",",regex,second_start)[1]-1

    third_start::Int64 = findnext(",",regex,second_start)[1]+1
    third_end::Int64 = findnext(")",regex,third_start)[1]-1

    first_num = regex[first_start:first_end]
    second_num = regex[second_start:second_end]
    third_num = regex[third_start:third_end]

    return (first_num, second_num, third_num)
end
export three
=#
end
