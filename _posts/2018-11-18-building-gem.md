---
layout: post
title: "Building propane gem on linux"
date: 2016-11-18 10:00:00
keywords: linux, jdk11, jruby
permalink: /building/
---

Build Requirements:-

1. LatestJOGL jars 2.4.0-rc. The default `Rakefile` assumes jogl jars are in a local folder

2. jdk-11+ (minitest and rake gems to test)

Simply clone this distribution, then rake to build and test gem
```bash
git clone https://github.com/ruby-processing/propane.git
cd propane
rake # to build gem
```

You should not even to install maven since we provide a maven wrapper.

Runtime Requirements:-

At least jruby-9.3.0.0 and jdk11, rake. Nice to have rubocop.

[adopt]:http://ruby-processing.github.io/java/JRubyArt_propane/
[launcher]:http://ruby-processing.github.io/jruby/propane/
