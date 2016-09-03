# frozen_string_literal: false
# the sketch class
class SketchClass
  attr_reader :name, :width, :height, :mode

  def initialize(name:, width: 150, height: 150, mode: nil)
    @name, @width, @height, @mode = name, width, height, mode
  end

  def class_sketch
    format('class %s < Propane::App', sketch_class)
  end

  def sketch_class
    name.split('_').collect(&:capitalize).join
  end

  def sketch_new
    format('%s.new', sketch_class)
  end

  def indent(line)
    format('  %s', line)
  end

  def size
    return format('    size %d, %d', width.to_i, height.to_i) if mode.nil?
    format('    size %d, %d, %s', width.to_i, height.to_i, mode.upcase)
  end

  def sketch_title
    human = name.split('_').collect(&:capitalize).join(' ')
    format("    sketch_title '%s'", human)
  end

  def method_lines(name, content = '')
    return [format('  def %s', name), content, '  end'] if content.empty?
    [format('  def %s', name), content, '  end', '']
  end

  def lines
    lines = [
      '# frozen_string_literal: false',
      "require 'propane'",
      '',
      class_sketch
    ]
    lines.concat method_lines('settings', size)
    lines.concat method_lines('setup', sketch_title)
    lines.concat method_lines('draw')
    lines << 'end'
    lines << sketch_new
  end
end
