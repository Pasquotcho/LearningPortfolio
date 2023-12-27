extends CharacterBody2D

@onready var direction = Vector2.RIGHT

signal laser2(positions_enemies)
signal laser_boss(boss_laser_positions)
signal last_phase()

var can_laser = true
var can_get_hit = false
var can_get_hit_lasers = false
var boss_health = 1200
var laser_healthl = 700
var laser_healthm = 1000
var laser_healthr = 700
var laser_rotatedr = false
var laser_rotatedl = false
var last_phase_activated = false
var middle_laser_active = false
var laserl = true
var laserm = true
var laserr = true




#Healthbars
func healthbars():
	if  $"AreaWeaponR/DEBUG HEALTH":
		$"AreaWeaponM/DEBUG HEALTH".value = laser_healthm
	if $"AreaWeaponR/DEBUG HEALTH" != null:
		$"AreaWeaponR/DEBUG HEALTH".value = laser_healthr
	if $"AreaWeaponL/DEBUG HEALTH" != null:
		$"AreaWeaponL/DEBUG HEALTH".value = laser_healthl
	if $".":
		$"DEBUG HEALTH".value = boss_health


func coming_and_laser_logic(delta):
	
	#coming
	if get_node(".").global_position.y < 130:
		get_node(".").global_position.y += Global.scrollspeed * delta
		$LaserTimer.paused = true
		can_get_hit_lasers = false
		
		#Enemis Die at Boss
		$DeathZone.set_collision_mask_value(2, true)
	else:
		#Start Middle laser
		if $LaserM/LaserTimerM.is_stopped():
			$LaserM/LaserTimerM.start()
		
		#Enemies don't Die on Boss
		$DeathZone.set_collision_mask_value(2, false)
		
		#Lasers 
		$LaserTimer.paused = false
		can_get_hit_lasers = true

	#If lasers destroyed Boss hitable
	if laser_healthl <= 0 and laser_healthm <= 0 and laser_healthr <= 0:
		can_get_hit = true

	#Middle Laser disabled when Boss Dead
	if laser_healthm <= 0:
		$LaserM/LaserTimerM.stop()
		$LaserM/CollisionLaserM.disabled = true
		$LaserM/Laser.visible = false
	
	#Lasers Explode and Vanish 
	if laser_healthm <= 0 and laserm == true:
		laserm = false
		$AreaWeaponM/BoomFxM.play("default")
		await $AreaWeaponM/BoomFxM.animation_finished
		$AreaWeaponM/BoomFxM.queue_free()
		$AreaWeaponM/GPUParticles2D2.visible = true
		$AreaWeaponM/GPUParticles2D3.visible = true
		
	if laser_healthl <= 0 and laserl == true:
		laserl = false
		$AreaWeaponL/BoomFxL.play("default")
		await $AreaWeaponL/BoomFxL.animation_finished
		$AreaWeaponL/BoomFxL.queue_free()
		$AreaWeaponL/GPUParticles2D.visible = true
		
	if laser_healthr <= 0 and laserr == true:
		laserr = false
		$AreaWeaponR/BoomFxR.play("default")
		await $AreaWeaponR/BoomFxR.animation_finished
		$AreaWeaponR/BoomFxR.queue_free()
		$AreaWeaponR/GPUParticles2D4.visible = true

#Boss movement
func movement(delta):
	
	velocity = direction * 2000 * delta
	if position.x >= 600:
		direction = Vector2.LEFT
	elif position.x <= 50:
		direction = Vector2.RIGHT


#Canon Movement
func canon_movement(delta):

	#Canons Movement Right
	if get_node(".").global_position.y > 130:
		if $AreaWeaponR.rotation_degrees >= 30:
			laser_rotatedr = true
		if $AreaWeaponR.rotation_degrees <= -30:
			laser_rotatedr = false
		if $AreaWeaponR.rotation_degrees <= 30 and laser_rotatedr == false and laser_healthr > 0:
			$AreaWeaponR.rotation += 0.5 * delta
		else:
			if laser_healthr > 0:
				$AreaWeaponR.rotation -= 0.5 * delta

		#Canons Movement Left
		if $AreaWeaponL.rotation_degrees >= 30:
			laser_rotatedl = false
		if $AreaWeaponL.rotation_degrees <= -30:
			laser_rotatedl = true
		if $AreaWeaponL.rotation_degrees <= 30 and laser_rotatedl == true and laser_healthl > 0:
			$AreaWeaponL.rotation += 0.5 * delta
		else :
			if laser_healthl > 0:
				$AreaWeaponL.rotation -= 0.5 * delta


