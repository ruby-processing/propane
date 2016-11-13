**v2.0.7** Add missing method to ColorUtil.java

**v2.0.6** Update to core processing-3.2.3

**v2.0.5** Update to processing-3.2.2, fix local library load, add proxy_library expand samples
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

**v0.3.0.pre** First pre-release of propane.gem turns out 3D was not working because of missing jar in gem (3D was only going to work on macosx and linux64 OS anyways.

