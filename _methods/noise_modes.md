---
layout: post
title:  "Noise Modes"
---

### Name ###

There are two noise modes available in PiCrate, both base on KdotJPG java noise.
The default noise uses the FastNoise module, the SmoothNoise module can be used using the module name as a prefix see example below.

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
        arrow(x, y, SmoothNoise.noise(x * noise_scale, y * noise_scale, z * noise_scale) * TWO_PI * 2)
        # arrow(x, y, noise(x * noise_scale, y * noise_scale, z * noise_scale) * TWO_PI * 2)
      end
      @z += 1
    end

    def arrow(x, y, ang)
      push_matrix()
      translate(x, y)
      rotate(ang)
      line(0, 0, 20, 0)
      translate(20, 0)
      rotate(PI + 0.4)
      line(0, 0, 5, 0)
      rotate(-0.8)
      line(0, 0, 5, 0)
      pop_matrix()
    end

    def settings
      size(600, 400, P2D)
    end
  end

  TestNoise.new

```

### Description	###

Currently supports four implementations of noise:-
1. Default is classic OpenSimplex2
2. SmoothNoise use smoother class OpenSimplex2F
3. Use tnoise instead of noise for a noise mode more suited to terrain

### Syntax ###

```ruby
SmoothNoise.noise(...) # no prefix for fast classic OpenSimplex2
```

### Related ###

`noise(x, y, z, w)`

`noise(x, y, z)`

`noise(x, y)`
