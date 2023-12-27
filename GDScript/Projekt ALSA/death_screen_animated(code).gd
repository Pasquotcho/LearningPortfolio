extends Node2D

@onready var animation = $BoomFx

var scrolling_speed = 10
var direction = Vector2(-1, 0)
var speed = 10


#Animation Skript 


func _process(delta):
	$Background.scroll_offset.y += scrolling_speed * delta
	$ParallaxBackground.scroll_offset.x += delta * -1000


func _on_laser_body_entered(_body):
	queue_free()


func _on_explosion_timer_timeout():
	animation.play("default")
	await animation.animation_finished
	$BoomFx.queue_free()
	get_tree().change_scene_to_file("res://scenes/levels/death_screen.tscn")
