# frozen_string_literal: false
require "#{PROPANE_ROOT}/lib/propane"
require "#{PROPANE_ROOT}/lib/propane/app"
require 'optparse'

module Propane
  # Utility class to handle the different commands that the 'propane' offers
  class Runner
    attr_reader :options, :argc, :filename

    def initialize
      @options = {}
    end

    # Start running a propane command from the passed-in arguments
    def self.execute
      runner = new
      runner.parse_options(ARGV)
      runner.execute!
    end

    # Dispatch central.
    def execute!
      show_help if options.empty?
      show_version if options[:version]
      run_sketch if options[:run]
      watch_sketch if options[:watch]
      create if options[:create]
      install if options[:install]
    end

    # Parse the command-line options. Keep it simple.
    def parse_options(args)
      opt_parser = OptionParser.new do |opts|
        # Set a banner, displayed at the top
        # of the help screen.
        opts.banner = 'Usage: propane [options] [<sketch.rb>]'

        # Define the options, and what they do
        options[:version] = false
        opts.on('-v', '--version', 'Propane Version') do
          options[:version] = true
        end

        options[:install] = false
        opts.on('-i', '--install', 'Installs propane samples') do
          options[:install] = true
        end
        
        options[:create] = false
        opts.on('-c', '--create', 'Create new sketch outline') do
          options[:create] = true
        end

        # This displays the help screen, all programs are
        # assumed to have this option.
        opts.on('-h', '--help', 'Display this screen') do
          puts opts
          exit
        end
      end
      @argc = opt_parser.parse(args)
      @filename = argc.shift
    end
    
    def create
      require_relative 'creators/sketch_writer'
      sketch = ClassSketch.new
      SketchWriter.new(File.basename(filename, '.rb'), argc).write(sketch)
    end

    def show_version
      v_format = "Propane version %s\nJRuby version %s"
      puts format(v_format, Propane::VERSION, JRUBY_VERSION)
    end

    def install
      system "cd #{PROPANE_ROOT}/vendors && rake"
    end
  end # class Runner
end # module Propane