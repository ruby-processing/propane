# frozen_string_literal: false
require_relative 'helper_methods'
require_relative 'library_loader'

# A wrapper module for the processing App
module Propane
  include_package 'processing.core' # imports the processing jar.
  # Load vecmath, fastmath and mathtool modules
  Java::Monkstone::PropaneLibrary.load(JRuby.runtime)
  SKETCH_ROOT ||= Dir.pwd

  module Render
    java_import 'monkstone.vecmath.AppRender'
    java_import 'monkstone.vecmath.ShapeRender'
  end

  # This class is the base class the user should inherit from when making
  # their own sketch.
  #
  # i.e.
  # require 'propane'
  #
  # class MySketch < Propane::App
  #
  #   def draw
  #     background rand(255)
  #   end
  #
  # end
  #
  # MySketch.new

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
    include Math, MathTool, HelperMethods, Render
    # Alias some methods for familiarity for Shoes coders.
    alias oval ellipse
    alias stroke_width stroke_weight
    alias rgb color
    alias gray color
    field_reader :surface

    def sketch_class
      self.class.sketch_class
    end

    # Keep track of what inherits from the Processing::App, because we're
    # going to want to instantiate one.
    def self.inherited(subclass)
      super(subclass)
      @sketch_class = subclass
    end

    # App should be instantiated with an optional list of options
    # and array of arguments.
    #
    # App.new
    #
    class << self
      # Handy getters and setters on the class go here:
      attr_accessor :sketch_class, :library_loader, :title, :arguments, :options

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

    def sketch_title(title)
      surface.set_title(title)
    end

    def data_path(dat)
      dat_root = File.join(SKETCH_ROOT, 'data')
      Dir.mkdir(dat_root) unless File.exist?(dat_root)
      File.join(dat_root, dat)
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

  # Importing PConstants to access processing constants, we also need to
  # 'include PConstants' to avoid requiring the `PConstants::` prefix
  # `include Math etc because we expect to use them`
  # Using :method_missing to mimic inner class methods
  # @HACK you should consider using 'forwardable' to avoid this
  # egregious hack...
  module Proxy
    java_import 'processing.core.PConstants'
    include Math, MathTool, HelperMethods, PConstants
    def respond_to_missing?(name, include_private = false)
      $app.respond_to?(name) || super
    end

    def method_missing(name, *args)
      return $app.send(name, *args) if $app && $app.respond_to?(name)
      super
    end
  end
end
