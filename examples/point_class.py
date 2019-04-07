from math import sqrt

class TwoDimPoint:
    x = 0 #member
    y = 0 #member

    def __init__(self,x_,y_):
        self.x = x_
        self.y = y_
    #endfxn

    def norm(self):
        norm = sqrt(self.x*self.x + self.y*self.y)
        return norm
    #endfxn
#endclass

class ThreeDimPoint(TwoDimPoint):
    z = 0 #member

    def __init__(self,x_,y_,z_):
        self.x = x_
        self.y = y_
        self.z = z_
    #endfxn

    def norm(self):
        norm = sqrt(self.x*self.x + self.y*self.y + self.z*self.z)
        return norm
    #endfxn
#endclass

point = ThreeDimPoint(1,2,3)
#print(point.x)
print(point.norm())
