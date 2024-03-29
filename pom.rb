# frozen_string_literal: true

project 'propane', 'https://github.com/monkstone/propane' do
  model_version '4.0.0'
  id 'propane:propane:4.0.0'
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

  source_control(url: 'https://github.com/ruby-processing/propane',
    connection: 'scm:git:git://github.com/ruby-processing/propane.git',
    developer_connection: 'scm:git:git@github.com/ruby-processing/propane.git')

    properties('propane.basedir' => '${project.basedir}',
      'processing.api' => 'http://processing.github.io/processing-javadocs/core/',
      'source.directory' => 'src',
      'polyglot.dump.pom' => 'pom.xml',
      'project.build.sourceEncoding' => 'utf-8',
      'jogl.version' => '2.3.2', # for compiling actual included 2.4.0-rc
      'jruby.version' => '9.3.3.0',
      'batik.version' => '1.14',
      'itextpdf.version' => '5.5.13.2',
      'jruby.api' => 'http://jruby.org/apidocs/')

      jar 'org.jruby:jruby-base:${jruby.version}'
      jar 'org.apache.xmlgraphics:batik-all:${batik.version}'
      jar 'com.itextpdf:itextpdf:${itextpdf.version}'
      jar 'org.processing:video:3.3.7' # only for compiling
      jar 'org.jogamp.jogl:jogl-all:${jogl.version}'
      jar 'org.jogamp.gluegen:gluegen-rt-main:${jogl.version}'

      overrides do

        plugin('org.codehaus.mojo:versions-maven-plugin:2.8.1',
          'generateBackupPoms' => 'false')
          plugin(:compiler, '3.9.0',
            'release' => '17')
            plugin :dependency, '3.2.0' do
              execute_goals( id: 'default-cli',
                artifactItems:[
                  { groupId: 'com.itextpdf',
                    artifactId: 'itextpdf',
                    version: '${itextpdf.version}',
                    type: 'jar',
                    outputDirectory: '${propane.basedir}/library/pdf'
                  },
                  { groupId: 'org.apache.xmlgraphics',
                    artifactId: 'batik-all',
                    version: '${batik.version}',
                    type: 'jar',
                    outputDirectory: '${propane.basedir}/library/svg'
                  }
                ]
              )
            end
            plugin(:javadoc, '3.3.1',
              'detectOfflineLinks' => 'false',
              'links' => ['${jruby.api}',
                '${processing.api}'])
                plugin(:jar, '3.2.2',
                  'archive' => {
                    'manifestEntries' => {
                      'Automatic-Module-Name' => 'processing.core'
                    }
                    })
                    plugin('org.apache.maven.plugins:maven-pmd-plugin:3.15.0')
                  end
                  build do
                    resource do
                      directory '${source.directory}/main/java'
                      includes '**/*.jnilib'
                      excludes '**/**/*.java'
                    end
                    resource do
                      directory '${source.directory}/main/resources'
                      includes '**/*.png', '**/*.glsl', '**/*.txt'
                    end
                  end
                end
                reporting do
                  plugin('org.apache.maven.plugins:maven-jxr-plugin:3.1.1')
                end
