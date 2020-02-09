from airfoil import airfoil
from meshsolv import meshgen , solver

camber = 0
position = 0
thickness = 12
AoA = 0
points = 1000

#airfoil(camber,position,thickness,AoA(degree),half_the_points_on_airfoil)
airfoil(camber,position,thickness,AoA,points)

# Input: airfoil data points
#meshgen()
# Output: cgns_unstr


# Input: cgns_unstr
#solver()
# Output: solution file along with multiple files.
