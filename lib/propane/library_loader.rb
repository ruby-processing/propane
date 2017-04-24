# The LibraryLoader class
require_relative 'local_ruby_library'
require_relative 'installed_ruby_library'
require_relative 'local_java_library'
require_relative 'installed_java_library'

# The public interface to the rather complicated library loading mechanism
class LibraryLoader
  attr_reader :loaded_libraries
  def initialize
    @loaded_libraries = Hash.new(false)
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
      @loaded_libraries[name] = (require LocalRubyLibrary.new(fname).path)
      return true
    end
    if (@library = InstalledRubyLibrary.new(fname)).exist?
      @loaded_libraries[name] = (require @library.path)
      return true
    end
    # if File.exist?(local_java(fname))
      # @loaded_libraries[name] = (require LocalJavaLibrary.new(fname).path)
      # return true
    # end
    if (@library = InstalledJavaLibrary.new(fname)).exist?
      @library.load_jars
      @loaded_libraries[name] = true
      return true
    end
    false
  end
end
