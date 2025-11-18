extends Node2D
@onready var control: Control = $Control
@onready var ui_right: Node2D = $Control/UIRight
@onready var status_label: RichTextLabel = $Control/UIRight/StatusLabel
@onready var money_label: RichTextLabel = $Control/UIRight/MoneyLabel
@onready var pics_label: RichTextLabel = $Control/UIRight/PicsLabel
@onready var catnip_label: RichTextLabel = $Control/CatnipLabel
@onready var dps_label: RichTextLabel = $Control/DPSLabel
@onready var clickpower_label: RichTextLabel = $Control/ClickpowerLabel
@onready var click_button: Button = $Control/ClickButton
@onready var worker_upgrade: Button = $Control/WorkerUpgrade
@onready var worker_amount: Label = $Control/WorkerUpgrade/WorkerAmount
@onready var pawparazzi_upgrade: Button = $Control/PawparazziUpgrade
@onready var pawparazzi_amount: Label = $Control/PawparazziUpgrade/PawparazziAmount
@onready var catnip_farm_upgrade: Button = $Control/CatnipFarmUpgrade
@onready var farm_amount_label: Label = $Control/CatnipFarmUpgrade/FarmAmountLabel
@onready var ultimate_upgrade: Button = $Control/UltimateUpgrade
@onready var sell_button: Button = $Control/SellButton
@onready var clickpower_upgrade: Button = $Control/ClickpowerUpgrade
@onready var clickpower_amount_label: Label = $Control/ClickpowerUpgrade/ClickpowerAmountLabel
@onready var tick: Timer = $Control/Tick
@onready var upgrade_1: Button = $Control/Upgrade1


func _ready() -> void:
	#print_tree_pretty()

	GameData.catnip_changed.connect(on_catnip_changed)
	GameData.pics_changed.connect(on_pics_changed)
	GameData.money_changed.connect(on_money_changed)
	GameData.clickpower_changed.connect(on_clickpower_changed)
	GameData.dps_changed.connect(on_dps_changed)

#--------------SIGNALS------------------\
func on_catnip_changed(new_value):
	if catnip_label:#if it exists... bypasses the problem
		catnip_label.text = "Catnip: " + str(roundf(new_value))
	
func on_clickpower_changed(new_value):
	if clickpower_label:
		clickpower_label.text = "Clickpower: "+str(new_value)
	
func on_money_changed(amount):
	if money_label:
		money_label.text = "Money: " + str(roundf(amount))
	
func on_pics_changed(pics):
	if pics_label:
		pics_label.text = "Pics: " + str(roundf(pics))
	
func on_dps_changed(amount):
	if dps_label:
		dps_label.text = "Dps: "+str(GameData.dps)

#----------------others------------------
func _on_tick_timeout() -> void:
	GameData.add_catnip(GameData.dps)#why does this break inside gamedata???
	if GameData.pawparazzi_amount > 0:
		GameData.pics += GameData.pawparazzi_amount
	if GameData.pics > GameData.worker_amount:
		GameData.pics -= GameData.worker_amount
		GameData.money += GameData.worker_amount
	#print("Pawparazzi:", GameData.pawparazzi_amount, "Pics:", GameData.pics, "Money:", GameData.money)

	if GameData.catnip < 1000000:
		if is_instance_valid(ultimate_upgrade):
			ultimate_upgrade.text = "To be unlocked..."
	else:
		ultimate_upgrade.text = "ULTIMATE UPGRADE: DRAG YOUR CATNIP STACK AROUND: 1 BILLION CATNIP"
	

func _on_click_button_pressed() -> void:
	GameData.add_catnip(GameData.clickpower)

func _on_clickpower_upgrade_pressed() -> void:
	if GameData.catnip >= GameData.clickpower_upgrade_cost:
		GameData.catnip -= GameData.clickpower_upgrade_cost
		GameData.clickpower += 1
		GameData.clickpower_amount += 1
		GameData.clickpower_upgrade_cost *= 1.2
		
		clickpower_upgrade.text = "Upgrade clickpower " + str(roundf(GameData.clickpower_upgrade_cost))
		clickpower_amount_label.text = "Owned: " + str(GameData.clickpower_amount)
		
func _on_catnip_farm_upgrade_pressed() -> void:
	if GameData.catnip >= GameData.farm_upgrade_cost:
		GameData.catnip -= GameData.farm_upgrade_cost
		GameData.farm_upgrade_cost *= 1.2
		GameData.farm_amount += 1
		GameData.dps += 2 # change dps after adding amount
		catnip_farm_upgrade.text = "Farm cost: " + str(roundf(GameData.farm_upgrade_cost))
		farm_amount_label.text = "Owned: " + str(GameData.farm_amount)

	
func _on_ultimate_upgrade_pressed() -> void:
	pass # Replace with function body.

#----------------right side ----------------#
func _on_sell_button_pressed() -> void:
	if GameData.pics >= GameData.clickpower:
		GameData.pics -= GameData.clickpower
		GameData.money += GameData.clickpower



func _on_worker_upgrade_pressed() -> void:
	if GameData.money >= GameData.worker_upgrade_cost:
		GameData.money -= GameData.worker_upgrade_cost
		GameData.worker_amount += 1
		GameData.worker_upgrade_cost *= 1.2
		
		worker_upgrade.text = "Hire worker " + str(roundf(GameData.worker_upgrade_cost))
		worker_amount.text = "Owned: " + str(GameData.worker_amount)
	

func _on_pawparazzi_upgrade_pressed() -> void:
	if GameData.money >= GameData.pawparazzi_upgrade_cost:
		print("Money before:", GameData.money)
		GameData.money -= GameData.pawparazzi_upgrade_cost
		print("Money after:", GameData.money)

		GameData.pawparazzi_amount += 1
		GameData.pawparazzi_upgrade_cost = ceil(GameData.pawparazzi_upgrade_cost * 1.2)
		
		pawparazzi_upgrade.text = "Hire pawparazzi " + str(roundf(GameData.pawparazzi_upgrade_cost))
		pawparazzi_amount.text = "Owned: " + str(GameData.pawparazzi_amount)
