**v3.2** Now is the time for some serious refactoring for jdk11. Might even work on MacOS and Windows, ahead of vanilla processing.

**v2.9.1** Attempt to bring 64 bit Windows users to party. Use non versioned jogl/opengl jars from processing distro, including processing.org apple.jar in case it's needed, MacOS users are being very opaque on this.

**v2.9.0** No-one helped with think_open branch, that was trying to get ready for jdk9 (as compilable), so I'm abandoning 2.8.0 series, the 2.9.0 version will create an integrated jar and concentrate on compatibility, rather than be future looking (but I'm not sure that think_different is any use or will work in future). Anyone having difficulty on MacOS should try putting apple.jar into lib folder.

**v2.7.2** Slight re-factor of control_panel, fix virgin install of libraries folder, add grafica library examples suggest upgrade to jruby-9.1.17.0

**v2.7.1** Avoid calling protected method in control_panel (ready for jdk9)

**v2.7.0** Now using custom icons, nice blue ruby image

**v2.6.6** Using a modified processing-core to support jdk9 (NB FX2D and sketches with control_panel using sliders are still expected to fail with jdk9). Jdk8 users should not notice any change.

**v2.6.5** bump for processing-3.4

**v2.6.4** Vec2D and Vec3D now support `copy` constructor where the original can be a duck-type. Further the only requirement is that the duck-type responds to `:x`, and `:y` by returning a `float` or `fixnum` thus Vec2D can be promoted to Vec3D (where `z = 0`), or more usually some other Vector or Point class can be used as the original. A VectorUtils library has been implemented, see examples for usage.

**v2.6.3** Bump recommended upgrade to jruby-9.1.16.0, possibly the last in 9.1 series?

**v2.6.2** Features example sketches using the PixelFlow library by Thomas Diewald

**v2.6.1** Bump processing version, bump recommended jruby version.

**v2.6.0** Refactored `LibraryLoader` knows less about `Library` class.  The library class _knows_ about paths, and checks that they exist. Currently has ability to load `GLVideo` library, that will eventually become the new video libary (supports gstreamer-1.0 instead of gstreamer-0.1.0 that has already been dropped by some linux distros).

**v2.5.5** Intermediate `refactored_library` loader, can be release if required but still not there as regards refactor goals.

**v2.5.0** No need for `$app` we can replace with `Propane.app`

**v2.4.1** Add `post_initialize` hook to `app.rb`.

**v2.4.0** Extend LibraryProxy to include mouseEvent and keyEvent.

**v2.3.4** Simplify `control_panel` library (replacing `c.title = 'PaneTitle'` with `c.title('PaneTitle')`) also enable use of `block` with `button's`.

**v2.3.3** Update to processing-3.3.4, and upgrade jruby-9.1.12.0 last in 9.1 series?

**v2.3.3** Update to processing-3.3.2

**v2.3.1** Update to processing-3.3.1, Update samples which now include `#!/usr/bin/env jruby` to assist running sketches from atom, add Rakefile for automatic sketch running for many samples, expected upgrade to final jruby-9.1.x.x

**v2.3.0** Update to core processing-3.3 `grid` method now implemented in java, bump examples to include WOVNS

**v2.1.1** Update to core processing-3.2.4 and JRuby-9.1.7.0

**v2.1.0** Add missing method to ColorUtil.java, `include HelperMethods, PConstants, Math, MathTool` in `Propane::Proxy`, it is just simpler that way. Mixin Renderer for AppRender and ShapeRender. Changes to `Propane::Proxy` are significant enough to warrant versioning bump, samples making use of new code will not be runable by earlier versions.

**v2.0.6** Update to core processing-3.2.3

**v2.0.5** Update to processing-3.2.2, fix local library load, add `proxy_library` expand samples

**v2.0.4** Correct `norm_strict`, add `math_tool_test` add `simplex_noise` expand samples

**v2.0.3** Suggest use of jruby-9.1.4.0, more about loading vanilla libraries

**v2.0.2** Refactor install to either install `samples\sound\video` or warn (update to use a local processing-3.2.1 core, this is why travis fails), fix some examples, hence `0.3`

**v2.0.1** Support processing-3.2.0

**v2.0.0** Refactored to work with processing-3.0, `--install samples` and/or vanilla processing `sound` and `video` libraries

**v0.9.0** Implements `data_path` in ruby, you should use this method to return the absolute path to the `data` folder (read and write).  Prefer JRubyArt methods, in the main.

**v0.8.0** Complete samples refactored to `data_path` folder, no longer require jruby-complete to run because we provide an absolute path to `data` folder, but it still probably requires that you run the sketch from the directory. Future direction might be to create a `~/.propane` folder, which would support additionalvanilla processing libraries, also integration with `atom` editor.

**v0.7.0** Update to JRuby-Complete-9.1.2.0.

**v0.6.0** Includes a sketch creator utility 3D still only for linux64 and macosx, any Windows developers are welcome to extend to windows (should be easy), includes slider in sketch library, change to requiring jdk8. Update to JRuby-Complete-9.1.0.0, request updated arcball (to run samples).

**v0.5.0** Includes a sketch creator utility 3D still only for linux64 and macosx, any Windows developers are welcome to extend to windows (should be easy).

**v0.4.0.pre** Inclusion of jogl-all.jar should fix 3D if install fails try getting rid of previous versions of gem (especially if you had done local installs, foxed me first) 3D still only for linux64 and macosx, any Windows developers are welcome to extend to windows (should be easy).

**v0.3.0.pre** First pre-release of propane.gem turns out 3D was not working because of missing jar in gem (3D was only going to work on macosx and linux64 OS anyways).
