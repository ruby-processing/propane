---
layout: page
title: JRubyArt
permalink: /JRubyArt/
---
### JRubyArt ###
[JRubyArt][jruby_art] is a ruby wrapper for [processing-3.4][processing]. That requires you install vanilla [processing-3.4][processing] (cf propane). It also supports `bare` sketches (similar to vanilla processing where the bare sketch gets wrapped into a class under the hood) also the `watch` mode is also supported, neither feature is currently supported with propane.

### JRubyArt and propane ###

Create processing sketches in ruby using regular ruby-2.3 syntax, and use the magic [JRuby][jruby] to run them. You can use both rubygems and and regular processing libraries in your sketches. JRubyArt examples can be easily converted to work with propane (and vice-versa).

In general where there is a choice of using a java (processing) method or a regular ruby method you should choose the ruby method (eg use `rand` in place of `random`). Further you should prefer to use `JRuby` classes `Vec2D` and `Vec3D` instead of processings `PVector` class. Processing has a number of convenience methods which are not needed in ruby (eg 'pow' use `**` in JRubyArt/propane) and some static methods have not been implemented in JRubyArt/propane. For the processing `map` method prefer `map1d` ([see example][map1d]) or use `p5map` if you must. Another thing to watch is `color` which is implemented differently in JRubyArt/propane ([see example][color]).

See also my [blog][blog] for more code ideas.

[jruby]: https://jruby.org
[processing]: https://processing.org

[jruby_art]: https://ruby-processing.github.io/index.html
[color]: https://github.com/ruby-processing/JRubyArt-examples/blob/master/processing_app/basics/color/creating.rb
[map1d]: https://github.com/ruby-processing/JRubyArt-examples/blob/master/processing_app/basics/arrays/array.rb
[blog]:https://monkstone.github.io/
