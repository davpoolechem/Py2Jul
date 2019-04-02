import numpy
import scipy
from scipy import linalg

a = numpy.ones((3,3))
print(a)

b = scipy.linalg.sqrtm(a)

print(b) 
