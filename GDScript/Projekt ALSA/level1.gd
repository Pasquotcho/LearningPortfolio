extends Node2D

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser_1.tscn")
var enemy_1: PackedScene = preload("res://scenes/enemies/enemie_1.tscn")
var enemy_2: PackedScene = preload("res://scenes/enemies/enemie_2.tscn")
var asteroid: PackedScene = preload("res://scenes/enemies/asteroid.tscn")
var boss = preload("res://scenes/enemies/boss.tscn")
var power_up: PackedScene = preload("res://scenes/fx/power_up.tscn")
var laser_scene_enemy: PackedScene = preload("res://scenes/projectiles/laser_2.tscn")
var enemy_spawn_counter = 0
var enemy_counter = 0
var boss_spawned = false


#Faster scrollspeed for score
func scrollspeed():
	if Global.ss_reducer >= 500:
		Global.scrollspeed += 1
		print("Enemy Scrollspeed added")
		Global.ss_reducer = 0


#PowerUp Counter and Spawner
func powerup_spawner():
	if Global.power_up_spawn_counter >= 1000:
		Global.power_up_spawn_counter = 0
		_spawn_powerup(null)	


#Teleporter
func teleporter(delta):
	if Global.boss_defeated == true:
		$Teleporter/DetectionArea/Teleporter/AnimationPlayer.play("spawn")
		await $Teleporter/DetectionArea/Teleporter/AnimationPlayer.animation_finished
		$Teleporter/DetectionArea/Teleporter/AnimationPlayer.play("idle")
		$Teleporter.monitoring = true
		$Teleporter/DetectionArea.monitoring = true
		Global.boss_defeated = false
		$Teleporter/Particles.rotation += 10 * delta


#################################################
#Spawne Laser in Level


#Larry
func _on_larry_character_laser(positions):
	var laser = laser_scene.instantiate()
	laser.position = positions
	add_child(laser, true)


#Enemy Laser
func _on_enemie_2_laser_2(positions_enemies):
	var laser = laser_scene_enemy.instantiate()
	laser.position = positions_enemies
	add_child(laser,true)


#Boss
func _on_boss_laser_boss(boss_laser_positions):
	var laser = laser_scene_enemy.instantiate()
	laser.position = boss_laser_positions
	add_child(laser,true)


#################################################


#Health Decrease Area Bottom
func _on_bottom_area_body_entered(body):
	if Global.can_get_hit == true:
		if Global.health > 0:
			Global.health -= 20
	body.queue_free()


#Enemy Spawn in Level
func _spawn_enemy_at_position(body):
	if Global.killcount < 100:
		if body != null:
			if body.is_in_group("Enemy_1"):
				var enemy1 = enemy_1.instantiate()
				var enemy_position = Vector2(randi_range(45, 620), randi_range(-100, -800))
				enemy1.position = enemy_position
				add_child(enemy1)
				print("Enemy Type 1 Spawned")
				
			if body.is_in_group("Enemy_2"):
				var enemy2 = enemy_2.instantiate()
				var enemy_position = Vector2(randi_range(45, 620), randi_range(-100, -800))
				enemy2.position = enemy_position
				add_child(enemy2)
				print("Enemy Type 2 Spawned")
				if !body.is_connected("laser2", _on_enemie_2_laser_2):
					body.connect("laser2", _on_enemie_2_laser_2)
					
			if body.is_in_group("Asteroids"):
				var asteroid1 = asteroid.instantiate()
				var asteroid_position = Vector2(randi_range(45, 620), randi_range(-100, -800))
				asteroid1.position = asteroid_position
				add_child(asteroid1)
				print("Asteroid Spanwned")
				
	#Boss Spawn
	if Global.killcount >= 100 and boss_spawned == false:
		var boss_1 = boss.instantiate()
		var boss_position = Vector2(352, -500)
		boss_1.position = boss_position
		add_child(boss_1)
		print("Boss Spawned")
		boss_1.connect('last_phase',_on_boss_last_phase)
		boss_1.connect('laser_boss', _on_boss_laser_boss)
		boss_spawned = true
		
	#Boss last Phase


#Last Boss Phase
func _on_boss_last_phase():
	for a in range(4):
		
		var enemy2 = enemy_2.instantiate()
		var enemy_position = Vector2(randi_range(50, 650), randi_range(-35, -110))
		enemy2.position = enemy_position
		add_child(enemy2)
		enemy2.connect("laser2", _on_enemie_2_laser_2)


#Power Up Spawn
func _spawn_powerup(_body):
	var powerup = power_up.instantiate()
	powerup.position = Vector2(randi_range(20, 670), 35)
	add_child(powerup)
#


	#call function spawn enemy at position and wait until spawned + every 15 enemies 1 more 


#Enemy Spawn Area
func _on_spawn_area_body_exited(body):
	call_deferred("_spawn_enemy_at_position", body)
	enemy_spawn_counter += 1
	enemy_counter += 1
	if enemy_spawn_counter == 15:
		enemy_spawn_counter = 0
		call_deferred("_spawn_enemy_at_position", body)
		print("Enemy Spawned")


#Laser Despawner
func _on_spawn_area_area_entered(area):
	if area.name == "laser_2":
		area.queue_free()


#Teleporter Entered
func _on_teleporter_body_entered(body):
	if body.name == "LarryCharacter":
		TransitionScreen.change_scene("res://scenes/levels/title_screen.tscn")
		Global.highscore_update()


func _process(delta):
	scrollspeed()
	powerup_spawner()
	teleporter(delta)



