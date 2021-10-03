extends Node2D

const BALL = preload("res://Ball.tscn")
var flipped = false

func _ready() -> void:
	Global.player_score = 0
	Global.opp_score = 0
	$Flip.start()
	$FlipBodies.wait_time = rand_range(15, 30)
	$FlipBodies.start()


func _physics_process(delta: float) -> void:
	$UI/PlayScore.bbcode_text = " " + str(Global.player_score)
	$UI/OppScore.bbcode_text = " " + str(Global.opp_score)
	if flipped == false:
		$Player.position.x = 16
		$Opponent.position.x = 624
	else:
		$Player.position.x = 624
		$Opponent.position.x = 16
	if Global.player_score == 10:
		$Ball.position = Vector2(1000, 1000)
		$UI/RichTextLabel.visible = false
		$UI/RichTextLabel2.visible = false
		$UI/OppScore.visible = false
		$UI/PlayScore.visible = false
		$UI/Victory.visible = true
		Global.player_score = 11
		$End.start()
	elif Global.opp_score == 10:
		$Ball.position = Vector2(1000, 1000)
		$UI/RichTextLabel.visible = false
		$UI/RichTextLabel2.visible = false
		$UI/OppScore.visible = false
		$UI/PlayScore.visible = false
		$UI/Defeat.visible = true
		Global.opp_score = 11
		$End.start()
	

func _on_Goals_body_entered(body: Node) -> void:
	if (body.name == "Ball"):
		Global.player_score += 1
		$UI/RichTextLabel.visible = true
		$Timer.start()
		$ScoreSound.play()


func _on_Goals2_body_entered(body: Node) -> void:
	if (body.name == "Ball"):
		Global.opp_score += 1
		$UI/RichTextLabel2.visible = true
		$Timer.start()
		$ScoreSound.play()

func dash_freeze(timeScale, duration):
	Engine.time_scale = timeScale
	yield(get_tree().create_timer(duration * timeScale), "timeout")
	Engine.time_scale = 1.0


func score():
	$UI/RichTextLabel2.visible = false
	$UI/RichTextLabel.visible = false
	$Ball.position = Vector2(320, 180)
	$Ball.random_vel()
#		var ball = BALL.instance()
#		ball.position = Vector2(320, 180)
#		add_child(ball)
#		$Ball.queue_free()
	Global.ball_speed = 200



func _on_Timer_timeout() -> void:
	score()


func _on_Flip_timeout() -> void:
	$SwapSound.play()
	$AnimationPlayer.play("Flicker")



func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "Flicker":
		var pp = Global.player_score
		var op = Global.opp_score
		Global.player_score = op
		Global.opp_score = pp
		$Flip.wait_time = rand_range(15, 30)
		$Flip.start()


func _on_FlipBodies_timeout() -> void:
	if flipped == false:
		flip_sides()
	elif flipped == true:
		flip_back()
	$FlipBodies.wait_time = rand_range(15, 30)
	$FlipBodies.start()


func flip_sides():
	var player_score_pos = $UI/PlayScore.rect_position
	var opp_score_pos = $UI/OppScore.rect_position
	var player_pos = $Player.position
	var opp_pos = $Opponent.position
	var left_pos = $Goals2/CollisionShape2D3.position
	var right_pos = $Goals/CollisionShape2D4.position
	$UI/OppScore.rect_position = player_score_pos
	$UI/PlayScore.rect_position = opp_score_pos
	$Goals2/CollisionShape2D3.position = right_pos
	$Goals/CollisionShape2D4.position = left_pos
	$Player.position = opp_pos
	$Opponent.position = player_pos
	$Player.rotation_degrees = 180
	flipped = true


func flip_back():
	var player_score_pos = $UI/PlayScore.rect_position
	var opp_score_pos = $UI/OppScore.rect_position
	var player_pos = $Player.position
	var opp_pos = $Opponent.position
	var left_pos = $Goals2/CollisionShape2D3.position
	var right_pos = $Goals/CollisionShape2D4.position
	$UI/OppScore.rect_position = player_score_pos
	$UI/PlayScore.rect_position = opp_score_pos
	$Goals2/CollisionShape2D3.position = right_pos
	$Goals/CollisionShape2D4.position = left_pos
	$Player.position = opp_pos
	$Opponent.position = player_pos
	$Player.rotation_degrees = 0
	flipped = false


func _on_End_timeout() -> void:
	get_tree().change_scene("res://MainMenu.tscn")
