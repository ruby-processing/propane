---
layout: post
title:  "Instance Variable"
keywords: attr_reader, @, instane
---
A instance variable in ruby has a name beginning with `@`.  It often makes sense for it to be initialised at `setup` (not necessarily in the loop could be called method).

```ruby
#!/usr/bin/env jruby -v -W2
require 'propane'

class Tree < Propane::App
  # http://processing.org/learning/topics/tree.html
  # by Joe Holt

  def setup
    size 200, 200
  end

  def setup
    sketch_title 'Tree'
    color_mode RGB, 1
    frame_rate 30
    smooth
    @x = 0.0
    @dx = width / 100
    @start_time = Time.now
    @frame_time = nil
  end

  def draw
    t = Time.now
    if @frame_time
      fps = 1.0 / (t - @frame_time)
      # printf "%0.1f fps\n", fps
    end
    @frame_time = t

# ...etc

Tree.new
```

For a variable that gets called quite a lot in a propane sketch it makes sense to create a getter using `attr_reader`. This has the fortunate side effect of making it blindingly obvious when you are assigning it to a new value/instance (it also makes the sketch variable readable by external classes).

```ruby
#!/usr/bin/env jruby -w
require 'propane'
class Interpolate < Propane::App
  attr_reader :x, :y

  def setup
    sketch_title 'Interpolate'
    @x, @y = 0, 0
    no_stroke
  end

  def draw
    background(51)
    @x = lerp(x, mouse_x, 0.05)
    @y = lerp(y, mouse_y, 0.05)
    fill(255)
    stroke(255)
    ellipse(x, y, 66, 66)
  end

  def settings
    size(640, 360)
  end
end

Interpolate.new
```
