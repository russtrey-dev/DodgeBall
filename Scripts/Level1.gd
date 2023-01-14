extends Node2D

const COIN = preload("res://Items/coin.tscn")
const MIN_SPAWN_DELAY = 2
const MAX_SPAWN_DELAY = 5
const MAX_SPAWNED_COINS = 5.0
const START_COINS = 3
const SPAWN_DISTANCE = 150
var spawnedCoins = []
var timeSinceSpawn = 0.0
var startTime = 0.0
var maxSpawned = false
var nextSpawn
var rng

func _ready():
	rng = RandomNumberGenerator.new()
	nextSpawn = MAX_SPAWN_DELAY
	createCoins(START_COINS)
	startTime = OS.get_unix_time()
	Global.coins = 0
	
func _process(delta):
	if !maxSpawned:
		timeSinceSpawn += delta
	checkCollected()
	spawnCoins()
	Global.setBallSpeed(floor((OS.get_unix_time() - startTime) / 60))
	
func checkCollected():
	for coin in spawnedCoins:
		if coin.collected:
			spawnedCoins.erase(coin)
			coin.queue_free()
	if spawnedCoins.size() < MAX_SPAWNED_COINS:
		maxSpawned = false

func spawnCoins():
	if timeSinceSpawn > nextSpawn:
		if spawnedCoins.size() < MAX_SPAWNED_COINS:
			createCoins(rng.randi_range(0,2))
			timeSinceSpawn = 0.0
			if spawnedCoins.size() >= MAX_SPAWNED_COINS:
				 maxSpawned = true
			nextSpawn = rng.randf_range(MIN_SPAWN_DELAY, MAX_SPAWN_DELAY)

func getSpawnPosition():
	var potentialSpawn = Vector2(rng.randi_range(100, 800), rng.randi_range(100, 400))
	while potentialSpawn.distance_to(get_node("player").position) < SPAWN_DISTANCE:
		potentialSpawn = Vector2(rng.randi_range(100, 800), rng.randi_range(100, 400))
	return potentialSpawn
	
func createCoins(numberToSpawn):
	for i in numberToSpawn:
		spawnedCoins.append(COIN.instance())
		get_node("coins").add_child(spawnedCoins.back())
		spawnedCoins.back().position = getSpawnPosition()

func getTimeSurvived():
	var secondsSurvived = OS.get_unix_time() - startTime
	var minutesSurvived = floor(secondsSurvived / 60)
	secondsSurvived = secondsSurvived % 60
	Global.timeSurvived = str(minutesSurvived) + ":" + str(secondsSurvived)

func _on_ball_hit_player():
	getTimeSurvived()
	get_tree().change_scene("res://Scenes/YouWin.tscn")	
