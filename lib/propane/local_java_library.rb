# require_relative 'native_folder'

# The LocalJavaLibrary class
class LocalJavaLibrary

  attr_reader :dir, :path, :native

  def initialize(name)
    @dir = File.join(SKETCH_ROOT, 'library', name)
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
    ppath = File.join(dir, native)
    File.directory?(ppath) && !Dir.glob(File.join(ppath, native_folder.extension)).empty?
  end

  def add_binaries_to_classpath
    platform_specific_library_paths << java.lang.System.getProperty('java.library.path')
    new_library_path = platform_specific_library_paths.join(java.io.File.pathSeparator)
    java.lang.System.setProperty('java.library.path', new_library_path)
    field = java.lang.Class.for_name('java.lang.ClassLoader').get_declared_field('sys_paths')
    if field
      field.accessible = true
      field.set(java.lang.Class.for_name('java.lang.System').get_class_loader, nil)
    end
  end
end
