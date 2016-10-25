gem 'minitest' # don't use bundled minitest
require 'java'
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/propane'

Java::Monkstone::PropaneLibrary.load(JRuby.runtime)

Dir.chdir(File.dirname(__FILE__))

class RadlutTest < Minitest::Test
  FOUR_PI = Math::PI * 4
  TENTH_PI = Math::PI / 10

  def test_cos_sin
    (-FOUR_PI * FOUR_PI).step(TENTH_PI) do |rad|
      sine = RadLut.sin(rad)
      math_sin = Math.sin(rad)
      assert_in_delta(sine, math_sin, delta = 0.005) # Error tuned for default
      cosine = RadLut.cos(rad)
      math_cos = Math.cos(rad)
      assert_in_delta(cosine, math_cos, delta = 0.005)
    end
  end
end
