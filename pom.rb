require 'fileutils'
project 'propane', 'https://github.com/monkstone/propane' do
  model_version '4.0.0'
  id 'propane:propane:2.9.2'
  packaging 'jar'
  description 'An integrated processing-core (somewhat hacked), with additional java code for a jruby version of processing.'

  organization 'ruby-processing', 'https://ruby-processing.github.io'

  {
    'monkstone' => 'Martin Prout', 'benfry' => 'Ben Fry',
    'REAS' => 'Casey Reas', 'codeanticode' => 'Andres Colubri'
  }.each do |key, value|
    developer key do
      name value
      roles 'developer'
    end
  end
  license 'GPL 3', 'http://www.gnu.org/licenses/gpl-3.0-standalone.html'
  license 'LGPL 2', 'https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html'
  issue_management 'https://github.com/ruby-processing/propane/issues', 'Github'

  source_control(
    url: 'https://github.com/ruby-processing/propane',
    connection: 'scm:git:git://github.com/ruby-processing/propane.git',
    developer_connection: 'scm:git:git@github.com/ruby-processing/propane.git'
    )

  properties('source.directory' => 'src',
    'propane.basedir' => '${project.basedir}',
    'polyglot.dump.pom' => 'pom.xml',
    'maven.compiler.source' => '1.8',
    'project.build.sourceEncoding' => 'utf-8',
    'maven.compiler.target' => '1.8',
    'jruby.api' => 'http://jruby.org/apidocs/',
    'processing.api' => 'http://processing.github.io/processing-javadocs/core/',
    'jruby.api' => 'http://jruby.org/apidocs/',
    'jogl.version' => '2.3.2'
    )

  pom 'org.jruby:jruby:9.2.3.0'
  jar 'com.apple.eawt:apple:1.0'
  jar 'org.processing:video:3.0.2'
  jar('org.jogamp.jogl:jogl-all:${jogl.version}')
  jar('org.jogamp.gluegen:gluegen-rt-main:${jogl.version}')

  plugin_management do
    plugin( :compiler, '3.8.0',
      source: '${maven.compiler.source}',
      target: '${maven.compiler.target}'
    )
    plugin( :javadoc, '2.10.4',
      detect_offline_links:  'false',
      links: ['${jruby.api}', '${processing.api}']
    )
    plugin( :jar, '3.0.2',
      archive: { manifestFile: 'MANIFEST.MF' }
    )
  end

  build do
    resource do
      directory '${source.directory}/main/java'
      includes ['**/**/*.glsl', '**/*.jnilib']
      excludes '**/**/*.java'
    end
    resource do
      directory '${source.directory}/main/resources'
      includes ['**/*.png', '*.txt']
    end
  end
end
