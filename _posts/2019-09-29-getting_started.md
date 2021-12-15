---
layout: post
title:  "Getting Started on ArchLinux"
date:  2019-09-29 06:00:00
permalink: /linux_started/
---

### Getting Started With propane ArchLinux ###

If you love to code because it is a creative process, then you should give propane a try because it can be used to [create music][sound], art, animations, [videos][video] and much more. Also since it is based on the latest [Processing][processing] you can access a vast range of libraries to make the difficult things easier.

### What Is Processing? ###

Processing is a simple language, based on Java, that you can use to create digital graphics. It's easy to learn, fun to use, and has an amazing online community comprised of programmers, visual artists, musicians, and interdisciplinary artists of all kinds.

Processing was built by Casey Reas and Benjamin Fry, two protegés of interdisciplinary digital art guru John Maeda at the MIT Media Lab.

Since the project began in 2001, it's been helping teach people to program in a visual art context using a simplified version of Java. It comes packaged as an IDE that can be downloaded and used to create and save digital art “sketches”.

In 2009, Jeremy Ashkenas (aka jashkenas, creator of Backbone.JS, Underscore.JS, and Coffeescript), published the original [ruby-processing gem][gem]. It wraps Processing in a shim that makes it even easier to get started if you know Ruby. It has been since updated to use processing-2.2.1 by Martin Prout (final version using jruby-1.7.27 corresponding to ruby-1.9.3 syntax), NB: no more releases are expected, and ruby-processing is not compatible with processing-3.0+.

In 2016, Martin Prout (aka monkstone) published the [propane gem][propane], a stand alone version of ruby-processing, since using the core.jar from processing (recently using the processing-4.0 version see changelog) and jruby-9.3.2.0+ (ruby-2.5 syntax)

### Why propane? ###

__The answers:__ You can dabble with the latest `processing framework` (in ruby) without even needing to install `vanilla processing` (and its embded jdk).  If you know how to write Ruby, you can use Processing as a visual presentation layer of a much more complex program. Games, interactive art exhibits, innovative music projects, anything you can imagine; it's all at your fingertips.

Additionally, you don't have to declare types, voids, or understand the differences between floats and ints to get started, as you do in pure Processing.

Although there are some drawbacks to using the Ruby version Processing (slower start up time, and sometimes performance), having Ruby's API available to translate your ideas into sketches more than makes up for them.

Why was ruby-processing not updated to use processing3.0+? The [major changes][changes] between processing-2.2.1 and processing-3.0 are not backward compatible. Furthermore since propane is designed to use jruby-9.3.2.0+ from the outset, it can make use of the more literate ruby-2.6 syntax.

### Java

Use OpenJDK jdk17+ (Oracle jdk will probably work _untested_ as will ibm j9 and graal vm).

### JRuby

Unlike `JRubyArt` and `ruby-processing` it is not practical to run `propane` sketches without doing a system install of jruby. It is highly recommended that you create a symbolic link to `/usr/bin/jruby`, this is the easiest way to ensure that `jruby` is on you `PATH` and you can then make sketches executable with `#!/usr/bin/env jruby` (and `chmod +x`). Further you will be able to run sketches from `atom` using the `script` plugin (without needing to start `atom` from the command-line to pick up environmental variables). See also [JRuby downloads][jruby].

### Pure JRuby Setup Archlinux ###

Install Software as required:-

```bash
sudo pacman -S jdk-openjdk # installs openjdk17
sudo pacman -S java-openjfx # installs openjfx
sudo pacman -S jruby # installs jruby-9.3.2.0+
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

Install Video library _the past but stable?_

```bash
propane --install Video
# Install latest beta version requires gstreamer-1.0+
```

### Running examples ###

To explore the installed examples:-
```bash
cd ~/propane_samples
rake # to run examples randomly as a demo
# or check available tasks with
rake --tasks
# use a task to randomly run a group of sketches eg
rake shaders # runs the shader examples
```

To create a simple sketch:-
```bash
propane -c fred 200 200 # sketch name=Fred width=200 height=200 mode=default
propane -c my_sketch 300 300 p2d # sketch name=MySketch width=300 height=300 mode=P2D
```
Edit `fred.rb` or `my_sketch.rb` with your favourite editor preferably `vim`, `emacs` or `atom`.

To run sketch using the command line

```bash
jruby fred.rb
```

To run a sketch from editor see [editors][editors]

[api]: {{site.github.url}}/methods/processing_api.html
[ben]:https://blog.engineyard.com/2015/getting-started-with-ruby-processing
[processing]:https://processing.org/
[gem]:https://rubygems.org/gems/ruby-processing
[propane]:https://rubygems.org/gems/propane
[changes]:https://github.com/processing/processing/wiki/Changes-in-3.0
[official]:https://processing.org/download/?processing
[wiki]:https://github.com/processing/processing/wiki/Supported-Platforms#java-9
[platforms]:https://github.com/processing/processing/wiki/Supported-Platforms
[editor]:{{site.github.url}}/editors/
[sound]:https://monkstone.github.io/_posts/minim
[video]:https://monkstone.github.io/_posts/create_video
[adopt]:https://adoptium.net/
[download]:https://www.jruby.org/download
[propane]:http://ruby-processing.github.io/java/JRubyArt_propane/
[jruby]:http://ruby-processing.github.io/jruby/propane/
