# The LibraryLoader class
class InstalledRubyLibrary
  attr_reader :path

  def initialize(name)
    @path = File.join(PROPANE_ROOT, 'library', name, "#{name}.rb")
  end

  def exist?
    File.exist? path
  end
end
