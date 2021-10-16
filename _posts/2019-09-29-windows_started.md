---
layout: post
title:  "Getting Started on Windows"
date:   2019-09-29 06:00:00
permalink: /windows_start/
---

### Getting Started With propane

If you love to code because it is a creative process, then you should give propane a try because it can be used to create [music][sound], art, animations, [videos][video] and much more. Also since it is based on the latest [Processing][processing] you can access a vast range of libraries to make the difficult things easier.

### Why propane?

You can dabble with the latest `processing framework` (in ruby) without even needing to install `vanilla processing` (and its embded jdk).

Additionally, you don't have to declare types, voids, or understand the differences between floats and ints to get started, as you do in pure Processing.

Although there are some drawbacks to using the Ruby version Processing (slower start up time, and sometimes performance), having Ruby's API available to translate your ideas into sketches more than makes up for them.

### Setup

Setting propane is dead easy. The propane gem relies on jruby and arc_ball.gem, you don't need rvm or rvm for this don't let anyone persuade that you do.

### Java

Install [wget][wget] which is also available as [cygwin][cygwin] package, openjdk (11.0.3+), and some version of ruby-2.4+ preferably jruby-9.3.1.0+. If you encounter linkage problems it might be worth looking the [AdoptOpenJDK][adopt] distribution.

### JRuby

Unlike `JRubyArt` and `ruby-processing` it is not possible to run `propane` without a system install of jruby. It is highly recommended that you create a symbolic link to `/usr/bin/jruby`, it is the easiest way to ensure that `jruby` is on you `PATH` and you can then make sketches executable with `#!/usr/bin/env jruby` (and `chmod +x`). Further you will be able to run sketches from `atom` using the `script` plugin (without needing to start `atom` from the command-line to pick up environmental variables). See also [JRuby downloads][downloads] for latest releases.

### propane

```bash
jgem install propane # or `jruby -S gem`, use rvm at your own risk...
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
propane --install video
# experimental, expected to work on Raspberry-Pi debian-linux and Windows
```

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
jruby monjori.rb # run single shader sketch, since propane-1.0
```

### Creating your own sketch

All we ask is that you obey the ruby filename convention (ie snakecase) and we can create a template sketch for you as follows:-

```bash
propane --create fred_sketch 200 200 # creates a propane sketch fred_sketch.rb (see below)
vim fred_sketch.rb
:!jruby % # from vim runs the sketch
```

other [editors][editors] are available

```ruby
# frozen_string_literal: true
require 'propane'

class FredSketch
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

### Running examples

To run a bunch of the samples as a demo, __assuming powershell or cygwin__:-

```bash
cd ~/propane_samples
rake # autoruns a bunch of files as a demo
cd ~/propane_samples/contributed # for example
rake # autoruns files in contributed folder
jruby jwishy.rb # run the JWishy sketch, using an installed jruby
cd ~/propane_samples/processing_app/topics/shaders
rake # autoruns shader sketches
jruby monjori.rb # run single shader sketch, since propane-1.0
```

### Creating your own sketch

All we ask is that you obey the ruby filename convention (ie snakecase) and we can create a template sketch for you as follows:-

```bash
propane --create fred_sketch 200 200 # creates a propane sketch fred_sketch.rb (see below)
vim fred_sketch.rb
:!jruby % # from vim runs the sketch
```

other [editors][editors] are available

```ruby
# frozen_string_literal: true
require 'propane'

class FredSketch
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

PS: `propane -c fred` also works with a default size 0

Read more about using the [processing api here][api]

[report]:https://github.com/processing/processing/issues/5006
[api]: {{site.github.url}}/methods/processing_api.html
[editors]:{{site.github.url}}/editors/
[ben]:https://blog.engineyard.com/2015/getting-started-with-ruby-processing
[processing]:https://processing.org/
[gem]:https://rubygems.org/gems/ruby-processing
[propane]:https://rubygems.org/gems/propane
[changes]:https://github.com/processing/processing/wiki/Changes-in-3.0
[official]:https://processing.org/download/?processing
[platforms]:https://github.com/processing/processing/wiki/Supported-Platforms
[bitnami]:https://bitnami.com/stack/jruby/installer
[sound]:https://monkstone.github.io/_posts/minim
[video]:https://monkstone.github.io/_posts/create_video
[adopt]:https://adoptium.net/
[download]:https://www.jruby.org/download
[wget]:http://gnuwin32.sourceforge.net/packages/wget.htm
