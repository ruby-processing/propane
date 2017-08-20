require_relative 'native_folder'
require_relative 'native_loader'
require 'pathname'

# This class knows where to find propane libraries
class Library
  attr_reader :name, :path, :dir, :ppath

  def initialize(name)
    @name = name
    @ruby = true
  end

  def locate
    return if (@path = Pathname.new(
      File.join(Propane::SKETCH_ROOT, 'library', name, "#{name}.rb")
    )).exist?
    return if (@path = Pathname.new(
      File.join(PROPANE_ROOT, 'library', name, "#{name}.rb")
    )).exist?
    locate_java
  end

  def locate_java
    @dir = Pathname.new(
      File.join(Propane::SKETCH_ROOT, 'library', name)
    )
    locate_installed_java
  end

  def locate_installed_java
    unless dir.directory?
      @dir = Pathname.new(
        File.join(ENV['HOME'], '.propane', 'libraries', name, 'library')
      )
    end
    @path = dir.join(Pathname.new("#{name}.jar"))
  end

  def ruby?
    path.extname == '.rb'
  end

  def exist?
    path.exist?
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
