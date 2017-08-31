---
layout: post
title:  "propane<sup>1, 2</sup>"
keywords: library, boids, control_panel

---
Propane provides a number of libraries that you can use _out of the box_, but which still need to be loaded to use them in you sketches see examples below:-


### Boids library ###
<sup>1</sup><i>A built in pure ruby library</i>

The [original boids library][original] was created by Jeremy Ashkenas to demonstrate a pure 'ruby' library for ruby processing, this updated version has the same goal. However it is updated to make use of [Vec3D][vec3d] and [Vec2D][vec2d] classes (propane features) and keyword arguments (ruby-2.1). It also use [forwardable][forwardable]. To see usage of now correctly implemented `angle` (heading) see [simple example][example].

See the full library code below:-

```ruby
# frozen_string_literal: true
# Boids -- after Tom de Smedt.
# See his Python version: http://nodebox.net/code/index.php/Boids
# This is an example of how a pure-Ruby library can work. Original for
# ruby-processing Jeremy Ashkenas. Reworked, re-factored for propane
# by Martin Prout, features forwardable, keyword args, Vec3D and Vec2D.
class Boid
  attr_reader :boids
  attr_accessor :vel, :pos, :is_perching, :perch_time
  def initialize(boids, pos)
    @boids, @flock = boids, boids
    @pos = pos
    @vel = Vec3D.new
    @is_perching = false
    @perch_time = 0.0
  end

  def cohesion(d:)
    # Boids gravitate towards the center of the flock,
    # Which is the averaged position of the rest of the boids.
    vect = Vec3D.new
    @boids.each do |boid|
      vect += boid.pos unless boid == self
    end
    count = @boids.length - 1.0
    vect /= count
    (vect - pos) / d
  end

  def separation(radius:)
    # Boids don't like to cuddle.
    vect = Vec3D.new
    @boids.each do |boid|
      if boid != self
        dv = pos - boid.pos
        vect += dv if dv.mag < radius
      end
    end
    vect
  end

  def alignment(d:)
    # Boids like to fly at the speed of traffic.
    vect = Vec3D.new
    @boids.each do |boid|
      vect += boid.vel if boid != self
    end
    count = @boids.length - 1.0
    vect /= count
    (vect - vel) / d
  end

  def limit(max:)
    # Tweet, Tweet! The boid police will bust you for breaking the speed limit.
    most = [vel.x.abs, vel.y.abs, vel.z.abs].max
    return if most < max
    scale = max / most.to_f
    @vel *= scale
  end

  def angle
    Vec2D.new(vel.x, vel.y).heading
  end

  def goal(target, d = 50.0)
    # Them boids is hungry.
    (target - pos) / d
  end
end

require 'forwardable'

# The Boids class
class Boids
  include Enumerable
  extend Forwardable
  def_delegators(:@boids, :reject, :<<, :each, :shuffle!, :length, :next)

  attr_reader :has_goal, :perch, :perch_tm, :perch_y

  def initialize
    @boids = []
  end

  def self.flock(n:, x:, y:, w:, h:)
    flock = Boids.new.setup(n, x, y, w, h)
    flock.reset_goal(Vec3D.new(w / 2, h / 2, 0))
  end

  def setup(n, x, y, w, h)
    n.times do
      dx, dy = rand(w), rand(h)
      z = rand(200.0)
      self << Boid.new(self, Vec3D.new(x + dx, y + dy, z))
    end
    @x, @y, @w, @h = x, y, w, h
    @scattered = false
    @scatter = 0.005
    @scatter_time = 50.0
    @scatter_i = 0.0
    @perch = 1.0 # Lower this number to divebomb.
    @perch_y = h
    @perch_tm = -> { 25.0 + rand(50.0) }
    @has_goal = false
    @flee = false
    @goal = Vec3D.new
    self
  end

  def scatter(chance = 0.005, frames = 50.0)
    @scatter = chance
    @scatter_time = frames
  end

  def no_scatter
    @scatter = 0.0
  end

  def perch(ground = nil, chance = 1.0, frames = nil)
    @perch_tm = frames.nil? ? -> { 25.0 + rand(50.0) } : frames
    @perch_y = ground.nil? ? @h : ground
    @perch = chance
  end

  def no_perch
    @perch = 0.0
  end

  def reset_goal(target)
    @has_goal = true
    @flee = false
    @goal = target
    self
  end

  def goal(target:, flee:)
    @has_goal = true
    @flee = flee
    @goal = target
    self
  end

  def no_goal
    @has_goal = false
  end

  def constrain
    # Put them boids in a cage.
    dx, dy = @w * 0.1, @h * 0.1
    each do |b|
      b.vel.x += rand(dx) if b.pos.x < @x - dx
      b.vel.y += rand(dy) if b.pos.y < @y - dy
      b.vel.x -= rand(dx) if b.pos.x > @x + @w + dx
      b.vel.y -= rand(dy) if b.pos.y > @y + @h + dy
      b.vel.z += 10.0 if b.pos.z < 0.0
      b.vel.z -= 10.0 if b.pos.z > 100.0
      next unless b.pos.y > perch_y && rand < perch
      b.pos.y = perch_y
      b.vel.y = b.vel.y.abs * -0.2
      b.is_perching = true
      b.perch_time = perch_tm.respond_to?(:call) ? perch_tm.call : perch_tm
    end
  end

  def update(goal: 20.0, limit: 30.0, **args)
    shuffled = args.fetch(:shuffled, true)
    cohesion = args.fetch(:cohesion, 100)
    separation = args.fetch(:separation, 10)
    alignment = args.fetch(:alignment, 5.0)
    # Just flutter, little boids ... just flutter away.
    # Shuffling keeps things flowing smooth.
    shuffle! if shuffled
    m1 = 1.0 # cohesion
    m2 = 1.0 # separation
    m3 = 1.0 # alignment
    m4 = 1.0 # goal
    @scattered = true if !@scattered && rand < @scatter
    if @scattered
      m1 = -m1
      m3 *= 0.25
      @scatter_i += 1.0
    end
    if @scatter_i >= @scatter_time
      @scattered = false
      @scatter_i = 0.0
    end
    m4 = 0.0 unless has_goal
    m4 = -m4 if @flee
    each do |b|
      if b.is_perching
        if b.perch_time > 0.0
          b.perch_time -= 1.0
          next
        else
          b.is_perching = false
        end
      end
      v1 = b.cohesion(d: cohesion)
      v2 = b.separation(radius: separation)
      v3 = b.alignment(d: alignment)
      v4 = b.goal(@goal, goal)
      # NB: vector must precede scalar in '*' operation below
      b.vel += (v1 * m1 + v2 * m2 + v3 * m3 + v4 * m4)
      b.limit(max: limit)
      b.pos += b.vel
    end
    constrain
  end
end

```

