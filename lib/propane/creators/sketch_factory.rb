# frozen_string_literal: true

require_relative 'sketch_writer'

class SketchFactory
  NAMES = %w[One Two Three].freeze
  def initialize(_argc)
    NAMES.each do |name|
      SketchWriter.new(File.basename(name, '.rb'), width: 300, height: 300).write
    end
  end
end

SketchFactory.new(File.join(ENV['HOME'], 'test'))
