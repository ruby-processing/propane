# The LibraryLoader class
class LocalRubyLibrary

  attr_reader :path

  def initialize(name)
    @path = File.absolute_path(File.join(Propane::SKETCH_ROOT, 'library', name, "#{name}.rb"))
  end

  def exist?
    File.exist? path
  end
end
