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
  gem.description   = %q{A batteries included version of processing in ruby, macOS and linux} 
  gem.summary       = %q{A jruby wrapper for processing-3.2.3}
  gem.homepage      = 'https://ruby-processing.github.io/propane/'
  gem.files         = `git ls-files`.split($/)
  gem.files << 'lib/propane.jar'
  gem.files << 'lib/core-3.2.3.jar'
  gem.files << 'lib/gluegen-rt-2.3.2.jar'
  gem.files << 'lib/jogl-all-2.3.2.jar'
  gem.files << 'lib/gluegen-rt-2.3.2-natives-linux-amd64.jar'
  gem.files << 'lib/gluegen-rt-2.3.2-natives-macosx-universal.jar'
  gem.files << 'lib/jogl-all-2.3.2-natives-linux-amd64.jar'
  gem.files << 'lib/jogl-all-2.3.2-natives-macosx-universal.jar'
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.add_runtime_dependency 'arcball', '~> 0.0.3'  
  gem.require_paths = ['lib']
  gem.platform      = 'java'
end
