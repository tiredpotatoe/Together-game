extends Node


var points = 0 #starting score
var lives = 1

func decrease_health() :
	lives -=1
	if (lives == 0) :
		get_tree().reload_current_scene()

func add_point():
	points +=1
	print(points)
