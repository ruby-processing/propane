project 'propane', 'https://github.com/monkstone/propane' do

  model_version '4.0.0'
  id 'propane:propane:3.4.1'
  packaging 'jar'

  description 'An integrated processing-core (somewhat hacked), with additional java code for a jruby version of processing.'

  developer 'monkstone' do
    name 'Martin Prout'
    roles 'developer'
  end

  developer 'benfry' do
    name 'Ben Fry'
    roles 'developer'
  end

  developer 'REAS' do
    name 'Casey Reas'
    roles 'developer'
  end

  developer 'codeanticode' do
    name 'Andres Colubri'
    roles 'developer'
  end

  developer 'sampottinger' do
    name 'Sam Pottinger'
    roles 'developer'
  end

  issue_management 'https://github.com/ruby-processing/propane/issues', 'Github'

  source_control( :url => 'https://github.com/ruby-processing/propane',
    :connection => 'scm:git:git://github.com/ruby-processing/propane.git',
    :developer_connection => 'scm:git:git@github.com/ruby-processing/propane.git' )

    properties( 'propane.basedir' => '${project.basedir}',
      'processing.api' => 'http://processing.github.io/processing-javadocs/core/',
      'source.directory' => 'src',
      'polyglot.dump.pom' => 'pom.xml',
      'project.build.sourceEncoding' => 'utf-8',
      'jogl.version' => '2.3.2',
      'jruby.api' => 'http://jruby.org/apidocs/' )

      pom 'org.jruby:jruby:9.2.9.0'
      jar 'org.processing:video:3.3.7'
      jar 'org.jogamp.jogl:jogl-all:${jogl.version}'
      jar 'org.jogamp.gluegen:gluegen-rt-main:${jogl.version}'

      overrides do
        plugin( 'org.codehaus.mojo:versions-maven-plugin:2.7',
          'generateBackupPoms' =>  'false' )
          plugin( :compiler, '3.8.1',
            'release' =>  '11' )
            plugin( :javadoc, '3.1.1',
              'detectOfflineLinks' =>  'false',
              'links' => [ '${jruby.api}',
                '${processing.api}' ] )
                plugin(
                  :jar, '3.1.2',
                  'archive' => {
                    'manifestEntries' => { 'Class-Path' => 'gluegen-rt.jar jog-all.jar' }
                  }
                )
              end
              build do
                resource do
                  directory '${source.directory}/main/java'
                  includes '**/**/*.glsl', '**/*.jnilib'
                  excludes '**/**/*.java'
                end
                resource do
                  directory '${source.directory}/main/resources'
                  includes '**/*.png', '*.txt'
                  excludes
                end
              end
            end
