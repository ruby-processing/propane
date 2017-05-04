# The abstract RubyLibrary class
class RubyLibrary
  attr_reader :path, :name

  def initialize(name)
    @name = name
    @path = nil
  end

  def exist?
    File.exist? path
  end
end

class LocalRubyLibrary < RubyLibrary

  def initialize(name)
    super
    @path = File.absolute_path(File.join(Propane::SKETCH_ROOT, 'library', name, "#{name}.rb"))
  end
end
