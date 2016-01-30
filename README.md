# ruby_asteroids
A ruby asteroids clone

## Installation

Install gosu dependencies for your OS:
* https://github.com/gosu/gosu/wiki/Getting-Started-on-OS-X
* https://github.com/gosu/gosu/wiki/Getting-Started-on-Linux
* https://github.com/gosu/gosu/wiki/Getting-Started-on-Windows

```
gem build ruby_asteroids # not needed if hosted on rubygems.org
gem install ruby_asteroids
```

## Instructions:

Left/right arrow keys rotate the ship
Up/down arrow keys speed up / slow down the ship
Spacebar shoots bullets

## Futher Work

As you suggested, next step is to probably allow the asteroids to “float” in randomly assigned angles(edited)

so for each asteroid, give it an angle upon initialization and let it slowly float along that line

(wrapping at the screen edge)

another thing, turning seems fine now but the forward velocity of the ship is too fast for smooth action.

I guess if you very lightly tap it goes slow enough, but may want to tone that down a bit

so yeah… maybe just smaller step sizes will help with finer grained control over motion here.

And maybe a max speed that isn’t so fast it literally crashes Gosu

so say you have a radius 10, split it by rand(10) and whatever the remainder is

so you’d end up with like 6 and 4

or 7 and 3, etc.

After that, you probably can start feeling free to stop thinking on mechanics for a bit and focus just on decorating the game and making it more pleasant
graphics, sound, etc.

small tweaks based on playtesting

then if you want to try building an executable, i don’t really know the best way to do that (could certainly just install the gem, but a real executable would be nicer for sure)

This will all happen after this event though, because we’re basically down to the last moments here.

make a video of it if you can’t easily distribute it

this way you can at least show it to someone alongside the code
