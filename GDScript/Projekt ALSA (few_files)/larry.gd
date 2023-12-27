
extends CharacterBody2D

@onready var animation = $BoomFx

signal laser(positions)

var laser_pos = true
var can_laser = true
var speed = 500



#Basic Movement
func movement():
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * Global.larry_speed
	move_and_slide()


#Left and Right Tilt
func movement_side():
	#Add Left Right Animation
	$LarryAnimated.rotation = 0
	if Input.is_action_pressed("left"):
		$LarryAnimated.rotation = 75		
	if Input.is_action_pressed("right"):
			$LarryAnimated.rotation = -75

#Boost Trail
func trail_stop():
	if Input.is_action_pressed("down"):
		$Particles/GPUParticles2D.amount = 1
		$Particles/GPUParticles2D2.amount = 1
		$Particles/GPUParticles2D3.amount = 1
		$Particles/GPUParticles2D4.amount = 1
	else:
		$Particles/GPUParticles2D.amount = 30
		$Particles/GPUParticles2D2.amount = 30
		$Particles/GPUParticles2D3.amount = 30
		$Particles/GPUParticles2D4.amount = 30


#On Boss Kill Level Switch
func suck_into_teleporter(delta):
#Suck Into Teleporter
	var direction = Vector2($TeleporterMarker.position - $".".position).normalized()
	velocity = direction * Global.larry_speed
	$".".rotation += 5 * delta
	can_laser = false
	move_and_slide()


#Hitmarker
func _on_hitmarker_timer_timeout():
	$".".modulate = Color(1,1,1,1)


#How fast Larry can Shoot
func laser_timer():
	$LaserTimer.wait_time = Global.waittime


#onready
func _ready():
	#Pause
	process_mode = $".".PROCESS_MODE_PAUSABLE


#Emit Laser Signal
func shoot_laser():
	
	if Input.is_action_pressed("action") and can_laser == true:
		can_laser = false
		$LaserTimer.start()
		var laser_markers = $LaserMarkers.get_children()

		#Emit laser position left/right
		if laser_pos == true:
			var selected_laser = laser_markers[0]
			laser_pos = false
			laser.emit(selected_laser.global_position)
			$AudioStreamPlayer.play()
		else:
			var selected_laser = laser_markers[1]
			laser_pos = true
			laser.emit(selected_laser.global_position)
			$AudioStreamPlayer.play()


#Death on Global Health 0 
func death():
	if Global.health <= 0: 
		Global.highscore_update()
		queue_free()
		#Transition
		TransitionScreen.change_scene("res://scenes/levels/death_screen_animated(code).tscn")


#Power Up Shield ON/OFF
func power_up_shield():
	if not $PowerUpShield/PowerUpTimer.is_stopped():
		$PowerUpShield/ProgressBar.visible = true
		$PowerUpShield/ProgressBar.value = $PowerUpShield/PowerUpTimer.time_left
	#Power Up Shield
	if Global.powerup_shield == true:
		Global.can_get_hit = false
		$PowerUpShield/Animation.play("Shield")
		$PowerUpShield.visible = true
		if $PowerUpShield/PowerUpTimer.is_stopped():
			$PowerUpShield/PowerUpTimer.start()
	if Global.powerup_shield == false:
		$PowerUpShield/Animation.stop()
		$PowerUpShield.visible = false
		Global.can_get_hit = true


#DEBUG functions
func DEBUG_functions():
		###DEBUG###
	if Input.is_action_just_pressed("debug") and Global.transition == false:
		$"DebugMenü".visible = true
		get_tree().paused = true
	if Input.is_action_just_released("test 2"):
		Global.waittime = 0.01
	if Input.is_action_just_released("test 3"):
		Global.larry_speed = 1500
	if Input.is_action_just_released("test 4"):
		Global.health = 100000000000000
	if Input.is_action_just_released("test 5"):
			Global.scrollspeed += 100
	#Boss Spawn Debug
	if Input.is_action_just_released("test"):
		Global.killcount = 999999


#Damage and Hitmarker 
func gethit():
	if Global.can_get_hit == true:
		Global.can_get_hit = false
		Global.health -= 20
		$".".modulate = Color(0.84, 0, 0, 1)
		$HitmarkerTimer.start()
		$InvincibleTimer.start()
		
		#


########
#TIMERS#
#########################################
func _on_invincible_timer_timeout():
	Global.can_get_hit = true

func _on_power_up_timer_timeout():
	Global.powerup_shield = false

func _on_laser_timer_timeout():
	can_laser = true

##########################################


func _process(_delta):
	
	power_up_shield()
	
	DEBUG_functions()
	
	trail_stop()


func _physics_process(delta):
	if Global.character_should_stop == false:
		
		laser_timer()
		
		movement()
		
		movement_side()
		
		death()
		
		shoot_laser()
	else:
		suck_into_teleporter(delta)










