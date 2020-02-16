# frozen_string_literal: false

require_relative 'lib/propane/version'

task default: %i[init compile install test gem]

# depends on installed processing, with processing on path
desc 'Copy Jars'
task :init do
  # processing_root = File.dirname(`readlink -f $(which processing)`) # for Archlinux etc
  processing_root = File.join(ENV['HOME'], 'processing-3.5.4') # alternative for debian linux etc
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
  sh './mvnw javadoc:javadoc'
end

desc 'Compile'
task :compile do
  sh './mvnw package'
end

desc 'JRuby-Complete'
task :install_complete do
  sh 'cd vendors && rake'
end

desc 'Test'
task :test do
  sh 'jruby test/helper_methods_test.rb'
  # sh 'jruby test/respond_to_test.rb' Skip test on Travis to avoid Headless fail
  sh 'jruby --dev test/create_test.rb'
  sh 'jruby --dev test/math_tool_test.rb'
  sh 'jruby --dev test/deglut_spec_test.rb'
  sh 'jruby --dev test/vecmath_spec_test.rb'
end

desc 'clean'
task :clean do
  Dir['./**/*.{jar,gem}'].each do |path|
    puts "Deleting #{path} ..."
    File.delete(path)
  end
  FileUtils.rm_rf('./target')
end
