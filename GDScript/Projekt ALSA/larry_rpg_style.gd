extends CharacterBody2D


signal laser(mark_position)

#Movement
func movement():
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * Global.larry_speed
	move_and_slide()

#Laser on Button
func shoot():
	if Input.is_action_just_pressed("action"):
		laser.emit($LaserMarker.global_position)


func _physics_process(_delta):
	movement()
	shoot()
