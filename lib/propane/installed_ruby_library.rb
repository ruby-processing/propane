# The LibraryLoader class
class InstalledRubyLibrary

  attr_reader :dir, :path

  def initialize(name)
    @dir = File.join("#{PROPANE_ROOT}", 'library', "#{name}")
    @path = File.join(dir, "#{name}.rb")
  end

  def exist?
    return false unless File.directory?(dir)
    File.exist?(path)
  end
end
