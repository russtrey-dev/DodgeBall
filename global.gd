extends Node

const MIN_BALL_SPEED = 250
const BALL_SPEED_INCREMENT = 100

var coins = 0
var timeSurvived = "0 : 0"
var ballSpeed = MIN_BALL_SPEED

func addCoins(amount = 1):
	coins = coins + amount

func setBallSpeed(minutes):
	ballSpeed = MIN_BALL_SPEED + (minutes * BALL_SPEED_INCREMENT) 
