---
layout: post
title:  "color explained"
---
to be expanded...

For propne we enable a convenience method color (based on processing PGraphics color), and for the most part this method behaves as the processing color method (but it is implemented differently under the hood to work with ruby Numeric/Fixnum). Basically the input can be an Array of Fixnum (approximating to a processing int) an Array of Float (approximating to processing float) or a special hexadecimal string or a hexadecimal number. See/try example sketch.

{% highlight ruby %}

#!/usr/bin/env jruby -v -w
# frozen_string_literal: true
# Creating Colors (Homage to Albers).
#
require 'propane'

# Creating variables for colors that may be referred to
# in the program by their name, rather than a number.
class CreatingColors < Propane::App
  attr_reader :redder, :yellower, :orangish
  WEB = %w(#CC6600 #CC9900 #993300)

  def settings
    size 640, 360
  end  

  def setup
    sketch_title 'Homage to Albers'
    palette = web_to_color_array(WEB)
    @redder = palette[0]
    @yellower = palette[1]
    @orangish = palette[2]
    # These statements are equivalent to the statements above.
    # Programmers may use the format they prefer.

    # hex color as a String (NB quotes are required)
    @redder = palette[0]
    @yellower = palette[1]
    @orangish = palette[2]

    # @redder = color '#CC6600'
    # @yellower = color '#CC9900'
    # @orangish = color '#993300'

    # or alternatively as a hexadecimal

    # @redder = color 0xFFCC6600
    # @yellower = color 0xFFCC9900
    # @orangish = color 0xFF993300
    puts int_to_ruby_colors(palette)
  end

  def draw
    no_stroke
    background 51, 0, 0
    push_matrix
    translate 80, 80
    fill orangish
    rect 0, 0, 200, 200
    fill yellower
    rect 40, 60, 120, 120
    fill redder
    rect 60, 90, 80, 80
    pop_matrix
    push_matrix
    translate 360, 80
    fill redder
    rect 0, 0, 200, 200
    fill orangish
    rect 40, 60, 120, 120
    fill yellower
    rect 60, 90, 80, 80
    pop_matrix
  end
end

{% endhighlight %}
