# frozen_string_literal: true

require 'java'
require_relative 'test_helper'
require_relative '../lib/propane'

METHODS = %i[
  alpha
  ambient
  ambient_light
  apply_matrix
  arc
  background
  begin_camera
  begin_contour
  begin_raw
  begin_record
  begin_shape
  bezier
  bezier_detail
  bezier_point
  bezier_tangent
  bezier_vertex
  blend
  blend_mode
  blue
  box
  brightness
  camera
  color
  color_mode
  copy
  create_font
  create_graphics
  create_image
  create_input
  create_output
  create_reader
  create_shape
  create_writer
  cursor
  curve
  curve_detail
  curve_point
  curve_tangent
  curve_tightness
  curve_vertex
  directional_light
  ellipse
  ellipse_mode
  emissive
  end_camera
  end_contour
  end_raw
  end_record
  end_shape
  fill
  filter
  focused
  frame_count
  frame_rate
  frame_rate
  frustum
  get
  green
  height
  hue
  image
  image_mode
  key
  key_code
  key_pressed
  key_pressed?
  key_released
  key_typed
  lerp_color
  light_falloff
  light_specular
  lights
  line
  load_bytes
  load_font
  load_image
  load_pixels
  load_shader
  load_shape
  load_strings
  load_table
  load_xml
  model_x
  model_y
  model_z
  mouse_button
  mouse_clicked
  mouse_dragged
  mouse_moved
  mouse_pressed
  mouse_pressed?
  mouse_released
  mouse_x
  mouse_y
  no_cursor
  no_fill
  no_lights
  no_smooth
  no_stroke
  no_tint
  noise
  noise_detail
  noise_seed
  normal
  ortho
  perspective
  pixels
  pmouse_x
  pmouse_y
  point
  point_light
  pop_matrix
  print_camera
  print_matrix
  print_projection
  push_matrix
  quad
  quadratic_vertex
  random
  random_seed
  rect
  rect_mode
  red
  request_image
  reset_matrix
  reset_shader
  rotate
  rotate_x
  rotate_y
  rotate_z
  saturation
  save
  save_bytes
  save_frame
  save_stream
  save_strings
  scale
  screen_x
  screen_y
  screen_z
  select_folder
  select_input
  select_output
  set
  shader
  shape
  shape_mode
  shear_x
  shear_y
  shininess
  sketch_title
  size
  smooth
  specular
  sphere
  sphere_detail
  spot_light
  stroke
  stroke_cap
  stroke_join
  stroke_weight
  text_align
  text_ascent
  text_descent
  text_font
  text_leading
  text_mode
  text_size
  text_width
  texture
  texture_mode
  texture_wrap
  tint
  translate
  triangle
  update_pixels
  vertex
  width
].freeze

class TestSketch < Propane::App
  def settings
    size 100, 100
  end

  def setup
    sketch_title 'Sketch Test'
  end

  def draw
    exit if frame_count > 30
  end
end

class SpecTest < Minitest::Test
  def setup
    @propane_sketch = TestSketch.new
  end

  def test_respond
    METHODS.each do |method_string|
      assert_respond_to @propane_sketch, method_string
    end
  end

  def tear_down
    @propane_sketch = nil?
  end
end
