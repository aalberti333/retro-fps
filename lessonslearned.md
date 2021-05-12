# Lessons learned
This is for general knowledge that's picked up during the course for future reference. It'll be pretty random and scattered, but serves as a quick-read-through-reference for future projects.

* When baking a navigation mesh, it needs to be a child of the environment you'd like to bake initially (for example, ground). AFTER that, you can move it to exist under the navigation node.

* Timers can be used to directly test signals

* Layer: what exists on you (who you are, your hit boxes, etc.), Mask: what you collide with

* Connecting signals can be done programatically (ex: `health_manager.connect("dead", self, "kill")`)

* `posmod()` used to get a positive modulus result when using negative numbers

* To stop weapons from clipping into walls, scale it down and place it in front of the player, and within the player's collider.

* Always make sure positions/rotations/scale of parent and child nodes are similar (in case of the machete, this lead to issues with the animation player). Also, scaling sizes of objects (`.glb` files) should be done directly on the objects, not their parents (miziziziz scales on objects and keyframed the spatial parent, where I scaled on the spatial parent *in addition to* keyframing on the parent. My mistake lead to difficulties in key framing the graphics. That is, I couldn't reset them back to zero, I had to remember what the previous z value was for example)

* Try to keep animation names consistent (all lowercase, had an oops in this project where `Idle` was used instead of `idle`)