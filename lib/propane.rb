# encoding: utf-8
# frozen_string_literal: false
unless defined? PROPANE_ROOT
  $LOAD_PATH << File.expand_path(File.dirname(__FILE__))
  PROPANE_ROOT = File.expand_path(File.dirname(__FILE__) + '/../')
end
Dir["#{PROPANE_ROOT}/lib/*.jar"].each do |jar|
  require jar
end
require 'propane/version'
require 'propane/app'
require 'propane/helpers/numeric'
