# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'propane/version'

Gem::Specification.new do |gem|
  gem.name          = 'propane'
  gem.version       = Propane::VERSION
  gem.authors       = ['filib', 'monkstone']
  gem.email         = ['mamba2928@yahoo.co.uk']
  gem.license       = 'MIT'
  gem.description   = %q{A Standalone Ruby Processing implementation} 
  gem.summary       = %q{A really slim layer between Ruby and Processing-2.2.1.}
  gem.homepage      = 'https://github.com/ruby-processing/propane'
  gem.files         = `git ls-files`.split($/)
  gem.files << 'lib/propane.jar'
  gem.files << 'lib/core-2.2.1.jar'
  gem.files << 'lib/gluegen-rt-2.1.5-01.jar'
  gem.files << 'lib/jogl-all-2.1.5-01.jar'
  gem.files << 'lib/gluegen-rt-2.1.5-01-natives-linux-amd64.jar'
  gem.files << 'lib/gluegen-rt-2.1.5-01-natives-macosx-universal.jar'
  gem.files << 'lib/jogl-all-2.1.5-01-natives-linux-amd64.jar'
  gem.files << 'lib/jogl-all-2.1.5-01-natives-macosx-universal.jar'
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.add_runtime_dependency 'arcball', '~> 0.0.3'  
  gem.require_paths = ['lib']
  gem.platform      = 'java'
end
