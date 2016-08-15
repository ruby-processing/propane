---
layout: page
title: About
permalink: /about/
---

## What is Propane? ##

It is ruby wrapper around processing-3.1+, that includes the core.jar (also includes appropriate jogl jars for linux64 and mac), and so is independent from any vanilla processing installation.  Someone might like to try including Windows or raspberry-pi binaries?

## System requirements ##

Depends on jdk8+ (Oracle stopped supporting jdk7+ ages ago, unless you pay for it). Expects an installed jruby runtime (_cf_ ruby-processing where it is optional), jruby-9.1.2.0 or a later release preferred to run.

## Usage ##

Sketches should `require 'propane'` and should be class wrapped, with sketch class inheriting from `Propane::App`. Creating a new instance, is the regular way to get you sketch to run:-
{% highlight ruby %}
require 'propane'

class MySketch < Propane::App
   def settings
     size 200, 200 # size, mode, smooth etc here
   end

   def setup
     sketch_title 'My Sketch'
     # do initialize stuff here
   end


   def draw
     # do fancy stuff here in draw loop
   end
end

MySketch.new
{% endhighlight %}

{% highlight bash %}
# regular
jruby my_sketch.rb # using an installed jruby
{% endhighlight %}
## Why Propane ##

- It is a gas (C<sub>3</sub>H<sub>8</sub>), used for cooking _al fresco_ what could be cooler
- Starts with `pro` _p5_ is shunned (_well apart from p5.js which is considered cool_), over used
- Ends with `pane` an allusion to `window`
- Watch mode is to be implemented (Use [JRubyArt][jruby_art]) or you could try the [live]({{ site.github.url }}/live) mode.

[jruby_art]:https://github.com/ruby-processing/JRubyArt