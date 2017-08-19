require_relative 'native_folder'
require_relative 'native_loader'

# This class knows where to find propane libraries
class Library
  attr_reader :name, :path, :dir, :ppath

  def initialize(name)
    @name = name
    @ruby = true
  end

  def locate
    @path = File.absolute_path(
      File.join(Propane::SKETCH_ROOT, 'library', name, "#{name}.rb")
    )
    return path if File.exist? path
    @path = File.join(PROPANE_ROOT, 'library', name, "#{name}.rb")
    return path if File.exist? path
    locate_java
  end

  def locate_java
    @dir = File.join(Propane::SKETCH_ROOT, 'library', name)
    @path = File.join(dir, "#{name}.jar")
    return path if File.exist? path
    locate_installed_java
  end

  def locate_installed_java
    @dir = File.join(ENV['HOME'], '.propane', 'libraries', name, 'library')
    @path = File.join(dir, "#{name}.jar")
    warn "Library '#{name}' not found" unless File.exist? path
  end

  def ruby?
    path.end_with? '.rb'
  end

  def load_jars
    Dir.glob("#{dir}/*.jar").each do |jar|
      require jar
    end
    return unless native_binaries?
    add_binaries_to_classpath
  end

  def native_binaries?
    native_folder = NativeFolder.new
    native = native_folder.name
    @ppath = File.join(dir, native)
    File.directory?(ppath) &&
      !Dir.glob(File.join(ppath, native_folder.extension)).empty?
  end

  def add_binaries_to_classpath
    native_loader = NativeLoader.new
    native_loader.add_native_path(ppath)
  end
end
