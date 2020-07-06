# frozen_string_literal: true

class JDKVersionError < StandardError
  def message
    'This version of propane requires at least JDK11 to work'
  end
end
