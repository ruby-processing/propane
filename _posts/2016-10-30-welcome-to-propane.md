---
layout: post
title: "Welcome to propane"
date: 2016-10-30 06:40:00
keywords: processing, jruby, propane
---
### Requirements ###

[jruby-9.3.1.0][jruby], [open jdk11][openjvm] or [Oracle jdk11][oraclejvm]

If you arrive here from rubygems `math_demo` you may well have installed `propane` as a requirement

```bash
math_demo # is the executable to run from the command line for the demo, but there's much more
```
See also [math_demo documentation][math_demo]

### Alternative ###

If you are familiar with the original ruby-processing (deprecated since January 2017) you may prefer to use [JRubyArt][JRubyArt] instead.  However like ruby-processing it depends on a vanilla processing install _however currently and for foreseable future, this is the only option for Windows users_.

### Installing ###

1. [Getting started on linux][linux]
2. [Getting started on MacOS][mac]
3. [Getting started on Windows][windows]

For more info on how to get the most out of JRubyArt see the [propane website][propane] and my [JRubyArt blog][blog]. File all bugs/feature requests at [propane issues][issues].

### Using ###

Create sketch from template

```bash
propane -c my_sketch 200 200 # creates `my_sketch.rb` with class `MySketch`
```

Run sketches

```bash
jruby my_sketch.rb
```

Example Sketch:-
```ruby
#!/usr/bin/env jruby -v -W2
# frozen_string_literal: true
require 'propane'
# Iconic ruby-processing example for Propane
class JWishy < Propane::App
  load_library :control_panel

  attr_reader :alpha, :back_color, :bluish, :hide, :magnitude, :panel
  attr_reader :x_wiggle, :y_wiggle, :go_big, :shape

  def settings
    size 600, 600  
  end

  def setup
    sketch_title 'Wishy Worm'
    control_panel do |c|
      c.title'Control Panel'
      c.look_feel 'Nimbus'
      c.slider :bluish, 0.0..1.0, 0.5
      c.slider :alpha,  0.0..1.0, 0.5
      c.checkbox :go_big, false
      c.button :reset
      c.menu :shape, %w(oval square triangle), 'oval'
      @panel = c
    end
    @hide = false
    @x_wiggle, @y_wiggle = 10.0, 0
    @magnitude = 8.15
    @back_color = [0.06, 0.03, 0.18]
    color_mode RGB, 1
    ellipse_mode CORNER
    smooth
  end

  def draw_background
    back_color[3] = alpha
    fill(*back_color.to_java(:float))
    rect 0, 0, width, height
  end

  def reset
    @y_wiggle = 0
  end

  def draw
    # only make control_panel visible once, or again when hide is false
    unless hide
      @hide = true
      panel.set_visible(hide)
    end
    draw_background
    # Seed the random numbers for consistent placement from frame to frame
    srand(0)
    horiz, vert, mag = x_wiggle, y_wiggle, magnitude
    if go_big
      mag *= 2
      vert /= 2
    end
    blu = bluish
    x, y = (width / 2), -27
    c = 0.0
    64.times do
      x += cos(horiz) * mag
      y += log10(vert) * mag + sin(vert) * 2
      fill(sin(y_wiggle + c), rand * 0.2, rand * blu, 0.5)
      s = 42 + cos(vert) * 17
      args = [@shape, x - s / 2, y - s / 2, s, s]
      draw_shape(args)
      vert += rand * 0.25
      horiz += rand * 0.25
      c += 0.1
    end
    @x_wiggle += 0.05
    @y_wiggle += 0.1
  end

  def mouse_pressed
    return unless hide
    @hide = false
  end

  def draw_shape(args)
    case args[0]
    when 'triangle'
      draw_triangle(args)
    when 'square'
      rect(args[1], args[2], args[3], args[4])
    else
      ellipse(args[1], args[2], args[3], args[4]) # oval for Shoes
    end
  end

  def draw_triangle(args)
    x2 = args[1] + (args[3] * 0.6)
    y0 = args[2] + (args[4] * 0.396)
    y1 = args[2] - (args[4] * 0.792)
    y2 = args[2] + (args[4] * 0.396)
    triangle(args[1] - (args[3] * 0.6), y0, args[1], y1, x2, y2)
  end
end

JWishy.new
```

[picrate]:https://github.com/ruby-processing/picrate
[propane]:https://ruby-processing.github.io/propane/
[issues]:https://github.com/ruby-processing/propane/issues
[jruby]:http://jruby.org/download
[openjvm]:http://openjdk.java.net/install/
[examples]: https://github.com/ruby-processing/propane-examples
[JRubyArt]:{{ site.github.url }}/JRubyArt/
[math_demo]:https://ruby-processing.github.io/math_demo
[windows]: {{site.github.url}}/windows_start/
[mac]: {{site.github.url}}/mac_start/
[linux]: {{site.github.url}}/linux_started/
[blog]: https://monkstone.github.io/
