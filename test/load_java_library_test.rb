# frozen_string_literal: true
require 'java'
require_relative 'test_helper'
require_relative '../lib/propane'

class TestSketch < Propane::App
  load_libraries :local_library # :sound
  # include_package 'processing.sound'
  include_package 'local'
  attr_reader :local # :brown_noise

  def settings
    size 100, 100
  end

  def setup
    sketch_title 'Sketch Test'
    # @brown_noise = BrownNoise.new(self)
    @local = LocalJavaLibrary.new
  end

  def draw
    exit if frame_count > 30
  end
end



class LoadJavaLibrary < Minitest::Test
  def setup
    @propane_sketch = TestSketch.new
  end

  def test_libraries_installed
    # require File.join(ENV['HOME'], '.propane', 'libraries', 'sound', 'library', 'sound.jar')
    # assert_kind_of(Java::ProcessingSound::BrownNoise, @propane_sketch.brown_noise)
  end

  def tear_down
    @propane_sketch == nil
  end
end
