extends KinematicBody2D

signal collided

var velocity = Vector2.ZERO

func _ready() -> void:
	random_vel()

func _physics_process(delta: float) -> void:
	var collision_object = move_and_collide(
		velocity * Global.ball_speed * delta
	)
	if (collision_object):
		velocity = velocity.bounce(
			collision_object.normal
		)
		$AudioStreamPlayer.play()
		emit_signal("collided")
		if Global.ball_speed != 290:
			Global.ball_speed += 30
		elif Global.ball_speed <= 320 and !Global.ball_speed > 320:
			Global.ball_speed += 5

func random_vel():
	randomize()
	velocity.x = [-1, 1][randi() % 2]
	velocity.y = [-0.6, 0.6][randi() % 2]
