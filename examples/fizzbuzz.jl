import PyCall
numpy = PyCall.pyimport("numpy")

function fizzbuzz(num)
    for i in 1:num
        if (i%15 == 0)
	    println("fizzbuzz")
        elseif (i%5 == 0)
	    println("buzz")
        elseif (i%3 == 0)
	    println("fizz")
        else
	    println(i)

fizzbuzz(100) 
