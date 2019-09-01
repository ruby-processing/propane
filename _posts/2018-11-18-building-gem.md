---
layout: post
title: "Building propane gem on linux"
date: 2016-11-18 10:00:00
keywords: linux, jdk11, jruby
permalink: /building/
---
Requirements:-

1. An installed version of vanilla processing to provide `processing.org` customised version of the `jogl` jars. The default `Rakefile` assumes root installation of processing, for debian distros you will need to adjust `processing_root` _ca. line 20_.

2. jdk-11+ and maven

Simply clone this distribution, then rake to build and test gem
```bash
git clone https://github.com/ruby-processing/propane.git
cd propane
rake # to build gem
```

[mac]:https://github.com/processing/processing/blob/master/core/apple.jar
