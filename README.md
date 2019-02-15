# Propane

This version is intended to work with openjdk11+, @sampottinger is currently working on [vanilla processing][vanilla] which will enable JRubyArt to catch up.

A slim layer to communicate with Processing from JRuby, features maven build. We have created a configuration free version of ruby processing, for processing-3.5+, where we include a modified processing core (`public runPropane()` to replace `protected runSketch()`. These jars are small enough to include in a gem distribution, and hence we do not require configuration. This has created a scriptable version, ie files get run direct from jruby. Currently JavaFX is unsupported again @sampottinger is currently working on [vanilla processing][vanilla] to use OpenJFX.

adjust above for your OS/distro setup.

## Requirements

- `jdk-11.0.2+`
- `jruby-9.2.7.0`
- `mvn-3.5.4+`

## Building and testing

```bash
rake
rake gem
rake javadoc
```

## Installation
```bash
jgem install --pre propane # from rubygems
jgem install propane-3.2-java.gem # local install
# Alternative
jruby -S gem install --pre propane # from rubygems
jruby -S gem install propane-3.2-java.gem # local install
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

[Worked Examples](https://github.com/ruby-processing/propane-examples) more to follow, feel free to add your own, especially ruby-2.4
+ syntax now we can. To install the samples.  The samples get copied to `~/propane_samples`. Depends on wget.
```bash
propane --install samples
```
 please move existing `propane_samples` if you wish to keep them. The current release features several PixelFlow glsl library examples, including a few shadertoy demos as sketches.

[building]:http://ruby-processing.github.io/building/building/
[gh-pages]:https://ruby-processing.github.io/propane/
[vanilla]:https://github.com/processing/processing/pull/5753
