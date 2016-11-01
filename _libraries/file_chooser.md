---
layout: post
title:  "File Chooser<sup>2</sup>"
keywords: library, chooser, gui, processing

---
<sup>2</sup><i>A built in hybrid ruby/java library</i>

Start by loading in the chooser library, the purpose of this library is to allow you to use the vanilla processing interface to the `native file chooser` (it is almost impossible to use vanilla processing reflection methods without this sort of wrapper)

```ruby
#!/usr/bin/env jruby -v -W2

require 'propane'
###########
# Example Native File Chooser using vanilla processing
# select_input, and file_selected
###########
class SelectFile < Propane::App

  load_library :file_chooser


  def settings
    size 200, 100
  end

  def setup
    sketch_title 'Select File, native chooser'
    # java_signature 'void selectInput(String, String)'
    select_input('Select a File', 'file_selected')
  end

  #  signature 'void file_selected(java.io.File file)'
  def file_selected(file)
    puts file.get_absolute_path unless file.nil?
  end
end

SelectFile.new
```

See also [these examples](https://github.com/ruby-processing/propane-examples/tree/master/processing_app/library/file_chooser)
