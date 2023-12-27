extends CanvasLayer




func _ready():
#Pause Setting
	process_mode = $".".PROCESS_MODE_WHEN_PAUSED


#Scrollspeed Progressbar and Text
func scrollspeed(delta):
	$Text.text = "Scrollspeed = " + str(Global.scrollspeed) 
	$ProgressBar.value += Global.scrollspeed * delta * 0.12
	if $ProgressBar.value == 100:
		$ProgressBar.value = 0


#Quit Pause
func quit_debug():
	$".".visible = false
	get_tree().paused = false


#Quit Pause
func _on_exit_pressed():
	quit_debug()


#Suicide
func _on_suicide_pressed():
	Global.health = -1
	quit_debug()


#Invincible
func _on_invincible_toggled(button_pressed):
	if(button_pressed):
		Global.health = INF
	else:
		Global.health = 100


#Max Speed
func _on_max_speed_toggled(button_pressed):
	if(button_pressed):
		Global.larry_speed = 1250
	else:
		Global.larry_speed = 400


#Max Laser
func _on_max_laser_toggled(button_pressed):
	if(button_pressed):
		Global.waittime = 0.01
	else:
		Global.waittime = 0.8


#Scrollspeed - 
func _on__pressed():
		Global.scrollspeed -= 10


#Scrollspeed +
func _on__button_down():
	Global.scrollspeed += 10


#Quit Game
func _on_quit_pressed():
	Global.save_score()
	get_tree().quit()


#Quit to Title
func _on_title_pressed():
	quit_debug()
	get_tree().change_scene_to_file("res://scenes/levels/title_screen.tscn")
	Global.save_score()


func _process(delta):
	scrollspeed(delta)
