---
layout: post
title:  "LibraryProxy"
keywords: processing, abstract class, library
---
The purpose of the `LibraryProxy` class is to provide access to [processing reflection][library] methods:-

In the sketch we must `load_library :library_proxy` then our ruby library class can inherit from `LibraryProxy` as below, but it must implement all the abstract methods, even if method is empty

```ruby
class MyClass < LibraryProxy
  # access to pre, draw, etc
end
```

Example sketch:-
```ruby
#!/usr/bin/env jruby
require 'propane'

class LibraryProxySketch < Propane::App

  # A simple demonstration of vanilla processing 'reflection' methods using
  # propane :library_proxy. See my_library.rb code for the guts.
  load_library :library_proxy
  require_relative 'my_library'

  def settings
    size 300, 200
  end

  def setup
    sketch_title 'Reflection Voodoo Proxy'
    MyLibrary.new self
    no_loop
  end

  def draw
    fill(0, 0, 200)
    ellipse(170, 115, 70, 100)
  end
end

LibraryProxySketch.new
```
my_library.rb

```ruby
# This class demonstrates how by inheriting from the abstract class LibraryProxy
# we can access 'pre', 'draw' and 'post' (Note we need a post method even
# though it is empty)
class MyLibrary < LibraryProxy
  attr_reader :app

  def initialize(parent)
    @app = parent
  end

  def pre
    background(100)
  end

  def draw
    app.fill(200, 100)
    app.ellipse(150, 100, 200, 60)
  end

  def post # required but empty method is fine
  end
end
```

![library_proxy_sketch.rb]({{ site.github.url }}/assets/library_proxy.png)

[library]:https://github.com/processing/processing/wiki/Library-Basics
