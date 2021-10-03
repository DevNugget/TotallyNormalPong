extends KinematicBody2D


export var speed = 150
var ball


func _ready() -> void:
	ball = get_parent().find_node("Ball")


func _physics_process(delta: float) -> void:
	move_and_slide(Vector2(0, get_opponent_direction()) * speed)


func get_opponent_direction():
	if (abs(ball.position.y - position.y) > 25):
		if (ball.position.y > position.y): return 1
		else: return -1
	else: return 0
