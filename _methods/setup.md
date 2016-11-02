---
layout: post
title:  "setup"
---
All sketches will propably have a user defined [setup][setup] method. This is where you define the sketch title and where static code belongs.

{% highlight ruby %}
def setup
  sketch_title 'My sketch'
  # ... static code
end
{% endhighlight %}

 Note to make variables declared in setup in the rest of sketch, you can make use of ruby `attr_reader` as for the `pts` array below.

{% highlight ruby %}
attr_reader :pts

 def setup
   sketch_title 'My sketch'
   @pts = []
   # ... static code
 end
 {% endhighlight %}  

 When the you can access `pts` in say the draw loop

 {% highlight ruby %}
 def draw
   p pts.length
   # ... static code
 end
 {% endhighlight %}  

[settings]:https://processing.org/reference/setup_.html
