---
layout: post
title:  "The processing api"
date:   2015-09-28 06:24:13
permalink: /processing-api/
---

Unlike ruby-processing and JRubyArt, propane does not support `bare` sketches, all sketches must be class wrapped, and explicitly inherit from `Propane::App`. Further you must also `require 'propane'` in the sketch file, and initiate the sketch by creating a `new` instance. For convenience use `propane --create fred 200 200` to create an outline sketch to edit, and thus avoid entering a lot of boiler-plate code.

### The processing-api

Most of the processing methods, as explained in the [Processing Language API][processing], are available as instance methods on your Propane::App. (frame_rate, ellipse, and the 158 others.) This makes it easy as pie to use them within your sketch, but you should prefer snake case to camel case and there are some caveats. NB: you do need to explicitly create a [settings][settings] method in propane.

``` ruby
#!/usr/bin/env jruby
require 'propane'
# Triangles gone wild
class MySketch < Propane::App

  def settings
    size 200, 200
    smooth 8
  end

  def setup
    sketch_title 'Triangles Gone Wild' # propane & JRubyArt
    color_mode RGB, 1.0
    frame_rate 30
    fill 0.8, 0.6, 0.4
  end

  def draw
    triangle(rand(width), rand(height), rand(width), rand(height), rand(width), rand(height))
  end
end

MySketch.new
```
`#!/usr/bin/env jruby` allows the sketch to be run from atom with [script plugin][script] or `chmod +x my_sketch.rb` to create an executable script.

### Caveats

We do not directly support use of many processing `PApplet` static methods, since there are better `ruby` or `propane` alternatives. If you absolutely must use these methods, define a constant eg `Core` to stand for `PApplet` as follows:-

```ruby
Core = Java::ProcessingCore::PApplet
# allows you to use
val = Core.map(mouse_x, 0, width, 0, 10) # don't do it though
# use instead our custom propane method, that is more ruby like
val = map1d(mouse_x, 0..width, 0..10)
```
also if you absolutely must use `PVector` say a library demands it, define a const eg `Vect` as follows (avoid `Vector`):-

```ruby
Vect = Java::ProcessingCore::PVector
# allows you to create an instance
pvector = Vect.new
# but in general you should prefer Vec2D or Vec3D as more ruby like alternatives to PVector
```

Here are some the main differences moving from vanilla processing to ruby-processing:-

1. You do not declare types in ruby, eg use `vec = Vect.new` instead of `PVector vec = new PVector()` for example, however in this case you should use [Vec2D and Vec3D][vec], which are alternatives to `PVector` (but with methods that are much more ruby-like, and have extended functionality).

2. There are no void methods (what's evaluated gets returned without needing an explicit return)

3. Everything is an object (this includes primitive types float, integer etc cf. java) [see more][about]
4. Confusing for beginners and especially pythonistas there is often more than one way to do it

5. Processing makes heavy use of java `inner` classes (to make methods and values somewhat globally available) ruby-processing provides the `Propane::Proxy` mixin to somewhat mimic this behaviour see [Ball][ball]. An alternative to consider is to use delegator methods using `extend Forwardable`, requires `require 'forwardable'` see JRubyArt [example][].

6. Use `mouse_pressed?` and `key_pressed?` to access mouse_pressed and key_pressed as variables (ruby can't cope with overloading the `mouse_pressed` and `key_pressed` methods like java) [see example][mouse_pressed?].


In general you should try and code in regular ruby (in propane), only using processing short-cuts / methods when you need to (ie when ruby alternatives don't exist, many processing short-cuts just aren't needed in ruby). From 3. above you should use:-

* `a**b` for `pow(a, b)`
* `theta.degrees` for `degrees(theta)`
* `theta.radians` for `radians(theta)`
* `x.abs` for `abs(x)`
* `x.ceil` for `ceil(x)`
* `x.round` for `round(x)`
* `str.strip` for `trim(str)`
* `str.hex` for `hex(str)`
* `string.to_i(base=16)` for `unhex(str)`

Other ruby methods to prefer are:-

* `rand(x)` to `random(x)`
* `rand(lo..hi)` to `random(lo, hi)`
* `puts val` (or even just `p val`) to `println(val)`
* `map1d(val, (range1), (range2))` to `map(value, start1, stop1, start2, stop2)`
* `(lo..hi).clip(amt)` to `constrain(amt, lo, hi)` _it is how it is implemented_

To avoid confusion use with ruby `map` use `map1d` for processing `map` function see [example][map1d].

[script]:https://atom.io/packages/script
[about]:https://www.ruby-lang.org/en/about/
[vec]:https://ruby-processing.github.io/propane/classes.html
[ball]:https://github.com/ruby-processing/propane-examples/blob/master/contributed/circle_collision.rb
[example]:https://github.com/ruby-processing/propane-examples/blob/master/external_library/gem/toxiclibs/soft_body/library/blanket/lib/particle.rb
[processing]:https://processing.org/reference/
[map1d]:https://github.com/ruby-processing/propane-examples/blob/master/contributed/circles.rb
[mouse_pressed?]:https://github.com/ruby-processing/propane-examples/blob/master/contributed/re_sample.rb
[settings]:https://processing.org/reference/settings_.html