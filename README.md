# ruby_asteroids
A ruby asteroids clone

Instructions:

Left/right arrow keys rotate the ship
Up/down arrow keys speed up / slow down the ship

x + r*cos(angle), y +  r*sin(angle)`

Something along those lines

Even just putting a dumb little dot there is fine for now, it doesn’t need to be aesthetically pleasing

A couple other things… turning feels really, really slow

so maybe you need to increase the step size you increment the angle by

There also seems to be something a little weird about where the bullets are originating from, which probably will be easier to notice with an indicator

I imagine that they should pass on a straight line that starts at the center of the ship and passes in a line out to the edge of the screen. You can project that out onto the outer border of the ship using the same method for positioning the “head"

actually, if you make your bullets fire from the head directly, that should do the trick

right now sometimes they’ll fire completely off the side of the ship, it seems

That I think is more than enough feedback for now, if you finished all of those you’d have something that started to feel like asteroids, and the rest would be about making it more detailed / fun
