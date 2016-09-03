# frozen_string_literal: false
require_relative 'sketch_class'

# The file writer can write a sketch when given instance of Sketch type
class SketchWriter
  attr_reader :file, :sketch

  def initialize(path, args)
    @sketch = SketchClass.new(
      name: path,
      width: args[0].to_i,
      height: args[1].to_i,
      mode: args[2]
    )
    @file = format('%s/%s.rb', File.dirname(path), path)
  end

  def write
    File.open(file, 'w+') { |f| f.write sketch.lines.join("\n") }
  end
end
