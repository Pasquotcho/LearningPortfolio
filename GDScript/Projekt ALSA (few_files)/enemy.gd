extends CharacterBody2D


@onready var animation = $BoomFx
@onready var direction = Vector2.RIGHT

signal laser2(positions_enemies)


var can_laser = true
var can_get_hit = true


#Enemie Movement
func movement(delta):
	velocity = direction * 200
	if position.x >= 600:
		direction = Vector2.LEFT
	elif position.x <= 50:
		direction = Vector2.RIGHT
	if Global.enemies_can_move == true:
		$".".position.y += Global.scrollspeed * delta
	move_and_slide()


#Enemy Explodes on Laser and Score
func gethit():
	if can_get_hit == true: 
		can_get_hit = false
		Global.score += 100
		Global.killcount += 1
		Global.power_up_spawn_counter += 100
		Global.ss_reducer += 100
		animation.play("default")
		await animation.animation_finished
		queue_free()


#Damage on Player when Hits and Invincible Frame
func _on_enemie_area_body_entered(body):
	if body.name == "LarryCharacter" and Global.can_get_hit == true:
		Global.can_get_hit = false
		animation.play("default")
		await animation.animation_finished
		Global.health -= 20
		Global.can_get_hit = true
		Global.killcount += 1
		queue_free()
	elif body.name == "LarryCharacter" and Global.can_get_hit == false and Global.powerup_shield == true:
		Global.score += 100
		Global.killcount += 1
		animation.play("default")
		await animation.animation_finished
		queue_free()


func _physics_process(delta):
	movement(delta)








