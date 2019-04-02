function is_prime(num::Int64)
    prime::Bool = true 

    if (num%2 == 0)
	prime = false
    else
	for denominator::Int64 in 3:2:num
	    if (num%denominator == 0)
		prime = false
	    end
	end
    end
    
    if (prime == true)
	print("This number is prime!")
    else
	print("This number is not prime!")
    end
end

is_prime(2147483647)
