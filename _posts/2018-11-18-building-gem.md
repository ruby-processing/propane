---
layout: post
title: "Building propane gem on linux"
date: 2016-11-18 10:00:00
keywords: linux, jdk11, jruby
permalink: /building/
---

Build Requirements:-

1. An installed version of vanilla processing to provide `processing.org` customised version of the `jogl` jars. The default `Rakefile` assumes root installation of processing, for debian distros you will need to adjust `processing_root` _ca. line 20_.

2. jdk-12+ (minitest and rake gems to test)

Simply clone this distribution, then rake to build and test gem
```bash
git clone https://github.com/ruby-processing/propane.git
cd propane
rake # to build gem
```

You should not even to install maven since we provide a maven wrapper.

Runtime Requirements:-

You may well find that stock jdk version do not play too well with jogl (binder issues), and we recommend you install [adoptopenjdk][adopt], further you can suppress may reflective access warning (and possibly get better start up times) by installing the jruby-launcher gem.

[adopt]:http://ruby-processing.github.io/java/JRubyArt_propane/
[launcher]:http://ruby-processing.github.io/jruby/propane/
