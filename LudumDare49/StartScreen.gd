extends Control


var index = 0


func _ready() -> void:
	$Text/Text1.visible = true
	$Blip.play()
	$Timer.start()


func _on_Timer_timeout() -> void:
	if index < 3:
		$Blip.play()
	index += 1
	if index == 1:
		$Text/Text2.visible = true
	if $Text/Text2.visible == true and index == 2:
		$Text/Text3.visible = true
	elif $Text/Text3.visible == true and index == 3:
		$Text/Text4.visible = true
		$Fish.start()


func _on_Fish_timeout() -> void:
	get_tree().change_scene("res://MainMenu.tscn")
