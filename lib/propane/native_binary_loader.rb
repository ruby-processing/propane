require 'rbconfig'

# Utility to load native binaries on Java CLASSPATH
class NativeBinaryLoader
  attr_reader :os, :bit

  # WIN_FORMAT = 'windows%d'
  LINUX_FORMAT = 'linux%d'
  # WIN_PATTERNS = [
  #   /bccwin/i,
  #   /cygwin/i,
  #   /djgpp/i,
  #   /ming/i,
  #   /mswin/i,
  #   /wince/i
  # ].freeze

  def initialize
    @os = RbConfig::CONFIG['host_os'].downcase
    @bit = Java::JavaLang::System.getProperty('os.arch') =~ /64/ ? 64 : 32
  end

  def folder_name
    return 'macosx' if os =~ /darwin/ || os =~ /mac/
    # return format(WIN_FORMAT, bit) if WIN_PATTERNS.include? os
    return format(LINUX_FORMAT, bit) if os =~ /linux/
  end
end
