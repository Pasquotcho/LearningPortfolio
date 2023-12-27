extends Node2D


@onready var animation = $ParallaxBackground/BoomFx

var scrolling_speed = 10


#Parallax Movement
func movement(delta):
	$ParallaxBackground/ParallaxLayerShip_wreck_1/Layer.rotation += 0.05 * delta
	$ParallaxBackground/ParallaxLayerShip_wreck_2/Layer.rotation += 0.05 * delta
	$Background.scroll_offset.y += scrolling_speed * delta
	$ParallaxBackground.scroll_offset.y += delta 
	$ParallaxBackground.scroll_offset.x += delta 


#Restart Game
func _on_restart_pressed():
	TransitionScreen.change_scene("res://scenes/levels/level1.tscn")


#Back to Titlescreen
func _on_title_screen_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/title_screen.tscn")


#Animation Start
func _ready():
	animation.play("default")
	await animation.animation_finished
	#Normalize Stats
	Global.normalize_stats()
	$ParallaxBackground/BoomFx.queue_free()


func _process(delta):
	movement(delta)
