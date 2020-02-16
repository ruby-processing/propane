# frozen_string_literal: true

class Numeric #:nodoc:
  def degrees
    self * 57.29577951308232
  end

  def radians
    self * 0.017453292519943295
  end
end
