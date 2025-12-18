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
@onready var house: Sprite2D = $House


func _ready() -> void:
	#print_tree_pretty()

	Globals.catnip_changed.connect(on_catnip_changed)
	Globals.pics_changed.connect(on_pics_changed)
	Globals.money_changed.connect(on_money_changed)
	Globals.clickpower_changed.connect(on_clickpower_changed)
	Globals.dps_changed.connect(on_dps_changed)

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
		dps_label.text = "Dps: "+str(Globals.dps)

#----------------others------------------
func _on_tick_timeout() -> void:
	
	Globals.add_catnip(Globals.dps)#why does this break inside Globals???
	if Globals.pawparazzi_amount > 0:
		Globals.pics += Globals.pawparazzi_amount
	if Globals.pics > Globals.worker_amount:
		Globals.pics -= Globals.worker_amount
		Globals.money += Globals.worker_amount
	#print("Pawparazzi:", Globals.pawparazzi_amount, "Pics:", Globals.pics, "Money:", Globals.money)

	if Globals.catnip < 1000000:
		if is_instance_valid(ultimate_upgrade):
			ultimate_upgrade.text = "To be unlocked..."
	else:
		ultimate_upgrade.text = "ULTIMATE UPGRADE: DRAG YOUR CATNIP STACK AROUND: 1 BILLION CATNIP"
	

func _on_click_button_pressed() -> void:
	Globals.add_catnip(Globals.clickpower)

func _on_clickpower_upgrade_pressed() -> void:
	if Globals.catnip >= Globals.clickpower_upgrade_cost:
		Globals.catnip -= Globals.clickpower_upgrade_cost
		Globals.clickpower += 1
		Globals.clickpower_amount += 1
		Globals.clickpower_upgrade_cost *= 1.2
		
		clickpower_upgrade.text = "Upgrade clickpower " + str(roundf(Globals.clickpower_upgrade_cost))
		clickpower_amount_label.text = "Owned: " + str(Globals.clickpower_amount)
		
func _on_catnip_farm_upgrade_pressed() -> void:
	if Globals.catnip >= Globals.farm_upgrade_cost:
		Globals.catnip -= Globals.farm_upgrade_cost
		Globals.farm_upgrade_cost *= 1.2
		Globals.farm_amount += 1
		Globals.dps += 2 # change dps after adding amount
		catnip_farm_upgrade.text = "Farm cost: " + str(roundf(Globals.farm_upgrade_cost))
		farm_amount_label.text = "Owned: " + str(Globals.farm_amount)

	
func _on_ultimate_upgrade_pressed() -> void:
	pass # Replace with function body.

#----------------right side ----------------#
func _on_sell_button_pressed() -> void:
	if Globals.pics >= Globals.clickpower:
		Globals.pics -= Globals.clickpower
		Globals.money += Globals.clickpower



func _on_worker_upgrade_pressed() -> void:
	if Globals.money >= Globals.worker_upgrade_cost:
		Globals.money -= Globals.worker_upgrade_cost
		Globals.worker_amount += 1
		Globals.worker_upgrade_cost *= 1.2
		
		worker_upgrade.text = "Hire worker " + str(roundf(Globals.worker_upgrade_cost))
		worker_amount.text = "Owned: " + str(Globals.worker_amount)
	

func _on_pawparazzi_upgrade_pressed() -> void:
	if Globals.money >= Globals.pawparazzi_upgrade_cost:
		print("Money before:", Globals.money)
		Globals.money -= Globals.pawparazzi_upgrade_cost
		print("Money after:", Globals.money)

		Globals.pawparazzi_amount += 1
		Globals.pawparazzi_upgrade_cost = ceil(Globals.pawparazzi_upgrade_cost * 1.2)
		
		pawparazzi_upgrade.text = "Hire pawparazzi " + str(roundf(Globals.pawparazzi_upgrade_cost))
		pawparazzi_amount.text = "Owned: " + str(Globals.pawparazzi_amount)


func _on_buy_house_pressed() -> void:
	if Globals.money >= 3000:
		Globals.money -= 3000
		status_label.text = "not homeless"
		house.visible = true
	elif Globals.money >= 10000:
		Globals.money -= 10000
		status_label.text = "homeowner"
	
