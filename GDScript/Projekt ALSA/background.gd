extends ParallaxBackground



var scrolling_speed = 10


#Parallax Background Speed


func _process(delta):
	scroll_offset.y += scrolling_speed * delta

