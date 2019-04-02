def is_prime(num):
    prime = True 

    if num%2 == 0:
	prime = False
    else:
	for denominator in range(3,num-1,2):
	    if num%denominator == 0:
		prime = False
    
    if prime == True:
	print("This number is prime!")
    else:
	print("This number is not prime!")

is_prime(2147483647)
