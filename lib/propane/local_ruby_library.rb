# The LibraryLoader class
class LocalRubyLibrary

  attr_reader :path

  def initialize(name)
    @path = File.join(SKETCH_ROOT, 'library', "#{name}.rb")
  end

  def exist?
    File.exist? path
  end
end
