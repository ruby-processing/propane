# frozen_string_literal: true

require 'rbconfig'

# Utility to load native binaries on Java CLASSPATH
class NativeFolder
  attr_reader :os, :bit

  WIN_FORMAT = 'windows%d'
  LINUX_FORMAT = 'linux%d'
  WIN_PATTERNS = [
    /bccwin/i,
    /cygwin/i,
    /djgpp/i,
    /ming/i,
    /mswin/i,
    /wince/i
  ].freeze

  def initialize
    @os = RbConfig::CONFIG['host_os'].downcase
    @bit = java.lang.System.get_property('os.arch') =~ /64/ ? 64 : 32
  end

  def name
    return 'macosx' if /darwin|mac/.match?(os)
    return format(LINUX_FORMAT, bit) if os =~ /linux/
    return format(WIN_FORMAT, bit) if WIN_PATTERNS.any? { |pat| pat =~ os }

    raise 'Unsupported Architecture'
  end

  def extension
    return '*.so' if /linux/.match?(os)
    return '*.dll' if WIN_PATTERNS.any? { |pat| pat =~ os }

    '*.dylib' # MacOS
  end
end
