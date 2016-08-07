# frozen_string_literal: false
# The SketchParameters class knows how to format, size, title & class name
class SketchParameters
  attr_reader :name, :args
  def initialize(name:, args:)
    @name = name
    @args = args
  end

  def class_name
    name.split('_').collect(&:capitalize).join
  end

  def sketch_title
    human = name.split('_').collect(&:capitalize).join(' ')
    format("sketch_title '%s'", human)
  end

  def sketch_size
    mode = args.length == 3 ? format(', %s', args[2].upcase) : ''
    return 'size 200, 200' if args.empty?
    format('size %d, %d%s', args[0].to_i, args[1].to_i, mode)
  end
end

# The file writer can write a sketch when given instance of Sketch type
class SketchWriter
  attr_reader :file, :param

  def initialize(path, args)
    @param = SketchParameters.new(name: path, args: args)
    @file = format('%s/%s.rb', File.dirname(path), path)
  end

  def write(creator)
    sketch = creator.code(param)
    File.open(file, 'w+') { |f| f.write sketch.join("\n") }
  end
end

# A simple class wrapped sketch
class ClassSketch
  INDENT ||= '  '
  def code(param)
    lines = [
      '# frozen_string_literal: false',
      "require 'propane'",
      ''
    ]
    lines << format('class %s < Propane::App', param.class_name)
    lines.concat method_lines('settings', param.sketch_size)
    lines.concat method_lines('setup', param.sketch_title)
    lines.concat method_lines('draw', '')
    lines << 'end'
    lines.concat new(param)
  end

  private

  def method_lines(name, content)
    one = format('%sdef %s', INDENT, name)
    two = content.empty? ? '' : format('  %s%s', INDENT, content)
    three = format('%send', INDENT)
    return [one, two, three] if /draw/ =~ name
    [one, two, three, '']
  end

  def new(param)
    ['', format('%s.new', param.class_name)]
  end
end
