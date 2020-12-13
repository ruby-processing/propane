# frozen_string_literal: true

require 'java'
unless defined? PROPANE_ROOT
  $LOAD_PATH << File.dirname(__dir__)
  PROPANE_ROOT = File.dirname(__dir__)
end
Dir["#{PROPANE_ROOT}/lib/*.jar"].sort.each do |jar|
  require jar
end
require "#{PROPANE_ROOT}/lib/propane/app"
require "#{PROPANE_ROOT}/lib/propane/helpers/numeric"