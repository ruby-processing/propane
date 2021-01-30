---
layout: post
title:  "Getting Started M1 Based Mac"
date:   2021-01-26 06:00:00
categories: jruby_art update
permalink: /mac_arm64/
---

### Getting Started With Propane ###

If you love to code because it is a creative process, then you should give Propane a try because it can be used to create music, art, animations, videos and much more. Also since it is based on the latest [Processing][processing] you can access a vast range of libraries to make the difficult things easier.

### Why Propane? ###

Since Processing already comes wrapped in an easy-to-use package, you may ask: "why should I bother with Propane?"

The answer: if you know how to write Ruby, you can use Processing as a visual presentation layer of a much more complex program. Games, interactive art exhibits, innovative music projects, anything you can imagine; it's all at your fingertips.

Additionally, you don't have to declare types, voids, or understand the differences between floats and ints to get started, as you do in pure Processing.

Although there are some drawbacks to using the Ruby version Processing (slower start up time, and sometimes performance), having Ruby's API available to translate your ideas into sketches more than makes up for them.

#### Native Support ####

It is quite possible that P2D and P3D sketches won't run in Rosetta emulation of Intel on Mac Silica. But if it works OK there is no to follow instructions here. However there are known issues with [vanilla-processing][forum].

#### Java ####

For native java support install jdk11+ from [Azul][azul]

#### JRuby ####

```bash
brew install jruby # installs latest Propane
```
You don't need `rvm` or `rbenv` for propane since we call `jruby` directly when needed.

#### Propane ####

```bash
jgem install propane --pre
```

Install other gems as required
```bash
jgem install toxiclibs # optional
jgem install pbox2d # optional
jgem install geomerative # optional
jgem install wordcram # optional
```


If you __haven't__ installed Propane before you should:-

```bash
propane --install # no arguments
```
To configure Propane, install samples, and also install jruby-complete

If you __have__ installed Propane before you should:-

Use:-

```bash
propane --help # or -h to show command line options
# or
propane --check # or -? to check configuration
```

### Running examples

To explore the installed examples:-
```bash
cd ~/propane_samples
rake # to run examples randomly as a demo
# or check available tasks with
rake --tasks
# use a task to randomly run a group of sketches eg
rake shaders # runs the shader examples
```
#### Create your own sketches

To create a simple sketch:-
```bash
propane -c fred 200 200 # sketch name=Fred width=200 height=200 mode=default
propane -c my_sketch 300 300 p2d # sketch name=MySketch width=300 height=300 mode=P2D
```
Edit `fred.rb` or `my_sketch.rb` with your favourite editor preferably `vim`, `emacs` or `atom`.

To run sketch using the command line

```bash
jruby --dev fred.rb
```

To run a sketch from editor see [editors][editors]

Read more about using the [processing api here][api]

Read more about using the [processing api here][api]

[azul]:https://www.azul.com/downloads/zulu-community/?package=jdk
[propane]:https://rubygems.org/gems/propane
[api]: {{site.github.url}}/methods/processing_api
[brew]:https://brew.sh/
[editors]:http://ruby-processing.github.io/Propane/editors.html
[ben]:https://blog.engineyard.com/2015/getting-started-with-ruby-processing
[processing]:https://processing.org/
[gem]:https://rubygems.org/gems/ruby-processing
[Propane]:https://rubygems.org/gems/jruby_art
[changes]:https://github.com/processing/processing/wiki/Changes-in-3.0
[official]:https://processing.org/download/?processing
[platforms]:https://github.com/processing/processing/wiki/Supported-Platforms
[bitnami]:https://bitnami.com/stack/jruby/installer
[sound]:https://monkstone.github.io/_posts/minim
[video]:https://monkstone.github.io/_posts/create_video
[casey]:https://github.com/processing/processing/wiki/FAQ
[wget]:http://gnuwin32.sourceforge.net/packages/wget.htm
[forum]:https://discourse.processing.org/t/problems-with-p2d-and-p3d-renderers-with-new-apple-m1-processor/27287
