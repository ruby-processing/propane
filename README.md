# Propane
To build custom core see [processing-core][processing-core]

A slim layer to communicate with Processing from JRuby, features a polyglot maven build. We have created a configuration free version of ruby processing, for processing-3.4, where we include a modified processing core (`public runPropane()` to replace `protected runSketch()`, (_runSketch not currently usable with jruby and jdk 9_). These jars are small enough to include in a gem distribution, and hence we do not require configuration. This has created a scriptable version, ie files get run direct from jruby, but you could use jruby-complete if you used the propane script (avoids need to give the absolute data path for the data folder, but would also be needed for a watch mode). See guide to [building ruby-processing projects][building]. NB: this is a far from perfect solution and javafx sketches and possibly a few others still fail to run with jdk9, but a least I get to diagnose those errors too.

adjust above for your OS/distro setup.

## Requirements

- `jdk8_u181`
- `jruby-9.2.5.0`
- `mvn-3.5.0+`
- `apple.jar` (_build only_) see (or may'be runtime as well a MacOS user needed to test) [vanilla-processing](https://github.com/processing/processing/blob/master/core/apple.jar)

## Building and testing

```bash
rake
rake gem
rake javadoc
```

## Installation
```bash
jgem install propane # from rubygems
jgem install propane-2.9.4-java.gem # local install requires a custom processing-core
```

## Usage

``` ruby
require 'propane'

class FlashingLightsSketch < Propane::App

  def settings
    size(800, 600)
  end

  def setup
    sketch_title 'Flashing Light Sketch'
  end

  def draw
    background(rand(255), rand(255), rand(255))
  end
end

FlashingLightsSketch.new
```


There is a handy sketch creator tool
```bash
propane -c my_sketch 200 200 # for default renderer
propane -c my_sketch 200 200 p2d # for opengl 2D renderer
propane -c my_sketch 200 200 p3d # for opengl 3D renderer
```

To run sketches

```bash
jruby my_sketch.rb # or use script to run sketches from atom
```
To install the sound and video libraries `~/.propane/libraries`. Depends on wget.
```bash
propane --install sound
propane --install video
```
Other java libraries can be manually installed to the same folder (no need for processing ide)

See [gh-pages][gh-pages] for more detailed instructions and much more.

## Examples

[Worked Examples](https://github.com/ruby-processing/propane-examples) more to follow, feel free to add your own, especially ruby-2.2+ syntax now we can. To install the samples.  The samples get copied to `~/propane_samples`. Depends on wget.
```bash
propane --install samples
```
 please move existing `propane_samples` if you wish to keep them. The current release features several PixelFlow glsl library examples, including a few shadertoy demos as sketches.

[building]:http://ruby-processing.github.io/building/building/
[gh-pages]:https://ruby-processing.github.io/propane/
[processing-core]:https://github.com/ruby-processing/processing-core
