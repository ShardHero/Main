extends Label

var hp = 100
var coins = 0

func update_label(): #update label with current state of variables
	text = "Health: " + str(hp) + " | Coins: " + str(coins)

func set_hp(value):
	hp = value
	update_label()

func set_coins(value):
	coins = value
	update_label()
