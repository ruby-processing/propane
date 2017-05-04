# frozen_string_literal: false
# The processing wrapper module
module Propane
  # Encapsulate library loader functionality as a class
  require_relative 'local_ruby_library'
  require_relative 'installed_ruby_library'
  require_relative 'local_java_library'
  require_relative 'installed_java_library'


  class LibraryLoader
    attr_reader :library

    def initialize
      @loaded_libraries = Hash.new(false)
    end

    # Detect if a library has been loaded (for conditional loading)
    def library_loaded?(library_name)
      @loaded_libraries[library_name.to_sym]
    end

    # Load a list of Ruby or Java libraries (in that order)
    # Usage: load_libraries :opengl, :boids
    #
    # If a library is put into a 'library' folder next to the sketch it will
    # be used instead of the library that ships with Propane.
    def load_libraries(*args)
      message = 'no such file to load -- %s'
      args.each do |lib|
        loaded = loader(lib)
        fail(LoadError.new, format(message, lib)) unless loaded
      end
    end
    alias_method :load_library, :load_libraries


    def loader(name)
      return true if @loaded_libraries.include?(name)
      fname = name.to_s
      if (@library = LocalRubyLibrary.new(fname)).exist?
        return require_library(library)
      end
      if (@library = InstalledRubyLibrary.new(fname)).exist?
        return require_library(library)
      end
      if (@library = LocalJavaLibrary.new(fname)).exist?
        return require_library(library.path)
      end
      if (@library = InstalledJavaLibrary.new(fname)).exist?
        return require_library(library)
      end
      false
    end

    def require_library(lib)
      @loaded_libraries[lib.name.to_sym] = require lib.path
    end

    # For pure ruby libraries.
    # The library should have an initialization ruby file
    # of the same name as the library folder.
    # def load_ruby_library(name)
    #   library_name = name.to_sym
    #   return true if @loaded_libraries.include?(library_name)
    #   loader = InstalledRubyLibrary.new(name)
    #   return false unless loader.exist?
    #   path = loader.path
    #   @loaded_libraries[library_name] = (require path)
    # end

    # HACK: For pure java libraries, such as the ones that are available
    # on this page: http://processing.org/reference/libraries/index.html
    # that include native code, we mess with the 'Java ClassLoader', so that
    # you don't have to futz with your PATH. But it's probably bad juju.
    def load_java_library(library_name)
      library_name = library_name.to_sym
      return true if @loaded_libraries.include?(library_name)
      jpath = get_library_directory_path(library_name, 'jar')
      jars = get_library_paths(library_name, 'jar')
      return false if jars.empty?
      jars.each { |jar| require jar }
      platform_specific_library_paths = get_platform_specific_library_paths(jpath)
      platform_specific_library_paths = platform_specific_library_paths.select do |ppath|
        FileTest.directory?(ppath) && !Dir.glob(File.join(ppath, '*.{so,dll,jnilib}')).empty?
      end
      unless platform_specific_library_paths.empty?
        platform_specific_library_paths << java.lang.System.getProperty('java.library.path')
        new_library_path = platform_specific_library_paths.join(java.io.File.pathSeparator)
        java.lang.System.setProperty('java.library.path', new_library_path)
        field = java.lang.Class.for_name('java.lang.ClassLoader').get_declared_field('sys_paths')
        if field
          field.accessible = true
          field.set(java.lang.Class.for_name('java.lang.System').get_class_loader, nil)
        end
      end
      @loaded_libraries[library_name] = true
    end

    def platform
      match = %w(mac linux windows).find do |os|
        java.lang.System.getProperty('os.name').downcase.index(os)
      end
      return 'other' unless match
      return match unless match =~ /mac/
      'macosx'
    end

     def get_platform_specific_library_paths(basename)
      bits = '64'
      if java.lang.System.getProperty('sun.arch.data.model') == '32' ||
         java.lang.System.getProperty('java.vm.name').index('32')
        bits = '32' unless platform =~ /macosx/
      end
      [platform, platform + bits].map { |p| File.join(basename, p) }
    end

    def get_library_paths(library_name, extension = nil)
      dir = get_library_directory_path(library_name, extension)
      Dir.glob("#{dir}/*.{rb,jar}")
    end

    protected

    def get_library_directory_path(library_name, extension = nil)
      extensions = extension ? [extension] : %w(jar rb)
      extensions.each do |ext|
        [
          "#{SKETCH_ROOT}/library/#{library_name}",
          "#{PROPANE_ROOT}/library/#{library_name}",
          "#{PROPANE_ROOT}/library/#{library_name}/library",
          "#{PROPANE_ROOT}/library/#{library_name}",
          "#{ENV['HOME']}/.propane/libraries/#{library_name}/library"
        ].each do |jpath|
          if File.exist?(jpath) && !Dir.glob(format('%s/*.%s', jpath, ext)).empty?
            return jpath
          end
        end
      end
      nil
    end
  end
end
