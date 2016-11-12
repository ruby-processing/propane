---
layout: post
title:  "Windows"
date:   2015-11-21 14:15:13
permalink: /windows/
---
### Install linux ###

If you've got a Windows machine it is probably much easier than you think to install linux OS, for most people the sensible choice would be [Mint][mint] / [Ubuntu][ubuntu]. You should do this because Microsoft Windows has never been [OSS friendly][oss], you will learn a lot (MacOS is not very OSS friendly either, and just too expensive but it is somewhat more [posix][posix] compliant). Unless you have an Intel graphics card, you should probably use the closed source drivers (but free as in free beer from manufacturers). On Mint you should use the `Adminstration/Driver Manager` to check/install such drivers (eg NVidia-375.10). In general you should prefer to use the graphical tools to install software on Debian, but sometimes versions will be out of date see [Install Debian][debian]

### Stick with what you know ###

Vanilla processing is not too bad, but you could also try [JRubyArt][jruby_art]

### Become an OSS hero ###

Help make [propane][propane] work on Windows (it should be quite easy, should only need addition of JOGL binaries) and test what already works (ie should mostly work but without OPENGL support). To do this you should fork the [distro][propane] and submit a PR, ideally you will be familiar with maven, github, and ruby, but you could surprise yourself.


[mint]:https://www.linuxmint.com/

[ubuntu]:http://www.ubuntu.com/

[jruby_art]:https://ruby-processing.github.io/JRubyArt/

[propane]:https://github.com/ruby-processing/propane

[posix]:https://en.wikipedia.org/wiki/POSIX

[oss]:https://en.wikipedia.org/wiki/Open-source_software

[debian]:{{ site.github.url }}/debian
