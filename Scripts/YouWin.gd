extends Control

func _ready():
	get_node("CoinsCollected").text = str(Global.coins)
	get_node("TimeSurvived").text = Global.timeSurvived

func _on_Timer_timeout():
	get_tree().change_scene("res://Scenes/StartScreen.tscn")
