extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Normal_pressed() -> void:
	$Fade.play("Fade")


func _on_Fade_animation_finished(anim_name: String) -> void:
	if anim_name == "Fade":
		get_tree().change_scene("res://Game.tscn")
	elif anim_name == "FadeHard":
		get_tree().change_scene("res://GameHard.tscn")
	elif anim_name == "FadeEasy":
		get_tree().change_scene("res://GameEasy.tscn")

func _on_Hard_pressed() -> void:
	$Fade.play("FadeHard")


func _on_Easy_pressed() -> void:
	$Fade.play("FadeEasy")
