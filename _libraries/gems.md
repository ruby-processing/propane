---
layout: post
title:  "gems<sup>4</sup>"
keywords: library, gem

---
The most convenient library to use in `ruby` is a `gem`, and `propane` is no different, however in addition to pure `ruby gems` there are a number of `gems` that are wrappers for `java` libraries that can be used in `propane`:-

#### ArcBall gem

This library is installed as a `propane` dependency, and is used in 3D sketches to provide arcball manipulation of a 3D object (using quaternions in java).

```ruby
require 'arcball'

class MySketch
  ...
  def setup
    ...
    Processing::ArcBall.init(self)
    ...

```

In the above snippet the sketch viewport is centered at half width and half height of the sketch, which is also the center of rotation. Manipulate the object in the sketch center by dragging the mouse in direction of rotation, or us the mousewheel to zoom.

#### Toxiclibs gem

Is a ruby wrapper around Karsten Schmidts (aka toxi / postspectacular) toxiclibs libraries, in `propane` you should prefer to use this collection of libraries as a `gem`. The toxiclibs libraries are a set of building blocks for computational design, that were  designed to be compatible with processing-2.2.1 (and earlier versions of java). The [gem][toxi] is maintained independently from the version available in the processing ide, and the java code has been updated to make use java-8 and to be compatible with `processing-3.4` and hence `propane`. The gem also provides a convenient [namespaces][ntoxi] for the toxiclibs libraries see [examples sketches][texamples], so you don't have to individualy import the java classes/packages.

#### Geomerative gem

Is a ruby wrapper around Ricard Marxer (@rikrd @ricardmp) [geomerative library][geomerative]. It extends 2D geometry operations to facilitate generative geometry. Includes a TrueType font and an SVG interpreters. See the [gem here][geomgem], which has been updated for java-8 and under the hood imports for Geomerative classes, so that you don't have to.

#### PBox2D gem

Is a java and ruby wrapper around Daniel Murphy (@dmurph) JBox2D library (_JBox2D is a close Java port of Erin Catto's excellent C++ Box2D physics engine and Google's LiquidFun physics Engine._). The java wrapper provides an interface between the processing and game physics worlds.

#### Wordcram gem

Is a ruby wrapper around the [Wordcram library][wordcram] by Dan Bernier, that can be used to create world clouds in JRubyArt or propane. See [documentation][docu].

### Raytracing gem

The [joonsrenderer gem][joons] can be used to ray trace 3D objects in processing sketches. Includes an updated to java-8 version of the java [sunflow library][sunflow], and uses a more up to date version of the [janino compiler][janino].


[janino]:http://janino-compiler.github.io/janino/
[sunflow]:http://sunflow.sourceforge.net/
[joons]:https://ruby-processing.github.io/joonsrenderer/
[docu]:https://ruby-processing.github.io/
[wordcram]:http://wordcram.org/
[geomgem]:https://ruby-processing.github.io/geomerativegem/
[geomerative]:https://github.com/rikrd/geomerative
[ntoxi]:http://ruby-processing.github.io/toxicgem/namespace/
[toxi]:http://ruby-processing.github.io/toxicgem/toxiclibs/update/2015/11/28/introduction.html
[texamples]:https://github.com/ruby-processing/propane-examples/tree/master/external_library/gem/toxiclibs
