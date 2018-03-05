---
layout: post
title:  "Atom"
permalink: /editors/atom/
keywords: ide, ruby, propane, atom
---
Unless you are a vim aficionado you should probably prefer to use atom.

### Install Atom ###

See [website][atom] (or scroll to bottom of [releases page for downloads][releases] on github)

For linux ignore any distro version and download latest version (preferably 1.24.0+) and:-

```bash
sudo dpkg --install atom-amd64.deb # debian, mint, ubuntu
sudo pacman -S atom # Archlinux currently installs 1.24.0
```

MacOS/Windows users could just download direct (or homebrew on MacOS)

Tough luck if you want the 32 bit version on debian linux

### Install Packages ###

From the atom editor install the `script` package by [Kyle Kelly (rgbkrk)][script]

While you are at install the `language-jruby-art` package [by Martin Prout][language] for code snippets (includes a outline propane sketch)

Also install `set-syntax` package by Lee Dohm to allow easy setting of buffer syntax

Make sure you are in `JRuby Art` edit mode (_click on bottom right hand corner to choose_).

Or if you've installed `set-syntax` load command palette with `ctrl-shift-p` and enter `ssjru` to choose.

The use `prsk` snippet to create a propane sketch

![enter 'prsk']({{ site.github.url }}/assets/animation.gif)

Use `ctrl-s` to save.

### To run a sketch ###

If you wish to run sketches using local environmental variables with [script][script] (and you probably do) you should start atom from a shell in the directory containing your sketch

```bash
atom . # or atom sketch.rb
```

NB: Sketches will not run properly `Ruby on Rails` mode make sure you are in `Ruby` or `JRuby Art` mode to run sketches from atom (it is unfortunate that atom by default recognizes sketches as `Ruby on Rails` artifacts).

It is also possible to run sketches with a custom profile (ie for jruby) but I have found just regular run script (to run `ruby`) works ok with `#!/usr/bin/env jruby` at start of sketch (`rvm`, `rbenv` user might not need this?).  To run a different sketch, navigate to the sketch (file) and use either `script` menu, or `shift+alt+b` _linux/windows_ or `cmd+i` _macOS_. _If you change directories (and your sketches need data folder etc) you may need to restart atom from the new folder._

### What's it look like ###

![atom-k9]({{ site.github.url }}/assets/jwishy.png)

### Expanding / Modifying snippets ###

Navigate to ~/.atom/packages/language-jruby-art/snippets and edit `language-jruby-art.cson`

### Linter Ruby Leek package etc

Fans of Sandi Metz will probably want to install linter-ruby-reek and rubocop packages, the latter v. useful for detecting stupid coding errors.

[language]:https://atom.io/packages/language-jruby-art
[script]:https://atom.io/packages/script
[atom]:https://atom.io/
[releases]:https://github.com/atom/atom/releases/tag/v1.20.0
