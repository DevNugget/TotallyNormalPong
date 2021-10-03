extends Node

const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT

var amplitude = 0
var priority = 0

onready var camera = get_parent()

func start(duration = 0.2, frequancy = 16, amplitude = 8, priority = 0):
	if priority >= self.priority:
		self.priority = priority
		self.amplitude = amplitude
		
		$Duration.wait_time = duration
		$Frequancy.wait_time = 1 / float(frequancy)
		$Duration.start()
		$Frequancy.start()
		
		new_shake()

func new_shake():
	var rand = Vector2()
	rand.x = rand_range(-amplitude, amplitude)
	rand.y = rand_range(-amplitude, amplitude)
	
	$ShakeTween.interpolate_property(camera, "offset", camera.offset, rand, $Frequancy.wait_time, TRANS, EASE)
	$ShakeTween.start()

func reset():
	$ShakeTween.interpolate_property(camera, "offset", camera.offset, Vector2(), $Frequancy.wait_time, TRANS, EASE)
	$ShakeTween.start()
	
	priority = 0

func _on_Frequancy_timeout() -> void:
	new_shake()

func _on_Duration_timeout() -> void:
	reset()
	$Frequancy.stop()


func _on_Ball_collided() -> void:
	start()
