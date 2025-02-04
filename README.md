<p align="center">
  <img src="https://github.com/user-attachments/assets/9ab1b7d6-eeb3-4c13-b474-57c5150ac552" />
</p>

# Godot Skyrim Lockpicking Minigame

### Things to note:
- Objects were drawn using geometry, draw calls, and Vector points.
- Minor experimentation with shaders for some of the animations.
- State machine and shake shader based on [rapidvectors' original implementation](https://github.com/rapidvectors/rv-state-machine).


### Flow is described as:
- Game randomizes an angle to be guessed.
- Mouse is used as lockpick, Space Bar is used as wedge.
- Holding space bar forces the cylinder.
- Cylinder rotates more the closer it is to the solution gap.
- Lock gets damaged if forced for too long at the wrong spot.


### Shortcomings:
- Once the lock breaks or is solved, game restarts.


### Original SFX from:
- [Jochi @ bandcamp](https://jochi.bandcamp.com/album/free-youtube-sfx-pack)
- ["Wood Break Small 2" @ pixabay](https://pixabay.com/sound-effects/wood-break-small-2-45921/)
