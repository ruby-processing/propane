---
layout: page
title:  "Libraries"
permalink: /libraries/
---

### Installing vanilla processing libraries ###

Installing vanilla processing libraries is a simple as putting the required library in the `~/.propane/libraries` folder as can be seen from the listings below (NB: you should use lowercase library names especially on linux). For the processing video and sound libraries its even easier `propane --install sound` or `propane --install video` downloads the sound/video libraries (requires `wget`) and unpacks the libraries for you.

```bash
ls ~/.propane/libraries
hype  minim  sound  video
ls ~/.propane/libraries/hype/library
hype.jar
```
Here is a hype library example modified for use with propane:-

```ruby
#!/usr/bin/env jruby -v -W2
# frozen_string_literal: true
require 'propane'
# class wrapped sketch for propane 
class MethodChaining < Propane::App
  load_library :hype
  include_package 'hype'
  
  def settings
    size(640, 640)
  end
  
  def setup
    sketch_title('Method Chaining')
    H.init(self)
    H.background(color('#242424'))
    rect1 = HRect.new(100)
    rect1.rounding(10) # set corner rounding
    rect1.stroke_weight(6) # set stroke weight
    rect1.stroke(color('#000000'), 150) # set stroke color and alpha
    rect1.fill(color('#FF6600')) # set fill color
    rect1.anchor_at(H::CENTER) # set where anchor point is / key point for rotation and positioning
    rect1.rotation(45) # set rotation of the rect
    rect1.loc(100, height / 2) # set x and y location
    H.add(rect1)
    
    # here's the same code / with method chaining
    
    rect2 = HRect.new(100)
    rect2.rounding(10)
    .stroke_weight(6)
    .stroke(color('#000000'), 150)
    .fill(color('#FF9900'))
    .anchor_at(H::CENTER)
    .rotation(45)
    .loc(247, height / 2)
    H.add(rect2)
    
    # here's the same code / minus the hard returns and indentation (tabs are bad)
    
    rect3 = HRect.new(100)
    rect3.rounding(10).stroke_weight(6).stroke(color('#000000'), 150).fill(color('#FFCC00')).anchor_at(H::CENTER).rotation(45).loc(394, height / 2)
    H.add(rect3)
    
    H.draw_stage # paint the stage
    
    # here is the non HYPE version / basic processing syntax
    
    push_matrix
    stroke_weight(6)
    stroke(color('#000000'), 150)
    fill(color('#FF3300'))
    translate(width - 100, (height / 2))
    rotate(45.radians)
    rect(0, 0, 100, 100, 10, 10, 10, 10)
    pop_matrix
    stroke_weight(1)
    stroke(color('#0095a8'))
    line(0, height / 2, width, height / 2)
  end
end

MethodChaining.new

```

### Installing gem libraries ###

The `arcball` library gets installed as a dependency, for other libraries:-
```bash
jgem install library
```

Currently you might like to install are `geomerative`, `toxiclibs` and `pbox2d` gems (which were developed for JRubyArt but should also work, however examples will need to be converted to class wrapped sketches to run eg.

```ruby
#!/usr/bin/env jruby -v -W2
require 'propane'
require 'pbox2d'
require_relative 'lib/particle_system'
require_relative 'lib/boundary'

Vect = Struct.new(:x, :y)

class Liquidy < Propane::App
  attr_reader :box2d, :boundaries, :systems

  def settings
    size(400, 300)
  end

  def setup
    sketch_title 'Liquidy'
    @box2d = WorldBuilder.build(app: self, gravity: [0, -20])
    @systems = []
    @boundaries = [
    Boundary.new(box2d, Vect.new(50, 100), Vect.new(300, 5), -0.3),
    Boundary.new(box2d, Vect.new(250, 175), Vect.new(300, 5), 0.5)
    ]
  end

  def draw
    background(255)
    # Run all the particle systems
    if systems.size > 0
      systems.each do |system|
        system.run
        system.add_particles(box2d, rand(0..2))
      end
    end
    # Display all the boundaries
    boundaries.each(&:display)
  end

  def mouse_pressed
    # Add a new Particle System whenever the mouse is clicked
    systems << ParticleSystem.new(box2d, 0, mouse_x, mouse_y)
  end
end

Liquidy.new

```

