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
  gem.description   = %q{A batteries included version of processing in ruby, MacOS and linux64}
  gem.summary       = %q{ruby wrapper for processing-3.3.4 on MacOS and linux64 bit only for opengl}
  gem.homepage      = 'https://ruby-processing.github.io/propane/'
  gem.files         = `git ls-files`.split($/)
  gem.files << 'lib/propane.jar'
  gem.files << 'lib/core-3.3.4.jar'
  gem.files << 'lib/gluegen-rt-2.3.2.jar'
  gem.files << 'lib/jogl-all-2.3.2.jar'
  gem.files << 'lib/gluegen-rt-2.3.2-natives-linux-amd64.jar'
  gem.files << 'lib/gluegen-rt-2.3.2-natives-macosx-universal.jar'
  gem.files << 'lib/jogl-all-2.3.2-natives-linux-amd64.jar'
  gem.files << 'lib/jogl-all-2.3.2-natives-macosx-universal.jar'
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.add_development_dependency 'rake', '~> 12'
  gem.add_runtime_dependency 'arcball', '~> 1.0', '>= 1.0.0'
  gem.require_paths = ['lib']
  gem.platform      = 'java'
end
