gem 'minitest'      # don't use bundled minitest
require 'minitest/autorun'
require 'minitest/pride'


require_relative '../lib/propane/creators/sketch_class'

CLASS_SKETCH = <<~CODE
# frozen_string_literal: false
require 'propane'

class FredSketch < Propane::App
  def settings
    size 200, 200
  end

  def setup
    sketch_title 'Fred Sketch'
  end

  def draw

  end
end

FredSketch.new

CODE

BARE_SKETCH = <<~CODE
def settings
  size 200, 200, P2D
end

def setup
  sketch_title 'Fred Sketch'
end

def draw

end
  
CODE

class SketchClassTest < Minitest::Test
  
  def setup
    @basic = SketchClass.new(name: 'fred_sketch', width: 200, height: 200)
    @sketch = SketchClass.new(name: 'fred_sketch', width: 200, height: 200, mode: 'p2d')
  end
  
  def test_class
    result = CLASS_SKETCH.split(/\n/, -1)
    class_lines = @sketch.lines
    class_lines.each_with_index do |line, i|
      assert_equal result[i], line
    end
  end

  def test_indent
    assert_equal '  indent', @sketch.indent('indent')
  end

  def test_size
    assert_equal '    size 200, 200, P2D', @sketch.size
    assert_equal '    size 200, 200', @basic.size
  end

  def test_sketch_title
    assert_equal "    sketch_title 'Fred Sketch'", @sketch.sketch_title
  end

  def test_class
    assert_equal "FredSketch", @sketch.sketch_class
  end

  def test_class_new
    assert_equal "FredSketch.new", @sketch.sketch_new
  end

  def test_method_lines
    result = CLASS_SKETCH.split(/\n/, -1)
    @basic.method_lines('settings', @basic.size).each_with_index do |line, i|
      assert_equal result[i + 4], line
    end
  end


  def test_sketch_class
    assert_equal "class FredSketch < Propane::App", @basic.class_sketch
  end
end
