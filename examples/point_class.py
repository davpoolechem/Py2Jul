from math import sqrt

class Point:
    x = 0 #member
    y = 0 #member

    def __init__(self,x_,y_):
        self.x = x_
        self.y = y_
    #endfxn

    def norm(self):
        norm = (self.x*self.x + self.y*self.y)
        return norm
    #endfxn
#endclass

point = Point(1,2)
print(point.x)
print(point.norm())
