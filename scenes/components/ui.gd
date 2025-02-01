extends CanvasLayer

@onready var help_container: Control = $HelpContainer
@onready var combo_container: Control = $ComboContainer
@onready var combo_label: Label = $ComboContainer/ComboLabel

var fading = false
var combo_counter = 0:
	set(value):
		if value != 0 and combo_container.modulate.a == 0:
			show_combo()
		
		combo_counter = value
		combo_label.text = "x%s" % combo_counter


func _ready() -> void:
	combo_container.modulate.a = 0


func fade_ui() -> void:
	if fading: return
	fading = true
	
	await get_tree().create_timer(3).timeout
	var tween = get_tree().create_tween()
	tween.tween_property(help_container, "modulate:a", 0, 1)


func show_combo() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(combo_container, "modulate:a", 1, 1)


func _on_idle_first_interaction() -> void:
	fade_ui()


func _on_idle_changed_dificulty() -> void:
	combo_counter = 0


func _on_broken_broke_lock() -> void:
	combo_counter = 0


func _on_solved_solved_lock() -> void:
	combo_counter += 1
