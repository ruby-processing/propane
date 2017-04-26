# frozen_string_literal: false
require 'java'
unless defined? PROPANE_ROOT
  $LOAD_PATH << File.expand_path(File.dirname(__FILE__))
  PROPANE_ROOT = File.expand_path(File.dirname(__FILE__) + '/../')
end
Dir["#{PROPANE_ROOT}/lib/*.jar"].each do |jar|
  require jar
end
require_relative 'propane/app'
