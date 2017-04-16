# require_relative 'native_binary_loader'

# The LocalJavaLibrary class
class LocalJavaLibrary
  attr_reader :directory

  def initialize(name)
    @directory = File.join("#{Propane::SKETCH_ROOT}", 'library', name)
  end

  def exist?
    return false unless directory.directory?
    File.exist? File.join("#{directory}", "#{name}.jar")
  end

  def load_jars
    Dir["#{directory}/*.jar"].each do |jar|
      require jar
    end
    true
  end

  # def native_binaries?
  #   @native ||= NativeBinaryLoader.new.folder_name
  #   File.directory? File.join(directory, native)
  # end
  #
  # def add_binaries_to_classpath
  #   platform_specific_library_paths << java.lang.System.getProperty('java.library.path')
  #   new_library_path = platform_specific_library_paths.join(java.io.File.pathSeparator)
  #   java.lang.System.setProperty('java.library.path', new_library_path)
  #   field = java.lang.Class.for_name('java.lang.ClassLoader').get_declared_field('sys_paths')
  #   if field
  #     field.accessible = true
  #     field.set(java.lang.Class.for_name('java.lang.System').get_class_loader, nil)
  #   end
  # end
end
