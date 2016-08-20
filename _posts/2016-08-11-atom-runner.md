---
layout: post
title: "Run propane sketches from atom with script package"
date: 2016-08-11 10:00:00
categories: propane update
keywords: atom, processing, propane, jruby
permalink: _posts/atom-propane
---

### Install Atom ###

See [website][atom] (or scroll to bottom of [releases page for downloads][releases] on github)

For linux ignore any distro version and download latest version (at least 1.9.0) and:-

```bash
sudo dpkg --install atom-amd64.deb # debian, mint, ubuntu
sudo pacman -S atom # Archlinux currently installs 1.9.9
```

Mac/Windows users could just download direct (or homebrew on Mac)

Tough luck if you want the 32 bit version on debian linux

### Install Package ###

From the atom editor install the `script` package by [Kyle Kelley (rgbkrk)][script]

### Running Sketches ###

__Important__ To pick up the local environment you should start atom from a console.
To run sketches with a `data` folder you should initially open the immediate folder eg:

To explore propane samples open `~/propane_samples/regular` or `~/propane_samples/data_path` folder, select a file to view then from Packages/Script select `Run Script`

### What's it look like ###

![atom-runner]({{ site.github.url }}/assets/atom-runner.png)

[script]:https://atom.io/packages/script
[atom]:https://atom.io/
[releases]:https://github.com/atom/atom/releases/tag/v1.9.0
[jedit]:https://ruby-processing.github.io/JRubyArt/editors
[vim]:https://ruby-processing.github.io/JRubyArt/editors
