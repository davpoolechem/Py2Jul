import PyCall
import Distributions
random = PyCall.pyimport("random")
math = PyCall.pyimport("math")

function norm(x,y)
    norm = sqrt(x*x + y*y)
    return norm
end

function monte_carlo_pi(points)
    points_pass = 0
    for i in 1:points
        x = rand(Distributions.Uniform(-0.5,0.5))
        y = rand(Distributions.Uniform(-0.5,0.5))
        norm_val = norm(x,y)

        if (norm_val <= 0.5)
            points_pass += 1
        end
    end

    pi = 4.0*points_pass/points
    println(pi)
end

monte_carlo_pi(10000000)