Here is the re-factored Flight Patterns Sketch:-
```ruby
#!/usr/bin/env jruby -v -w
# Description:
# Flight Patterns is that ol' Euruko 2008 demo.
# Reworked version for Propane
# Usage:
# Drag mouse to steer 'invisible' flock attractor, use 'f' key to toggle flee
# Mouse 'click' to toggle 'sphere' or 'circle' display
require 'propane'

class FlightPatterns < Propane::App
  load_library :boids

  attr_reader :flee, :radius

  def settings
    size 1024, 768, P3D
  end

  def setup
    sketch_title 'Flight Patterns'    
    sphere_detail 8
    color_mode RGB, 1.0
    no_stroke
    shininess 1.0
    specular 0.3, 0.1, 0.1
    emissive 0.03, 0.03, 0.1
    @radius = 0.02 * height
    @click = false
    @flee = false
    @flocks = (0..3).map { Boids.flock(n: 20, x: 0, y: 0, w: width, h: height) }
  end

  def mouse_pressed
    @click = !@click
  end

  def key_pressed
    return unless key == 'f'
    @flee = !@flee
  end

  def draw
    background 0.05
    ambient_light 0.01, 0.01, 0.01
    light_specular 0.4, 0.2, 0.2
    point_light 1.0, 1.0, 1.0, mouse_x, mouse_y, 190
    @flocks.each_with_index do |flock, i|
      flock.goal(target: Vec3D.new(mouse_x, mouse_y, 0), flee: @flee)
      flock.update(goal: 185, limit: 13.5)
      flock.each do |boid|
        r = (0.15 * boid.pos.z) + radius
        case i
        when 0 then fill 0.85, 0.65, 0.65
        when 1 then fill 0.65, 0.85, 0.65
        when 2 then fill 0.65, 0.65, 0.85
        end
        push_matrix
        point_array = (boid.pos.to_a).map { |p| p - (r / 2.0) }
        translate(*point_array)
        @click ? sphere(r / 2) : ellipse(0, 0, r, r)
        @click ? hint(ENABLE_DEPTH_TEST) : hint(DISABLE_DEPTH_TEST)
        pop_matrix
      end
    end
  end
end

FlightPatterns.new

```


