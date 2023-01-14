extends Area2D

var collected = false

func _on_coin_body_entered(body):
	Global.addCoins()
	collected = true
	$Sprite.visible = false
	self.collision_mask = 0