# Last Phase Signal
func last_phase_signal():
	if laser_healthl == 0 and laser_healthr == 0 and laser_healthm == 0 and last_phase_activated == false:
		last_phase.emit()
		last_phase_activated = true
		$DeathZone.monitoring =false
		$LastPhaseTimer.start()


#Shooting Timer
func _on_laser_timer_timeout():
	shoot()
	$LaserTimer.wait_time = randf()


#Boss gethit with Laser 
func gethit():
	if can_get_hit == true:
		boss_health -= 100
		#Boss Death
	if boss_health <= 0:
		Global.score += 1000
		Global.boss_defeated = true
		$LastPhaseTimer.stop()
		$BoomFxBoss.play("default")
		await $BoomFxBoss.animation_finished
		queue_free()


#Shoot Emiting
func shoot():
	if laser_healthr > 0:
		laser_boss.emit($AreaWeaponR/Marker2D.global_position)
		laser_boss.emit($AreaWeaponR/Marker2D2.global_position)
	if laser_healthl > 0:
		laser_boss.emit($AreaWeaponL/Marker2D3.global_position)
		laser_boss.emit($AreaWeaponL/Marker2D2.global_position)

#############################
#Lasers get Damage and Score#
###########################################
func _on_area_weapon_m_area_entered(area):
	if laser_healthm > 0 and can_get_hit_lasers == true:
		laser_healthm -= 100
		Global.score += 100
		Global.power_up_spawn_counter += 100
		area.queue_free()
	else:
		area.queue_free()

func _on_area_weapon_l_area_entered(area):
	if laser_healthl > 0 and can_get_hit_lasers == true:
		laser_healthl -= 100
		Global.score += 100
		Global.power_up_spawn_counter += 100
		area.queue_free()
	else:
		area.queue_free()

func _on_area_weapon_r_area_entered(area):
	if laser_healthr > 0 and can_get_hit_lasers == true:
		laser_healthr -= 100
		Global.score += 100
		Global.power_up_spawn_counter += 100
		area.queue_free()
	else:
		area.queue_free()
############################################


#Deathzone
func _on_death_zone_body_entered(body):
	if body.name == "LarryCharacter":
		if Global.can_get_hit == true:
			Global.health = -1	
		elif Global.can_get_hit == false and Global.powerup_shield == true:
			Global.health = -1	
		

	elif body.name == "Boss":
		pass
	elif body.name == "Borders":
		pass
	else:
		body.queue_free()

#Middle Laser Damage on Larry
func _on_laser_m_body_entered(body):
	if body.name == 'LarryCharacter':
		$LaserM/HealthLooseTimer.start()
	else:
		body.queue_free()


#Middle Laser Hits Larry
func _on_health_loose_timer_timeout():
	if Global.can_get_hit == true:
		Global.health -= 2


#Middle Laser doesn't Hit Larry anymore
func _on_laser_m_body_exited(body):
	if body.name == 'LarryCharacter':
		$LaserM/HealthLooseTimer.stop()
	#More enemies on last Phase


#Last Phase emitting
func _on_last_phase_timer_timeout():
	last_phase.emit()


#Laser M Timer
func _on_laser_timer_m_timeout():
	if middle_laser_active == false:
		$LaserM/CollisionLaserM.disabled = false
		$LaserM/Laser.visible = true
		middle_laser_active = true
	else:
		$LaserM/CollisionLaserM.disabled = true
		$LaserM/Laser.visible = false
		middle_laser_active = false


#Laser M Colour Change
func laser_m_colour():
	if middle_laser_active:
		$LaserM/Laser.modulate = Color(randf(), randf(), randf(), 1)


func _ready():
	#Healthbars Spawn
		$"DEBUG HEALTH".max_value = boss_health
		$"AreaWeaponM/DEBUG HEALTH".max_value = laser_healthm
		$"AreaWeaponR/DEBUG HEALTH".max_value = laser_healthr
		$"AreaWeaponL/DEBUG HEALTH".max_value = laser_healthl


func _process(_delta):
	last_phase_signal()
	laser_m_colour()


func _physics_process(delta):
	healthbars()
	coming_and_laser_logic(delta)
	movement(delta)
	canon_movement(delta)
	move_and_slide()
