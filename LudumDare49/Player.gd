extends KinematicBody2D

var speed = 225
var is_triangle = false
var is_circle = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start()


func _physics_process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if (Input.is_action_pressed("up")):
		velocity.y -= 1
	if (Input.is_action_pressed("down")):
		velocity.y += 1
	
	move_and_slide(velocity * speed)


func _on_Timer_timeout() -> void:
	var chance = rand_range(1, 6)
	if chance > 2.5:
		if is_triangle == false:
			turn_triangle()
		else: turn_normal()
	if chance < 2.5:
		if is_circle == false:
			turn_circle()
		else: turn_normal()
	$Timer.wait_time = rand_range(5, 20)
	$Timer.start()
	print("timeout")


func turn_triangle():
	is_circle = false
	is_triangle = true
	$Sprite.visible = false
	$TrianglePaddle.visible = true
	$CirclePaddle.visible = false
	$CollisionShape2D.set_deferred("disabled", true)
	$TriangleCollisionShape.set_deferred("disabled", false)
	$CollisionShape2D2.set_deferred("disabled", true)


func turn_normal():
	is_circle = false
	is_triangle = false
	$Sprite.visible = true
	$TrianglePaddle.visible = false
	$CirclePaddle.visible = false
	$CollisionShape2D.set_deferred("disabled", false)
	$TriangleCollisionShape.set_deferred("disabled", true)
	$CollisionShape2D2.set_deferred("disabled", true)


func turn_circle():
	is_circle = true
	is_triangle = false
	$Sprite.visible = false
	$TrianglePaddle.visible = false
	$CirclePaddle.visible = true
	$CollisionShape2D.set_deferred("disabled", true)
	$TriangleCollisionShape.set_deferred("disabled", true)
	$CollisionShape2D2.set_deferred("disabled", false)
