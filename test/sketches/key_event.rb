#!/usr/bin/env jruby
require 'propane'


class CustomProxySketch < Propane::App

  # A simple demonstration of vanilla processing 'reflection' methods using
  # propane :library_proxy. See my_library.rb code for the guts.
  load_libraries :library_proxy, :my_library

  attr_reader :visible

  def settings
    size 300, 200
    @visible = false
  end

  def setup
    sketch_title 'Reflection Voodoo Proxy'
    MyLibrary.new self
  end

  def hide(val)
    @visible = !val
  end

  def draw
    if visible
      fill(0, 0, 200)
      ellipse(170, 115, 70, 100)
    else
      background 0
    end
  end
end

CustomProxySketch.new
