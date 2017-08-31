---
layout: post
title:  "processing<sup>2</sup>"
keywords: library, boids, control_panel

---
### Sound library ###

<sup>5</sup><i>A vanilla processing (java) library</i>

First load the sound library (assumes it was installed using `propane --install Sound`)

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

### Listing vanilla processing contributed libraries and their urls ###

```bash
wget http://download.processing.org/contribs/contribs.txt
```

### Installing contributed vanilla processing libraries ###

Install libraries to your `~/.propane/libraries` folder.  NB: this created for you when you install the `glvideo`, `sound` or `video` libraries. The one unfortunate / fortunate thing is that you will be responsible for updating versions manually (can be good / bad thing).

```bash
propane -i Sound
propane -i Video
propane -i glvideo
```

It can make sense to convert the library names and jars from `camelcase` to `snakecase`, (_ie when library creators have messed up_) but just be to be consistent, as example below

```bash
cd ~/.propane/libraries
wget http://staff.city.ac.uk/~jwo/giCentre/utils/gicentreUtils.zip
unzip gicentreUtils.zip # NB: British English spelling of centre
mv gicentreUtils gicenter_utils # Use snake case, and convert spelling
cd gicenter_utils/library
mv gicentreUtils.jar gicenter_utils.jar
```
Here is an example sketch translated to propane, main differences are how we load libraries and access package namespace in propane. Also note the use of the data_path wrapper to access sketch data folder. Another twist is the need to cast array of ruby Numbers to java float.

```ruby
require 'propane'
# Sketch to demonstrate the use of the BarChart class to draw simple bar charts.
# Version 1.3, 6th February, 2016.
# Author Jo Wood, giCentre.
class BarChartSketch < Propane::App
  load_library :gicenter_utils
  include_package 'org.gicentre.utils.stat' # British spelling

  def settings
    size(800, 300)
    smooth
  end

  def setup # a static sketch no need for draw loop
    sketch_title 'Bar Chart Sketch'
    title_font = load_font(data_path('Helvetica-22.vlw'))
    small_font = load_font(data_path('Helvetica-12.vlw'))
    text_font(small_font)
    bar_chart = BarChart.new(self)
    data_float = [
      2_462, 2_801, 3_280, 3_983, 4_490, 4_894, 5_642, 6_322, 6_489, 6_401,
      7_657, 9_649, 9_767, 12_167, 15_154, 18_200, 23_124, 28_645, 39_471
    ]
    bar_chart.setData(data_float.to_java(:float))
    data_label = %w(1830 1840 1850 1860 1870 1880 1890 1900 1910 1920 1930 1940 1950 1960 1970 1980 1990 2000 2010)
    bar_chart.setBarLabels(data_label)
    bar_chart.setBarColour(color(200, 80, 80, 100))
    bar_chart.setBarGap(2)
    bar_chart.setValueFormat('$###,###')
    bar_chart.showValueAxis(true)
    bar_chart.showCategoryAxis(true)
    background(255)
    bar_chart.draw(10, 10, width - 20, height - 20)
    fill(120)
    text_font(title_font)
    text('Income per person, United Kingdom', 70, 30)
    text_height = text_ascent # of title font
    text_font(small_font)
    text('Gross domestic product measured in inflation-corrected $US', 70, 30 + text_height)
  end
end

BarChartSketch.new
```

![bar chart sketch]({{ site.github.url }}/assets/bar_chart.png)
