---
layout: post
title:  "Sound<sup>5</sup>"
keywords: library, java, sound, processing. reflection

---

<sup>5</sup><i>A vanilla processing (java) library</i>

First load the sound library (assumes it was installed using the processing3 ide)

You might just as well `include_package` to get namespace access to the `processing.sound` package.

```ruby
# This is a simple pink noise generator. It can be started with .play(amp).
# In this example it is started and stopped by clicking into the renderer window.
require 'propane'

class PinkNoiseApp < Propane::App
  load_library :sound
  include_package 'processing.sound'
  
  attr_reader :amp, :noise
  
  def settings
    size(640, 360)
  end
  
  def setup
    sketch_title 'Pink Noise'
    background(255)
    @amp = 0.0
    # Create the noise generator
    @noise = PinkNoise.new(self)
    noise.play(amp)
  end      
  
  def draw
    # Map mouseX from 0.0 to 1.0 for amplitude
    noise.amp(map1d(mouse_x, (0..width), (0.0..1.0)))
    # Map mouseY from -1.0 to 1.0 for left to right
    noise.pan(map1d(mouse_y, (0..height), (-1.0..1.0)))
  end
end

PinkNoiseApp.new
```
