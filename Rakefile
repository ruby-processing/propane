# frozen_string_literal: false

require_relative 'lib/propane/version'

task default: %i[init compile install test gem]

# Currently depends on local jogl-2.4.0 jars on path ~/jogl24
desc 'Copy Jars'
task :init do
  jogl24 = File.join(ENV['HOME'], 'jogl24')
  opengl = Dir.entries(jogl24).grep(/amd64|universal|arm64/).select { |jar| jar =~ /linux|windows|macosx|ios|/ }
  opengl.concat %w[jogl-all.jar gluegen-rt.jar]
  opengl.each do |gl|
    FileUtils.cp(File.join(jogl24, gl), File.join('.', 'lib'))
  end
end

desc 'Install'
task :install do
  sh "mv target/propane-#{Propane::VERSION}.jar lib"
end

desc 'Gem'
task :gem do
  sh 'jgem build propane.gemspec'
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
