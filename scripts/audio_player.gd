class_name AudioPlayer
extends Node

@export var lockpicking_sfx: Array[AudioStream]
@export var opening_sfx: AudioStream
@export var breaking_sfx: AudioStream

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D


func _on_broken_broke_lock() -> void:
	audio_stream_player_2d.stream = breaking_sfx
	audio_stream_player_2d.pitch_scale = randf_range(1, 1.5)
	audio_stream_player_2d.play()


func _on_solved_opened_lock() -> void:
	audio_stream_player_2d.stream = opening_sfx
	audio_stream_player_2d.pitch_scale = randf_range(0.8, 1.2)
	audio_stream_player_2d.play()


func _on_forcing_forcing() -> void:
	var sound_index = randi_range(0, lockpicking_sfx.size() - 1)
	audio_stream_player_2d.stream = lockpicking_sfx[sound_index]
	audio_stream_player_2d.pitch_scale = randf_range(0.9, 1.2)
	audio_stream_player_2d.play()
