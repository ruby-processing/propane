---
layout: post
title:  "Vim"
permalink: /editors/vim/
keywords: editor, ide, ruby, propane, vim, emacs, jedit
---

Is an excellent choice for linux and mac users, it is lighweight (runs from the console) commands available from vim:-
{% highlight bash %}
:!jruby %   # will run the sketch
{% endhighlight %}

### Live coding with Pry ###

To do live [live editing with pry][pry] you should install either [emacs][emacs] or vim, but vim is probably the best.

Do `echo "Pry.config.editor = 'vim'" > ~/.pryrc` to set vim as the pry editor.

### Other advantages of vim ###

Also because vim is run from the console it is so easy to run old friends like `rubocop` or `reek` on your sketch code.

If you are millenial and allergic to the command line install [atom][atom], emacs is only for hardcore geeks. As yet I don't think pry supports `atom` as a editor.

[emacs]:{{ site.github.url }}/emacs/
[atom]:{{ site.github.url }}/atom/
[pry]:{{ site.github.url }}/live/
