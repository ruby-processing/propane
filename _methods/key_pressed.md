---
layout: post
title:  "key_pressed"
---
In vanilla processing [keyPressed][keyPressed] is both a variable and a method, for propane the boolean variable is available as `key_pressed?`, whereas you can create events/operations that occur on key pressed by adding a `key_pressed` method as below:-

```ruby
def key_pressed  
  # code gets executed on key pressed you can access the `key` variable in this loop
  case key
  when 'c', 'C'
  # do stuff when c is pressed
end
```

For sketch with `key_pressed` method see [raining][raining], follow link for a sketch using [key_pressed?][key_pressed?] or this [alternative][alternative].

See also:-

[key_released][keyReleased]

[key_pressed?]:https://github.com/ruby-processing/propane-examples/blob/master/processing_app/basics/typography/letters.rb
[keyPressed]:https://processing.org/reference/keyPressed_.html
[keyReleased]:https://processing.org/reference/keyReleased_.html
[raining]:https://github.com/ruby-processing/propane-examples/blob/master/contributed/raining.rb
[alternative]:https://github.com/ruby-processing/propane-examples/blob/master/contributed/25_squares.rb
