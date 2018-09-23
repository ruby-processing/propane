---
layout: post
title:  "Comparison with ruby-processing"
date:   2015-09-28 06:24:13
permalink: /comparison/
---

<style>
table{
    border-collapse: collapse;
    border-spacing: 0;
    border:2px solid #0000FF;
}

th{
    border:2px solid #0000FF;
}
</style>

|feature       |  ruby-processing  |  propane        |
|----------    |---------------    |-----------      |
|binary        |rp5                |jruby            |
|java          |jdk-7              |jdk-8            |
|version       |processing-2.2.1   |processing-3.4 |
|ruby          |1.9.3              |2.3+             |
|ArcBall       |library            |gem              |
|Vec2D         |library            |built-in         |
|Vec3D         |library            |built-in         |
|DegLut        |library            |built-in         |
|FX2D          |No                 |Yes              |
|App Export    |Yes                |[Experimental][exp]|
|Live mode     |Yes                |Yes              |
|Watch mode    |Yes                |No               |
|`--nojruby`   |see below          |Not Applicable   |
|settings      |no                 |see below        |
|java_args.txt |Sets jvm opt       |see below        |

For ruby-processing the `--nojruby` flag (or running with jruby-complete) is required to run a number of sketches eg `shader` and `load_image`. In propane use the `data_path` wrapper to return the absolute path for the `data` folder [see here][here]. Currently there is no option use jruby-complete instead of an installed jruby (if you want this install [JRubyArt][jruby_art] instead).

Introduced for processing-3.0 is the `settings` method, but this is hidden for users of the [processing ide][settings]. This is where `size` belongs or `full_screen`, also you should set `smooth` and `pixel_density` here. Retina users can make use of their hi-dpi display by setting `pixel_density(2)`, NB: size should be first line of `settings`, and if used `pixel_density(2)` should be next.

In propane we do not use `java_args.txt` to set jruby or java options since you can enter these after the jruby command [see Execution Environments][wiki].

[jruby_art]:{{site.github.url}}/JRubyArt/
[settings]:https://processing.org/reference/settings_.html
[here]:{{site.github.url}}/data_path/
[exp]:https://github.com/poqudrof/propane-rawr-example
[wiki]:https://github.com/jruby/jruby/wiki/FAQs
