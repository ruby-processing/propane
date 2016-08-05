gem 'minitest'      # don't use bundled minitest
require 'minitest/autorun'
require 'minitest/pride'


require_relative '../lib/propane/creators/sketch_writer'

CLASS_SKETCH = <<~CODE
# frozen_string_literal: false
require 'propane'

class FredSketch < Propane::App
  def setup
    size 200, 200, P2D
  end

  def draw

  end
end

CODE

class SketchWriterTest < Minitest::Test
  ParamMethods = Struct.new(:name, :class_name, :sketch_size)
  
  def setup
    @param = ParamMethods.new(
      'fred_sketch',
      'FredSketch',
      'size 200, 200, P2D'
    )
  end

  def test_parameter_new
    param = SketchParameters.new(name: 'fred_sketch', args: %w(200 200 p2d))
    assert_equal 'size 200, 200, P2D', param.sketch_size
    assert_equal 'FredSketch', param.class_name
  end

  def test_class
    result = CLASS_SKETCH.split(/\n/, -1)
    class_lines = ClassSketch.new.code(@param)
    class_lines.each_with_index do |line, i|
      assert_equal result[i], line
    end
  end
end
