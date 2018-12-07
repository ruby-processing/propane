# frozen_string_literal: false
require_relative 'lib/propane/version'
require 'erb'

desc 'Create jar Manifest'
task :create_manifest do
  manifest = ERB.new <<~MANIFEST
    Implementation-Title: rpextras (java extension for propane)
    Implementation-Version: <%= Propane::VERSION %>
    Class-Path: apple.jar gluegen-rt.jar jog-all.jar
  MANIFEST
  File.open('MANIFEST.MF', 'w') do |f|
    f.puts(manifest.result(binding))
  end
end

task default: [:init, :compile, :install, :test, :gem]

# depends on installed processing, with processing on path
desc 'Create Manifest and Copy Jars'
task init: :create_manifest do
  processing_root = File.dirname(`readlink -f $(which processing)`) # for Archlinux etc
  # processing_root = File.join(ENV['HOME'], 'processing-3.4') # alternative for debian linux etc
  jar_dir = File.join(processing_root, 'core', 'library')
  opengl = Dir.entries(jar_dir).grep(/amd64|macosx-universal/)
  opengl.concat %w[jogl-all.jar gluegen-rt.jar]
  opengl.each do |gl|
    FileUtils.cp(File.join(jar_dir, gl), File.join('.', 'lib'))
  end
end

desc 'Install'
task :install do
  sh "mv target/propane-#{Propane::VERSION}.jar lib"
end

desc 'Gem'
task :gem do
  sh 'gem build propane.gemspec'
end

desc 'Document'
task :javadoc do
  sh 'mvn javadoc:javadoc'
end

desc 'Compile'
task :compile do
  sh 'mvn package'
end

desc 'JRuby-Complete'
task :install_complete do
  sh 'cd vendors && rake'
end

desc 'Test'
task :test do
  sh 'jruby test/helper_methods_test.rb'
  # sh 'jruby test/respond_to_test.rb' Skip test on Travis to avoid Headless fail
  sh 'jruby test/create_test.rb'
  sh 'jruby test/math_tool_test.rb'
  sh 'jruby test/deglut_spec_test.rb'
  sh 'jruby test/vecmath_spec_test.rb'
end

desc 'clean'
task :clean do
  Dir["./**/*.{jar,gem}"].each do |path|
    puts "Deleting #{path} ..."
    File.delete(path)
  end
  FileUtils.rm_rf('./target')
end
