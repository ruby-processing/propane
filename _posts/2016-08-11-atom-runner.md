---
layout: post
title: "Using Atom-Runner to run propane sketches"
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
```

Mac/Windows users could just download direct (or homebrew on Mac)

Tough luck if you want the 32 bit version on linux

### Install Packages ###

From the atom editor install the `atom-runner` package, you might also liek to install the .

### Configure Atom-Runner ###

For the atom menu select (**File -> config**) and edit `config.cson` to include the runner config beneath `"*":` as follows

```cson
"*":
  ...
  'runner':
    'scopes':
       'ruby': 'jruby'
       ...
    'extensions':
       'spec.coffee': 'mocha'
       'ps1': 'powershell –file'
```

See [Atom-Runner][runner] documentation (but note we replace jruby as the ruby executable)

### Running Sketches ###

To run sketches with a `data` folder you should initially open the immediate folder (when using Atom-Runner) eg:

To explore propane samples open `~/propane_samples/regular` or `~/propane_samples/data_path` folder, select a file to view then `alt r` (windows/linux) or `ctrl r` mac to run the selected file.

### What's it look like ###

![atom-runner]({{ site.github.url }}/assets/atom-runner.png)

[runner]:https://github.com/lsegal/atom-runner
[atom]:https://atom.io/
[releases]:https://github.com/atom/atom/releases/tag/v1.9.0
[jedit]:https://ruby-processing.github.io/JRubyArt/editors
[vim]:https://ruby-processing.github.io/JRubyArt/editors
