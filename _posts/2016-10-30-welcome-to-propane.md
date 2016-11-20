---
layout: post
title: "Welcome to propane"
date: 2016-10-30 06:40:00
keywords: processing, jruby, propane
---
### Requirements ###
[jruby-9.1.6.0][jruby], [open jdk8][openjvm] or [Oracle jdk8][oraclejvm]
### Alternative ###
[JRubyArt][JRubyArt] is more similar to ruby-processing, requires a vanilla processing install.
### Installing ###
Propane-2.0.6 is a configuration free version of processing-3.2.3 (in a ruby environment) [Propane][propane] the full version is currently just MacOS / Linux. But Java2D mode should work on Windows.
To install gem:-
{% highlight bash %}
jgem install propane # or belt and braces
jruby -S gem install propane
{% endhighlight %}
Post install:-

{% highlight bash %}
propane --install samples # requires wget installs samples
propane --install sound # requires wget installs processing sound library
propane --install video # requires wget installs processing video library
{% endhighlight %}

### Using ###

Create sketch from template

{% highlight bash %}
propane -c my_sketch 200 200 # creates `my_sketch.rb` with class `MySketch`
{% endhighlight %}

Run sketches

{% highlight bash %}
jruby my_sketch.rb
{% endhighlight %}

Example Sketch:-
{% highlight ruby %}
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
      c.title = 'Control Panel'
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
{% endhighlight %}

[propane]:https://github.com/ruby-processing/propane
[jruby]:http://jruby.org/download
[openjvm]:http://openjdk.java.net/install/
[oraclejvm]:http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
[JRubyArt]:{{ site.github.url }}/JRubyArt/
