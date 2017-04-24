# frozen_string_literal: true
# require 'java'

# The InstalledJavaLibrary class
class InstalledJavaLibrary

  attr_reader :lib_dir, :lib_jar

  def initialize(name)
    @lib_dir = File.join(ENV['HOME'], '.propane', 'libraries', name, 'library')
    @lib_jar = File.join(lib_dir, "#{name}.jar")
  end

  def exist?
    return false unless File.directory?(lib_dir)
    File.exist?(lib_jar)
  end

  def load_jars
    Dir["#{lib_dir}/*.jar"].each do |jar|
      require jar
    end
  end

  def native_binaries?
    true
  end
end
