# The wrapper module
module Propane

  # This class knows about supported JRubyArt operating systems
  class HostOS
    def self.os
      detect_os = RbConfig::CONFIG['host_os']
      case detect_os
      when /mac|darwin/ then :mac
      when /linux/ then :linux
      else
        raise "unsupported os: #{detect_os.inspect}"
      end
    end
  end
  OS ||= HostOS.os

  # Expected vanilla processing paths for a given library name
  class ProcessingPath
    def self.list(library_name)
      [
        "#{SKETCH_ROOT}/library/#{library_name}",
        "#{PROPANE_ROOT}/library/#{library_name}",
        "#{PROPANE_ROOT}/library/#{library_name}/library",
        "#{PROPANE_ROOT}/library/#{library_name}",
        "#{ENV['HOME']}/.propane/libraries/#{library_name}/library"
      ]
    end
  end
end
