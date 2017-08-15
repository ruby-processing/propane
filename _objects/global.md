---
layout: post
title:  "Global Variable"
keywords: App, PApplet, $
---
A global variable in ruby a name beginning with `$`. It can be referred to from anywhere in a program. Before initialization, a global variable has the special value nil. Global variables should be used sparingly. They are dangerous because they can be written to from anywhere. Overuse of globals can make isolating bugs difficult; it also tends to indicate that the design of a program has not been carefully thought out. Whenever you do find it necessary to use a global variable, be sure to give it a descriptive name that is unlikely to be inadvertently used for something else later (calling it something like $foo as above is probably a bad idea).

In propane we used to make the initialised sketch object (formerly Applet with ruby-processing) available as `$app`, since propane-2.5.0 we have removed it in favor of `Propane.app`, a module class object, that can be used within a sketch, but is not globally available. Anyone missing this feature could create their own global sketch instance.
