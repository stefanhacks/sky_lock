<p align="center">
  <img src="https://github.com/user-attachments/assets/aeb71d2a-73c7-4c24-9ad5-038f5a67da60" />
</p>

# Godot Skyrim Lockpicking Minigame
###### Mostly everything is of my own doing, including the ugly bits.

---

### Things to note:
- Objects were drawn using geometry, draw calls, and Vector points.
- Minor experimentation with shaders for some of the animations.
- Simplistic state machine used to segment code. Inspired by @rapidvectors' original implementation.


### Flow is described as:
- Game randomizes an angle to be guessed.
- Mouse is used as lockpick, Space Bar is used as wedge.
- Holding space bar forces the cylinder.
- Cylinder rotates more the closer it is to the solution gap.
- Lock gets damaged if forced for too long at the wrong spot.

### Shortcomings:
- Once the lock breaks or is solved, game restarts.
- Visual Feedback is very minor. Auditory, non existent.

### Where to Go:
- Comment the code.
- Add SFX for feedback.
- Add UI.
