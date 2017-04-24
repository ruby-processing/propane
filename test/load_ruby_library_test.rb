# frozen_string_literal: true
require 'java'
require_relative 'test_helper'
require_relative '../lib/propane'

class TestSketch < Propane::App
  load_libraries :local_ruby, :boids
  attr_reader :boids, :local

  def settings
    size 100, 100
    @local = LocalRubyLibrary.new
    @boids = Boids.flock(n: 2, x:  25, y: 25, w: 100, h: 100)
  end

  def setup
    sketch_title 'Sketch Test'
  end

  def draw
    exit if frame_count > 30
  end
end



class SpecTest < Minitest::Test
  def setup
    @propane_sketch = TestSketch.new
  end

  def test_libraries_installed

    require_relative '../library/boids/boids'
    require_relative 'library/local_ruby/local_ruby'
    assert_kind_of(Boids, @propane_sketch.boids)
    assert_kind_of(LocalRubyLibrary, @propane_sketch.local)
  end

  def tear_down
    @propane_sketch == nil
  end
end
