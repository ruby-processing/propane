# frozen_string_literal: false
# The processing wrapper module
module Propane
  require_relative 'ruby_library'
  require_relative 'java_library'

  # Encapsulate library loader functionality as a class
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
    # Usage: load_libraries :video, :video_event
    #
    # If a library is put into a 'library' folder next to the sketch it will
    # be used instead of the library that ships with Propane.
    def load_libraries(*args)
      message = 'no such file to load -- %s'
      args.each do |lib|
        loaded = loader(lib)
        raise(LoadError.new, format(message, lib)) unless loaded
      end
    end
    alias load_library load_libraries

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
        library.load_jars
        library.add_binaries_to_classpath if library.native_binaries?
        return @loaded_libraries[name] = true
      end
      if (@library = InstalledJavaLibrary.new(fname)).exist?
        library.load_jars
        library.add_binaries_to_classpath if library.native_binaries?
        return @loaded_libraries[name] = true
      end
      false
    end

    def require_library(lib)
      @loaded_libraries[lib.name.to_sym] = require lib.path
    end
  end
end
