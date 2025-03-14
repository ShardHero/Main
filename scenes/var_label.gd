extends Label

func update_label(): #update label with current state of variables
	text = "Health: " + str(Global.hp) + " | Coins: " + str(Global.coins)
