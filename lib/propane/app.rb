# frozen_string_literal: false
require_relative 'helper_methods'
require_relative 'library_loader'

# A wrapper module for the processing App
module Propane
  include_package 'processing.core' # imports the processing jar.
  # Load vecmath, fastmath and mathtool modules
  Java::Monkstone::PropaneLibrary.load(JRuby.runtime)
  # We may change this
  module Render
    java_import 'monkstone.vecmath.AppRender'
    java_import 'monkstone.vecmath.ShapeRender'
  end

  SKETCH_ROOT = File.absolute_path('.')

  # This class is the base class the user should inherit from when making
  # their own sketch.
  #
  # i.e.
  #
  # class MySketch < Propane::App
  #
  #   def draw
  #     background rand(255)
  #   end
  #
  # end

  # Watch the definition of these methods, to make sure
  # that Processing is able to call them during events.
  METHODS_TO_ALIAS ||= {
    mouse_pressed: :mousePressed,
    mouse_dragged: :mouseDragged,
    mouse_clicked: :mouseClicked,
    mouse_moved: :mouseMoved,
    mouse_released: :mouseReleased,
    key_pressed: :keyPressed,
    key_released: :keyReleased,
    key_typed: :keyTyped
  }.freeze

  # All sketches extend this class
  class App < PApplet
    include Math, MathTool, HelperMethods
    # Alias some methods for familiarity for Shoes coders.
    alias oval ellipse
    alias stroke_width stroke_weight
    alias rgb color
    alias gray color
    attr_reader :title, :arguments, :options
    # App should be instantiated with an optional list of options
    # and array of arguments.
    #
    # App.new(width: 500, height: 500, fullscreen: true)
    #
    class << self
      # Handy getters and setters on the class go here:
      attr_accessor :sketch_class, :library_loader

      def load_libraries(*args)
        library_loader ||= LibraryLoader.new
        library_loader.load_library(*args)
      end
      alias load_library load_libraries

      def library_loaded?(library_name)
        library_loader.library_loaded?(library_name)
      end

      def load_ruby_library(*args)
        library_loader.load_ruby_library(*args)
      end

      def load_java_library(*args)
        library_loader.load_java_library(*args)
      end

      # When certain special methods get added to the sketch, we need to let
      # Processing call them by their expected Java names.
      def method_added(method_name) #:nodoc:
        return unless METHODS_TO_ALIAS.key?(method_name)
        alias_method METHODS_TO_ALIAS[method_name], method_name
      end
    end

    def library_loaded?(library_name)
      self.class.library_loaded?(library_name)
    end

    def initialize(options = {}, arguments = [])
      # Guard against invalid input.
      proxy_java_fields
      raise TypeError unless options.is_a? Hash
      raise TypeError unless arguments.is_a? Array
      # Set up the sketch.
      super()
      $app = self
      @arguments = arguments
      @options   = options
      configure_sketch
      run_sketch
    end

    def size(*args)
      w, h, mode = *args
      @width ||= w
      @height ||= h
      @render_mode ||= mode
      import_opengl if /opengl/ =~ mode
      super(*args)
    end

    def data_path(dat)
      dat_root = File.join(SKETCH_ROOT, 'data')
      Dir.mkdir(dat_root) unless File.exist?(dat_root)
      File.join(dat_root, dat)
    end

    # This method runs the processing sketch.
    #
    def run_sketch
      PApplet.run_sketch(arguments, self)
    end

    private

    def import_opengl
      # Include processing opengl classes that we'd like to use:
      %w(FontTexture FrameBuffer LinePath LineStroker PGL
         PGraphics2D PGraphics3D PGraphicsOpenGL PShader
         PShapeOpenGL Texture).each do |klass|
        java_import "processing.opengl.#{klass}"
      end
    end

    # This method configures the sketch title and and presentation mode.
    #
    def configure_sketch
      set_sketch_title
      set_presentation_mode
    end

    # This method sets the sketch presentation mode.
    #
    def set_presentation_mode
      arguments.concat ['--present'] if options[:fullscreen]
    end

    # This method sets the sketch title.
    #
    def set_sketch_title
      title_string = options.fetch(:title, 'processing sketch')
      arguments.concat [title_string]
    end

    def proxy_java_fields
      fields = %w(sketchPath key frameRate mousePressed keyPressed)
      methods = fields.map { |field| java_class.declared_field(field) }
      @declared_fields = Hash[fields.zip(methods)]
    end

    # When certain special methods get added to the sketch, we need to let
    # Processing call them by their expected Java names.
    def method_added(method_name) #:nodoc:
      return unless METHODS_TO_ALIAS.key?(method_name)
      alias_method METHODS_TO_ALIAS[method_name], method_name
    end
  end

  # Importing PConstants to access to processing constants,
  # to keep namespace clean use PConstants::TRIANGLE (for example)
  # or to use bare TRIANGLE also 'include PConstants'
  # Using :method_missing to mimic inner class methods
  # @HACK you should consider using 'forwardable' to avoid this
  # egregious hack...
  module Proxy
    java_import 'processing.core.PConstants'

    def respond_to_missing?(name, include_private = false)
      $app.respond_to?(name) || super
    end

    def method_missing(name, *args)
      return $app.send(name, *args) if $app && $app.respond_to?(name)
      super
    end
  end
end
