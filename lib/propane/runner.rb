# frozen_string_literal: false
require 'optparse'
require_relative 'version'

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
      create if options[:create]
      install(filename) if options[:install]
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
        message = '<Samples><GLVideo><Video><Sound> Install samples or library'
        opts.on('-i', '--install', message) do
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
      SketchWriter.new(File.basename(filename, '.rb'), argc).write
    end

    def show_version

      v_format = "Propane version %s\nJRuby version %s"
      puts format(v_format, Propane::VERSION, JRUBY_VERSION)
    end

    def show_version
      require 'erb'
      require_relative 'helpers/version_error'
      raise JDKVersionError.new if ENV_JAVA['java.specification.version'] < '11'
      template = ERB.new <<-EOF
        propane version <%= Propane::VERSION %>
        JRuby version <%= JRUBY_VERSION %>
      EOF
      puts template.result(binding)
    end

    def install(library)
      choice = library.downcase
      valid = Regexp.union('samples', 'sound', 'video', 'glvideo')
      return warn format('No installer for %s', choice) unless valid =~ choice
      system "cd #{PROPANE_ROOT}/vendors && rake download_and_copy_#{choice}"
    end
  end # class Runner
end # module Propane
