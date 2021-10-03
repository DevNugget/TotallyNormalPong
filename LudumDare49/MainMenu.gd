extends Control


func _physics_process(delta: float) -> void:
	if (Input.is_action_just_pressed("ui_accept")):
		$Fade.play("Fade")


func _on_Fade_animation_finished(anim_name: String) -> void:
	if (anim_name == "Fade"):
		get_tree().change_scene("res://LevelSelect.tscn")
