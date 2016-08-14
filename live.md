---
layout: page
title: Live
permalink: /live/
---
### Live coding with jirb ###
Fire up the jirb console then at irb prompt:-
```ruby
"load 'fred_sketch.rb'"
```

![irb]({{ site.github.url }}/assets/irb.png)

### Live coding with pry and vim ###

First you will need to `jgem install pry`

Easy use configuration in your `~/.bashrc` or `~/.profile` etc include

```bash
alias jpry="jruby -e \"require 'pry'; binding.pry\""
```
Then firing up pry with jruby is as simple as

```bash
jpry
```
For live editing with vim (there is is an emacs alternative see [pry wiki][prywiki])

You should also create or edit `~/.pryrc` to set the live editor

```bash
Pry.config.editor = 'vim'
```
Fire up the pry console then at pry prompt:-

```ruby
"load 'fred_sketch.rb'"
fred = FredSketch.new
edit FredSketch
```
Screen shot on edit from pry

![pry]({{ site.github.url }}/assets/edit_vim.png)

Screen shot on `:wq` from vim

![pry]({{ site.github.url }}/assets/vim_save.png)

Or if you just wanted to edit the draw loop

`edit FredSketch#draw`

[prywiki]:https://github.com/pry/pry/wiki/Customization-and-configuration


