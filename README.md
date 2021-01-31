# Propane [![Gem Version](https://badge.fury.io/rb/propane.svg)](https://badge.fury.io/rb/propane) ![Travis CI](https://travis-ci.org/ruby-processing/propane.svg)

This version is intended to work with openjdk11+, @sampottinger is currently working on [vanilla processing][vanilla] which will enable JRubyArt to catch up.

A slim layer to communicate with Processing from JRuby, features maven build. We have created a configuration free version of ruby processing, for processing-4.0+, where we include a modified processing core (`public runPropane()` to replace `protected runSketch()`. These jars are small enough to include in a gem distribution, and hence we do not require configuration. This has created a scriptable version, ie files get run direct from jruby. Currently JavaFX is unsupported again @sampottinger is currently working on [vanilla processing][vanilla] to use OpenJFX. It would be nice make use of java modules, but I think we should let jruby project do that first (unless processing.org beat them to it).

adjust above for your OS/distro setup.

## Requirements

There may be a linker issue with P2D or P3D sketches with stock openjdk with some linux distros, in which case you might find [Adopt open jdk binaries][adopt] will work for you.

- `jdk-11.0.7+`
- `jruby-9.2.14.0`

Currently you can ignore `illegal reflective access` warnings, see [here how to suppress them][warning].

## Building and testing

```bash
rake
rake gem
rake javadoc
```

## Installation

```bash
jgem install propane # from rubygems
jgem install propane-3.6.0-java.gem # local install
# Alternative
jruby -S gem install propane # from rubygems
jruby -S gem install propane-3.6.0-java.gem # local install
```

## Check Install
To check version and confirm gem bin files are on your path (also checks JDK version)

```bash
propane --version
```

## Suppressing Reflective Access warnings

Since propane-3.5.0 it is possible to suppress reflective access warnings by setting JAVA_HOME environmental variable jruby does the rest.

## Usage

A propane sketch:-

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

Create template sketches with the sketch creator tool

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

[Worked Examples](https://github.com/ruby-processing/propane-examples) more to follow, feel free to add your own, especially ruby-2.5
+ syntax now we can. To install the samples.  The samples get copied to `~/propane_samples`. Depends on wget.
```bash
propane --install samples
```
 please move existing `propane_samples` if you wish to keep them. The current release features several PixelFlow glsl library examples, including a few shadertoy demos as sketches.

[adopt]: https://adoptopenjdk.net/
[building]:http://ruby-processing.github.io/building/building/
[gh-pages]:https://ruby-processing.github.io/propane/
[vanilla]:https://github.com/processing/processing/pull/5753
[warning]: https://monkstone.github.io/jruby_art/update/2019/09/10/Reflective_Access.html
