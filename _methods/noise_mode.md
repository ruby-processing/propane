---
layout: post
title:  "noise_mode"
---

### Name ###

`noise_mode` _NB: not currently available in vanilla processing_.

### Examples ###

```ruby
#!/usr/bin/env jruby -w
require 'propane'

class TestNoise < Propane::App
  attr_reader :z

  def setup
    stroke(255, 64)
    @z = 0
  end

  def draw
    noise_scale = 0.01
    background(0)
    grid(width, height, 10, 10) do |x, y|
      arrow(x, y, noise(x * noise_scale, y * noise_scale, z * noise_scale) * TWO_PI * 2)
    end
    @z += 1
  end

  def mouse_pressed
    mode = Propane::SIMPLEX
    noise_mode mode
    sketch_title "#{mode}"
  end

  def mouse_released
    mode = Propane::VALUE # default mode "Perlin Noise" in vanilla processing
    noise_mode(mode)
    sketch_title "#{mode}"
  end


  def arrow(x, y, ang)
    pushMatrix()
    translate(x, y)
    rotate(ang)
    line(0, 0, 20, 0)
    translate(20, 0)
    rotate(PI + 0.4)
    line(0, 0, 5, 0)
    rotate(-0.8)
    line(0, 0, 5, 0)
    popMatrix()
  end

  def settings
    size(600, 400, P2D)
  end
end

TestNoise.new

```

### Description	###

Currently supports two implementations of noise ValueNoise (Perlin noise in vanilla processing), up to 3D and SimplexNoise up to 4D.

### Syntax ###

```ruby
noise_mode(mode) # default mode is Propane::VALUE, and Propane::SIMPLEX
```

### Related ###

`noise(x, y, z, w)` SimplexNoise only

`noise(x, y, z)` ValueNoise and SimplexNoise
