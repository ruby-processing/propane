# frozen_string_literal: false
require "#{PROPANE_ROOT}/lib/propane"
require "#{PROPANE_ROOT}/lib/propane/app"
require 'optparse'

module Propane
  java_import 'monkstone.WatchSketchDir'
  java_import 'java.nio.file.StandardWatchEventKinds'
  # Utility class to handle the different commands that the 'rp5' command
  # offers. Able to run, watch, live, create, app, and unpack
  class Runner
    attr_reader :options, :argc, :filename

    def initialize
      @options = {}
    end

    # Start running a propane sketch from the passed-in arguments
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
        opts.on('-i', '--install', 'Installs jruby-complete') do
          options[:install] = true
        end

        options[:watch] = false
        opts.on('-w', '--watch', 'Watch the sketch (WIP)') do
          options[:watch] = true
        end

        options[:run] = false
        opts.on('-r', '--run', 'Run the sketch using jruby-complete') do
          options[:run] = true
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
    
    def watch_sketch
      run_sketch
      root = File.absolute_path(File.dirname(filename))
      watcher = WatchSketchDir.watch(root)
      count = 0 # guard against a duplicate event
      watcher.add_listener do |event|
        if event.kind == StandardWatchEventKinds::ENTRY_MODIFY 
          if count == 0       
            puts 'reloading sketch...' 
            run_sketch          
          end
          count += 1
          count = 0 if count == 2
        end
      end  
    end

    def run_sketch
      # root = File.absolute_path(File.dirname(filename))
      # sketch = File.join(root, filename)
      sketch = File.join(SKETCH_ROOT, filename)
      warn_format = 'File %s does not not Exist!'
      return warn(format(warn_format, sketch)) unless File.exist?(sketch)
      command = [
      'java',
      '-cp',
      "#{PROPANE_ROOT}/lib/ruby/jruby-complete.jar",
      'org.jruby.Main',
      sketch.to_s
      ].flatten
      exec(*command)
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
