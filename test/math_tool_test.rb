# frozen_string_literal: true

require_relative 'test_helper'
require 'java'
require_relative '../lib/propane'

Java::Monkstone::PropaneLibrary.new.load(JRuby.runtime, false)

# include Processing::HelperMethods

Dir.chdir(File.dirname(__FILE__))

class MathToolTest < Minitest::Test
  include MathTool
  def test_map1d
    x = [0, 5, 7.5, 10]
    range1 = (0..10)
    range2 = (100..1)
    range3 = (0..10)
    range4 = (5..105)
    assert_in_delta(map1d(x[0], range1, range2), 100, 0.00001, 'map to first')
    assert_in_delta(map1d(x[1], range1, range2), 50.5, 0.00001, 'map to reversed intermediate')
    assert_in_delta(map1d(x[2], range3, range4), 80.0, 0.00001, 'map to intermediate')
    assert_in_delta(map1d(x[3], range1, range2), 1, 0.00001, 'map to last')
  end

  def test_p5map # as map1d except not using range input
    x = [0, 5, 7.5, 10]
    range1 = (0..10)
    range2 = (100..1)
    range3 = (0..10)
    range4 = (5..105)
    assert_in_delta(p5map(x[0], range1.first, range1.last, range2.first, range2.last), 100, 0.00001)
    assert_in_delta(p5map(x[1], range1.first, range1.last, range2.first, range2.last), 50.5, 0.00001)
    assert_in_delta(p5map(x[2], range3.first, range3.last, range4.first, range4.last), 80.0, 0.00001)
    assert_in_delta(p5map(x[3], range1.first, range1.last, range2.first, range2.last), 1, 0.00001)
  end

  def test_norm
    x = [10, 140, 210]
    start0 = 30
    last0 = 200
    start_int = 0
    last_int = 200
    assert_in_delta(norm(x[0], start0, last0), -0.11764705882352941, 0.00001, 'unclamped map')
    assert_in_delta(norm(x[1], start_int, last_int), 0.7, 0.00001, 'map to intermediate')
    assert_in_delta(norm(x[2], start_int, last_int), 1.05, 0.00001, 'unclamped map')
  end

  def test_norm_strict
    x = [10, 140, 210]
    assert_in_delta(norm_strict(x[2], x[0], x[1]), 1.0, 0.00001, 'clamped map to 0..1.0')
    assert_in_delta(norm_strict(x[2], x[1], x[0]), 0.0, 0.00001, 'clamped map to 0..1.0')
    assert_in_delta(norm_strict(x[1], x[0], x[2]), 0.65, 0.00001, 'clamped map to 0..1.0')
  end

  def test_lerp # behaviour is deliberately different to processing which is unclamped
    x = [0.5, 0.8, 2.0]
    start0 = 300
    last0 = 200
    start_int = 0
    last_int = 200
    assert_in_delta(lerp(start0, last0, x[0]), 250, 0.00001, 'produces a intermediate value of a reversed range')
    assert_in_delta(lerp(start_int, last_int, x[1]), 160, 0.00001, 'lerps to an intermediate value')
    assert_in_delta(lerp(start_int, last_int, x[2]), 200, 0.00001, 'lerps to the last value of a range')
  end

  def test_constrain
    x_int = [15, 2_500, -2_500]
    start_int = 0
    last_int = 200
    assert_in_delta(constrain(x_int[0], start_int, last_int), 15, 0.00001)
    assert_in_delta(constrain(x_int[1], start_int, last_int), 200, 0.00001)
    assert_in_delta(constrain(x_int[2], start_int, last_int), 0, 0.00001)
    xf = [15.0, 2_500.0, -2_500.0]
    startf = 0
    lastf = 200.0
    assert_in_delta(constrain(xf[0], startf, lastf), 15.0, 0.00001, 'constrain to 0..200')
    assert_in_delta(constrain(xf[1], startf, lastf), 200.0, 0.00001, 'constrain to 0..200')
    assert_in_delta(constrain(xf[2], startf, lastf), 0.0, 0.00001, 'constrain to 0..200')
  end
end
