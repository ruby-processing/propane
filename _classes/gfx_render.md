---
layout: post
title:  "GfxRender and ShapeRender"
keywords: to_vertex, Vec3D, Vec2D, GfxRender, ShapeRender
---
Vec2D and Vec3D classes can be efficiently rendered as both PApplet vertices, and PShape vertices using GfxRender and ShapeRender utility classes. To use the GfxRender renderer you should create a single instance see below example:-

### GfxRender

```ruby

...
def renderer
  @renderer = Propane::GfxRender.new(g)
end
...
```

Here is a snippet of code for a 2D sketch, where we draw a polygon outline directly using the processing vertex (nested within `begin_shape` and `end_shape(CLOSE)`). All we need to do is supply our renderer as an argument to the Vec2D `:to_vertex` instance method.

```ruby
...
begin_shape # Vec2D example
  no_fill
  stroke(255)
  morph.each do |v|
    v.to_vertex(renderer)
  end
end_shape(CLOSE)
...
```

If you chose not use the renderer, this is how the code would look, requires more ruby to java conversions:-

```ruby
...
begin_shape # Vec2D example
  no_fill
  stroke(255)
  morph.each do |v|
    vertex(v.x, v.y)
  end
end_shape(CLOSE)
...
```

### ShapeRender

Usage of the ShapeRender is similar, except that you need to `create_shape` first, and it is the created `shape` that is needed to initialize the ShapeRender. Here is a code snippet for use of a `ShapeRender` with `Vec2D`, where `original` is an array of `Vec2D` describing a closed polygon.
...
def renderer(shp)
  @renderer = Propane::ShapeRender.new(shp)
end
...
```

```ruby
attr_reader :s
...
@s = create_shape
s.begin_shape
s.fill(127)
s.stroke(0)
s.stroke_weight(2)
original.map{ |v| v.to_vertex(renderer(s)) }
s.end_shape(CLOSE)
...
shape(s)
```

There is also the possibility of adding texture see this `ShapeRender` usage snippet:-

```ruby
...

...
def renderer(shp)
  @renderer = Propane::ShapeRender.new(shp)
end
...
```

# Put all the relevant data into the PShape

texture_mode(NORMAL) # set texture_mode to normalized (range 0 to 1)
tex = load_image(data_path 'Texture01.jpg')

mesh = create_shape # create the initial PShape
mesh.begin_shape(QUADS) # define the PShape type: QUADS
mesh.no_stroke
mesh.texture(tex) # set a texture to make a textured PShape
# put all the vertices, uv texture coordinates and normals into the PShape
positions.each_with_index do |p, i|
  t = tex_coords[i]
  p.to_vertex_uv(renderer(mesh), t.x, t.y)
end
mesh.end_shape
...
```

The above snippet is taken from the [glsl_heighmap_noise.rb sketch][glsl], for another example of the advanced use of the ShapeRender class see the [trefoil sketch][trefoil]. Warning if you are using ShapeRender inside a custom class you need to prefix it with the sketch class name `Sketch::` for bare sketches, see [wiggle_pshape][wiggling] sketch.

[glsl]:https://github.com/ruby-processing/propane-examples/blob/master/processing_app/topics/shaders/glsl_heightmap_noise.rb
[trefoil]:https://github.com/ruby-processing/propane-examples/blob/master/processing_app/demos/graphics/trefoil.rb
[wiggling]:https://github.com/ruby-processing/propane-examples/blob/master/processing_app/library/vecmath/vec2d/wiggle_pshape.rb
