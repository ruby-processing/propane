---
layout: post
title:  "Control Panel<sup>2</sup>"
keywords: library, framework, gui, processing

---
<sup>2</sup><i>A built in hybrid ruby/java library</i>

Start by loading in the control_panel library, and then define your panel in setup like so:

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

#....rest of code


  def draw
    # only make control_panel visible once, or again when hide is false
    unless hide
      @hide = true
      panel.set_visible(hide)
    end
#.... rest of draw   

JWishy.new


```
![JWishy]({{site.github.url}}/assets/jwishy.png)

See also [penrose](https://github.com/ruby-processing/propane-examples/blob/master/processing_app/library/vecmath/vec2d/penrose.rb) and [bezier playground](https://github.com/ruby-processing/propane-examples/blob/master/contributed/bezier_playground.rb) sketches. See ruby code [here](https://github.com/ruby-processing/propane/blob/master/library/control_panel/control_panel.rb).
