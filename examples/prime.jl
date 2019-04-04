function is_prime(num)
    prime = true

    if (num%2 == 0)
		prime = false
    else
		for denominator in 3:2:num-1
	    	if (num%denominator == 0)
				prime = false
			end
		end
	end

    if (prime == true)
		println("This number is prime!")
    else
		println("This number is not prime!")
	end
end
is_prime(2147483647)
