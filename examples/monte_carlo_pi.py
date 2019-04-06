import numpy as np
from random import uniform
import math

def norm(x,y):
    norm = math.sqrt(x*x + y*y)
    return norm
#endfxn

def monte_carlo_pi(points):
    points_pass = 0
    for i in range(points):
        x = uniform(-0.5,0.5)
        y = uniform(-0.5,0.5)
        norm_val = norm(x,y)

        if norm_val <= 0.5:
            points_pass += 1
        #end
    #end

    pi = 4.0*points_pass/points
    print(pi)
#endfxn

monte_carlo_pi(10000000)
