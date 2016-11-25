require 'fileutils'
project 'rp5extras', 'https://github.com/monkstone/propane' do
  model_version '4.0.0'
  id 'propane:propane', '2.1.0'
  packaging 'jar'
  description 'rp5extras for propane'
  organization 'ruby-processing', 'https://ruby-processing.github.io'
  { 'monkstone' => 'Martin Prout' }.each do |key, value|
    developer key do
      name value
      roles 'developer'
    end
  end
  license 'GPL 3', 'http://www.gnu.org/licenses/gpl-3.0-standalone.html'
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

  pom 'org.jruby:jruby:9.1.5.0'
  jar 'org.processing:core:3.2.3'
  jar 'org.processing:video:3.0.2'
  jar('org.jogamp.jogl:jogl-all:${jogl.version}')
  jar('org.jogamp.gluegen:gluegen-rt-main:${jogl.version}')

  overrides do
    plugin :resources, '2.6'
    plugin :dependency, '2.10' do
      execute_goals( id: 'default-cli',
        artifactItems: [ { groupId:  'org.processing',
          artifactId:  'core',
          version:  '3.2.3',
          type:  'jar',
          outputDirectory: '${propane.basedir}/lib'
        },
        { groupId:  'org.jogamp.jogl',
          artifactId:  'jogl-all',
          version:  '${jogl.version}',
          type:  'jar',
          outputDirectory: '${propane.basedir}/lib'
        },
        { groupId:  'org.jogamp.gluegen',
          artifactId:  'gluegen-rt',
          version:  '${jogl.version}',
          type:  'jar',
          outputDirectory: '${propane.basedir}/lib'
        },
        { groupId:  'org.jogamp.jogl',
          artifactId:  'jogl-all',
          version:  '${jogl.version}',
          classifier: 'natives-linux-amd64',
          type:  'jar',
          outputDirectory: '${propane.basedir}/lib'
        },
        { groupId:  'org.jogamp.gluegen',
          artifactId:  'gluegen-rt',
          version:  '${jogl.version}',
          type:  'jar',
          classifier: 'natives-linux-amd64',
          outputDirectory: '${propane.basedir}/lib'
        },
        { groupId:  'org.jogamp.jogl',
          artifactId:  'jogl-all',
          version:  '${jogl.version}',
          classifier: 'natives-macosx-universal',
          type:  'jar',
          outputDirectory: '${propane.basedir}/lib'
        },
        { groupId:  'org.jogamp.gluegen',
          artifactId:  'gluegen-rt',
          version:  '${jogl.version}',
          type:  'jar',
          classifier: 'natives-macosx-universal',
          outputDirectory: '${propane.basedir}/lib'
        }
        ]
      )
    end

    plugin( :compiler, '3.6.0',
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
    default_goal 'package'
    source_directory 'src'
    final_name 'propane'
  end
end
