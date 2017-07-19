---
layout: post
title:  "Vim"
permalink: /editors/vim/
keywords: editor, ide, ruby, propane, vim, emacs, jedit
---

Is an excellent choice for linux and mac users, it is lighweight (runs from the console) commands available from vim:-
```bash
:!jruby %   # will run the sketch
```

### Live coding with Pry ###

```bash
jgem install pry
# or jruby -S gem install pry
# or if you must use rvm or rbenv not recommended
```
Do `echo "Pry.config.editor = 'vim'" > ~/.pryrc` to set vim as the pry editor.

Fire up pry using

```bash
jruby -e "require 'pry'; binding.pry"
```

Or more conveniently create a shortcut by using `jpry` alias in your `.bashrc` or equivalent eg `.profile` debian linux:-

```bash
alias jpry="jruby -e \"require 'pry'; binding.pry\""
```

At the pry prompt:-

```ruby
load 'my_sketch'
```

Creating `my_sketch` is a easy as `propane -c my_sketch 300 300`

To get full listing of sketch in pry enter `$` at the prompt, to edit the `draw` method at the prompt do:-

```bash
edit -p MySketch#draw
```

On finished save and quit `:wq` (or `:wqa` to save all changed buffers) sketch will redraw reflecting changes, but you can repeat:-

```bash
edit -p MySketch#draw
```

this allows you to edit your changes which are saved in a `.tmp` file. Read more about vim / emacs integration [here][pry-wiki]

### Other advantages of vim ###

Also because vim is run from the console it is so easy to run old friends like `rubocop` or `reek` on your sketch code.

If you are millenial and allergic to the command line install [atom][atom], emacs is only for hardcore geeks. As yet I don't think pry supports `atom` as a editor.

[atom]:{{ site.github.url }}/atom/
[pry-wiki]:https://github.com/pry/pry/wiki/Editor-integration/
