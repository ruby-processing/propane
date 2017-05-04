require_relative 'native_folder'
require_relative 'native_loader'

# The LocalJavaLibrary class
class LocalJavaLibrary

  attr_reader :dir, :path, :name, :ppath

  def initialize(name)
    @name = name
    @dir = File.join(Propane::SKETCH_ROOT, 'library', name)
    @path = File.join(dir, "#{name}.jar")
  end

  def exist?
    File.exist? path
  end

  def load_jars
    Dir["#{dir}/*.jar"].each do |jar|
      require jar
    end
  end

  def native_binaries?
    native_folder = NativeFolder.new
    native = native_folder.name
    @ppath = File.join(dir, native)
    File.directory?(ppath) && !Dir.glob(File.join(ppath, native_folder.extension)).empty?
  end

  def add_binaries_to_classpath
    native_loader = NativeLoader.new
    native_loader.add_native_path(ppath)
  end
end
