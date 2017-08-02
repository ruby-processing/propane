#!/usr/bin/env jruby
require 'propane'


class CustomProxySketch < Propane::App

  # A simple demonstration of vanilla processing 'reflection' methods using
  # propane :library_proxy. See my_library.rb code for the guts.
  load_libraries :custom_proxy, :my_library

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

CustomProxySketch.new