### Control Panel library

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
      c.title 'Control Panel'
      c.look_feel 'Nimbus'
      c.slider :bluish, 0.0..1.0, 0.5
      c.slider :alpha,  0.0..1.0, 0.5
      c.checkbox :go_big, false
      c.button :reset
      c.menu :shape, %w[oval square triangle], 'oval'
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

### Video Event Library ###

<sup>2</sup><i>A built in hybrid ruby/java library</i>
The video library should be installed using `propane --install video`

The purpose of the `video_event` library is to allow you to use the vanilla processing reflection methods `captureEvent` and `movieEvent` from the processing `video` library. _It is almost impossible to use vanilla processing reflection methods without this sort of wrapper_.

If MacOS users experience difficulty with the video library they should probably rename the binary folder from `macosx64` to `macosx`.  However it seems as though the binaries get dynamically loaded from the video library, and this may not be necessary see [Line 178][178] (personal communication Gottfreid Haider) but this is pure conjecture in case of propane.

A movie example:-

```ruby
#!/usr/bin/env jruby -w
require 'propane'
# Loop.
#
# Shows how to load and play a QuickTime movie file.
class Loop < Propane::App
  load_libraries :video, :video_event
  include_package 'processing.video'

  attr_reader :movie

  def setup
    sketch_title 'Loop'
    background(0)
    # Load and play the video in a loop
    @movie = Movie.new(self, data_path('transit.mov'))
    movie.loop
  end

  def draw
    image(movie, 0, 0, width, height)
  end

  # use camel case to match java reflect method
  def movieEvent(m)
    m.read
  end

  def settings
    size 640, 360
  end
end

Loop.new
```

A capture example-

```ruby
#!/usr/bin/env jruby -w
require 'propane'
class TestCapture < Propane::App
  load_libraries :video, :video_event

  include_package 'processing.video'

  attr_reader :cam

  def setup
    sketch_title 'Test Capture'
    cameras = Capture.list
    fail 'There are no cameras available for capture.' if (cameras.length == 0)
    p 'Matching cameras available:'
    size_pattern = Regexp.new(format('%dx%d', width, height))
    select = cameras.grep size_pattern # filter available cameras
    select.uniq.map { |cam| p cam.strip }
    fail 'There are no matching cameras.' if (select.length == 0)
    start_capture(select[0])
  end

  def start_capture(cam_string)
    # The camera can be initialized directly using an
    # element from the array returned by list:
    @cam = Capture.new(self, cam_string)
    p format('Using camera %s', cam_string)
    cam.start
  end

  def draw
    image(cam, 0, 0, width, height)
    # The following does the same, and is faster when just drawing the image
    # without any additional resizing, transformations, or tint.
    # set(0, 0, cam)
  end

  def captureEvent(c)
    c.read
  end

  def settings
    size 1280, 720, P2D
  end
end

TestCapture.new
```

### File Chooser Library ###

<sup>2</sup><i>A built in hybrid ruby/java library</i>

Start by loading in the chooser library, the purpose of this library is to allow you to use the vanilla processing interface to the `native file chooser` (it is almost impossible to use vanilla processing reflection methods without this sort of wrapper)

```ruby
#!/usr/bin/env jruby -v -W2

require 'propane'
###########
# Example Native File Chooser using vanilla processing
# select_input, and file_selected
###########
class SelectFile < Propane::App

  load_library :file_chooser


  def settings
    size 200, 100
  end

  def setup
    sketch_title 'Select File, native chooser'
    # java_signature 'void selectInput(String, String)'
    select_input('Select a File', 'file_selected')
  end

  #  signature 'void file_selected(java.io.File file)'
  def file_selected(file)
    puts file.get_absolute_path unless file.nil?
  end
end

SelectFile.new
```

See also [these examples](https://github.com/ruby-processing/propane-examples/tree/master/processing_app/library/file_chooser)

[178]:https://github.com/processing/processing-video/blob/master/src/processing/video/Video.java


[original]:https://github.com/jashkenas/ruby-processing/blob/8865c934318e05e62cbfa2603e661275b1cffd31/library/boids/boids.rb
[vec3d]:https://ruby-processing.github.io/classes/vec3d/
[vec2d]:https://ruby-processing.github.io/classes/vec2d/
[forwardable]:https://ruby-doc.org/stdlib-2.0.0/libdoc/forwardable/rdoc/Forwardable.html
[example]:https://github.com/ruby-processing/propane-examples/blob/master/processing_app/library/boids/boids_example.rb
