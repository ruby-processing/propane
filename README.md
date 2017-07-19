# Propane
[![Gem Version](https://badge.fury.io/rb/propane.svg)](https://badge.fury.io/rb/propane) [![Travis CI](https://travis-ci.org/ruby-processing/propane.svg)](https://travis-ci.org/ruby-processing/propane)

A slim layer to communicate with Processing from JRuby, features a polyglot maven build. We have created a configuration free version of ruby processing, for processing-3.3.5, where we include processing core (from a local maven repository and opengl etc from maven central). These jars are small enough to include in a gem distribution, and hence we do not require configuration. This has created a scriptable version, ie files get run direct from jruby, but you could use jruby-complete if you used the propane script (avoids need to give the absolute data path for the data folder, but would also be needed for a watch mode). See guide to [building ruby-processing projects][building].

## Requirements

- jdk8+
- jruby-9.1.12.0
- mvn-3.5.0+
- core.jar processing-3.3.5 (_build only_)

## Building and testing

```bash
rake
rake gem
rake javadoc
```

## Installation
```bash
jgem install propane # from rubygems
jgem install propane-2.3.4-java.gem # for local install
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

To install the samples.  The samples get copied to `~/propane_samples`. Depends on wget.
```bash
propane --install samples
```
There is a handy sketch creator tool
```bash
propane -c my_sketch 200 200 # for default renderer
propane -c my_sketch 200 200 p2d # for opengl 2D renderer
propane -c my_sketch 200 200 p3d # for opengl 3D renderer
```

To run sketches

```bash
jruby -S propane --run my_sketch.rb # belt and braces version
```
To install the sound and video libraries `~/.propane/libraries`. Depends on wget.
```bash
propane --install sound
propane --install video
```
Other java libraries can be manually installed to the same folder (no need for processing ide)

See [gh-pages][gh-pages] for more detailed instructions and much more.

[building]:http://ruby-processing.github.io/building/building/
[gh-pages]:https://ruby-processing.github.io/propane/
