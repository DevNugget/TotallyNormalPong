extends AudioStreamPlayer

func _physics_process(delta: float) -> void:
	if self.playing == false:
		self.play()
