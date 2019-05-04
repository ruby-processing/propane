# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'propane/version'

Gem::Specification.new do |gem|
  gem.name          = 'propane'
  gem.version       = Propane::VERSION
  gem.authors       = ['monkstone']
  gem.email         = ['mamba2928@yahoo.co.uk']
  gem.licenses     = %w(GPL-3.0 LGPL-2.0)
  gem.description  = <<-EOS
  A batteries included version of processing in ruby targetting jdk11.
  EOS
  gem.summary       = %q{ruby implementation of processing-4.0 on MacOS, linux and windows (64bit only)}
  gem.homepage      = 'https://ruby-processing.github.io/propane/'
  gem.files         = `git ls-files`.split($/)
  gem.files << 'lib/propane-3.3.0.jar'
  gem.files << 'lib/gluegen-rt.jar'
  gem.files << 'lib/jogl-all.jar'
  gem.files << 'lib/gluegen-rt-natives-linux-amd64.jar'
  gem.files << 'lib/gluegen-rt-natives-macosx-universal.jar'
  gem.files << 'lib/gluegen-rt-natives-windows-amd64.jar'
  gem.files << 'lib/jogl-all-natives-linux-amd64.jar'
  gem.files << 'lib/jogl-all-natives-macosx-universal.jar'
  gem.files << 'lib/jogl-all-natives-windows-amd64.jar'
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.add_development_dependency 'rake', '~> 12.3'
  gem.add_development_dependency 'minitest', '~> 5.10'
  gem.add_runtime_dependency 'arcball', '~> 1.0', '>= 1.0.0'
  gem.require_paths = ['lib']
  gem.platform      = 'java'
  gem.requirements << 'java runtime >= 11.0.1+'
end
