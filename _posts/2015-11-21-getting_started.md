---
layout: post
title:  "Getting Started on ArchLinux"
date:   2015-11-21 06:24:13
permalink: /linux_started/
---

### Getting Started With propane ArchLinux ###

If you love to code because it is a creative process, then you should give propane a try because it can be used to [create music][sound], art, animations, [videos][video] and much more. Also since it is based on the latest [Processing][processing] you can access a vast range of libraries to make the difficult things easier.

### What Is Processing? ###

Processing is a simple language, based on Java, that you can use to create digital graphics. It's easy to learn, fun to use, and has an amazing online community comprised of programmers, visual artists, musicians, and interdisciplinary artists of all kinds.

Processing was built by Casey Reas and Benjamin Fry, two protegés of interdisciplinary digital art guru John Maeda at the MIT Media Lab.

Since the project began in 2001, it's been helping teach people to program in a visual art context using a simplified version of Java. It comes packaged as an IDE that can be downloaded and used to create and save digital art “sketches”.

In 2009, Jeremy Ashkenas (aka jashkenas, creator of Backbone.JS, Underscore.JS, and Coffeescript), published the original [ruby-processing gem][gem]. It wraps Processing in a shim that makes it even easier to get started if you know Ruby. It has been since updated to use processing-2.2.1 by Martin Prout (final version using jruby-1.7.27 corresponding to ruby-1.9.3 syntax), NB: no more releases are expected, and ruby-processing is not compatible with processing-3.0+.

In 2016, Martin Prout (aka monkstone) published the [propane gem][propane], a stand alone version of ruby-processing, since using the core.jar from processing (recently using the processing-3.3.5 version see changelog) and jruby-9.1.12.0+ (ruby-2.2 syntax)

### Why propane? ###

__The answers:__ You can dabble with the latest `processing framework` (in ruby) without even needing to install `vanilla processing` (and its embded jdk).  If you know how to write Ruby, you can use Processing as a visual presentation layer of a much more complex program. Games, interactive art exhibits, innovative music projects, anything you can imagine; it's all at your fingertips.

Additionally, you don't have to declare types, voids, or understand the differences between floats and ints to get started, as you do in pure Processing.

Although there are some drawbacks to using the Ruby version Processing (slower start up time, and sometimes performance), having Ruby's API available to translate your ideas into sketches more than makes up for them.

Why was ruby-processing not updated to use processing3.0+? The [major changes][changes] between processing-2.2.1 and processing-3.0 are not backward compatible. Furthermore since propane was designed to use jruby-9.0.0.0+ from the outset, it makes use of the more literate ruby-2.3 syntax (although the original ruby-processing will run with jruby-9.1.12.0, the examples and the ruby-processing library are all based on ruby-1.9.3 syntax).

### JRuby

Unlike `JRubyArt` and `ruby-processing` it is not practical to run `propane` sketches without doing a system install of jruby. It is highly recommended that you create a symbolic link to `/usr/bin/jruby`, this is the easiest way to ensure that `jruby` is on you `PATH` and you can then make sketches executable with `#!/usr/bin/env jruby` (and `chmod +x`). Further you will be able to run sketches from `atom` using the `script` plugin (without needing to start `atom` from the command-line to pick up environmental variables).

### Pure JRuby Setup Archlinux ###

Install Software as required:-

```bash
sudo pacman -S jdk8-openjdk # installs openjdk
sudo pacman -S java-openjfx # installs openjfx
sudo pacman -S jruby # installs jruby
```

Install propane

```bash
jruby -S gem install propane # or jgem install propane
jruby -S gem install toxiclibs # optional
jruby -S gem install pbox2d # optional
jruby -S gem install geomerative # optional
```

Install Samples

```bash
propane --install Samples
```

Install Sound library

```bash
propane --install Sound
```

Install Video library

```bash
propane --install Video
# requires gstreamer-0.10 and does not work on Archlinux, install instead glvideo library that supports gstreamer-1.0 and hence hardware acceleration, unfortunately this library still need some work
```

### Running examples

To run a bunch of the samples as a demo:-

```bash
cd ~/propane_samples
rake # autoruns files
cd ~/propane_samples/contributed # navigate to say contributed folder
jruby jwishy.rb # run the JWishy sketch, using an installed jruby
cd ~/propane_samples/processing_app/topics/shaders
rake # autoruns shader sketches
jruby monjori.rb # run the Monjori sketch with jruby-complete
```

### Creating your own sketch

All we ask is that you obey the ruby filename convention (ie snakecase) and we can create a template sketch for you as follows:-

```bash
propane --create fred_sketch 200 200 # creates a bare sketch fred_sketch.rb (see below)
vim fred_sketch.rb # other editors are available
:!jruby % # from vim runs the sketch
```

You may want to try other [development environments][editor] eg atom, emacs or even netbeans. Needless to say your distro can install these for you, but they need a bit of post install love get the best out of them (vim in the main just works, and is super light weight).

```ruby
#!/usr/bin/env jruby
# frozen_string_literal: false
require 'propane'

class FredSketch < Propane::App
  def setup
    sketch_title 'Fred Sketch'
  end

  def draw

  end

  def settings
    size 200, 200
    # smooth # here
  end
end

FredSketch.new
```

PS: `propane -c fred` also works with a bare template defaults, to `size 0, 0`


### Running examples

To run a bunch of the samples as a demo:-

```bash
cd ~/propane_samples
rake # autoruns a bunch of files as a demo
cd ~/propane_samples/contributed # for example
rake # autoruns files in contributed folder
jruby jwishy.rb # run the JWishy sketch, using an installed jruby
cd ~/propane_samples/processing_app/topics/shaders
rake # autoruns shader sketches
jruby monjori.rb # run single shader sketch
```

[api]: {{site.github.url}}/methods/processing_api.html
[ben]:https://blog.engineyard.com/2015/getting-started-with-ruby-processing
[processing]:https://processing.org/
[gem]:https://rubygems.org/gems/ruby-processing
[propane]:https://rubygems.org/gems/propane
[changes]:https://github.com/processing/processing/wiki/Changes-in-3.0
[official]:https://processing.org/download/?processing
[platforms]:https://github.com/processing/processing/wiki/Supported-Platforms
[editor]:{{site.github.url}}/editors/
[sound]:https://monkstone.github.io/_posts/minim
[video]:https://monkstone.github.io/_posts/create_video
