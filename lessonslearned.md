# Lessons learned
This is for general knowledge that's picked up during the course for future reference. It'll be pretty random and scattered, but serves as a quick-read-through-reference for future projects.

* When baking a navigation mesh, it needs to be a child of the environment you'd like to bake initially (for example, ground). AFTER that, you can move it to exist under the navigation node.

* Timers can be used to directly test signals

* Layer: what exists on you (who you are, your hit boxes, etc.), Mask: what you collide with

* Connecting signals can be done programatically (ex: `health_manager.connect("dead", self, "kill")`)