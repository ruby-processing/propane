---
layout: post
title: "Setting up atom for propane"
date: 2016-08-05 12:00:00
categories: propane update
keywords: atom, processing, propane 
permalink: _posts/atom
---

### Install Atom ###

See [website][atom] (or scroll to bottom of [releases page for downloads][releases] on github)

For linux ignore any distro version and download latest version (at least 1.8.0) and:-

```bash
sudo dpkg --install atom-amd64.deb # debian, mint, ubuntu
```

Mac/Windows users could just download direct (or homebrew on Mac)

Tough luck if you want the 32 bit version on linux

### Install Packages ###

From the atom editor install the `project-runner` and `script` packages.

To explore propne examples open `k9_samples` folder, select `project-runner` from the menu, then choose the run from the sub-menu, launches sketches in a random order per folder.

### What's it look like ###

<img src="/assets/rakefile.png" />

Individual sketches will run directly with the `script` package.

[atom]:https://atom.io/
[releases]:https://github.com/atom/atom/releases/tag/v1.9.0

