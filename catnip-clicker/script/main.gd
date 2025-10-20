extends Node2D
@onready var click_button: Button = $Control/ClickButton
@onready var catnip_label: RichTextLabel = $"Control/CatnipLabel"
@onready var dps_label: RichTextLabel = $Control/DPSLabel
@onready var living_situation: RichTextLabel = $Control/LivingSituation
@onready var status_label: RichTextLabel = $Control/StatusLabel
@onready var money_label: RichTextLabel = $Control/MoneyLabel
@onready var pics_label: RichTextLabel = $Control/PicsLabel
@onready var upgrade_1: Button = $Control/Upgrade1
@onready var ultimate_upgrade: Button = $Control/UltimateUpgrade
@onready var sell: Button = $Control/Sell
@onready var catnip_farm: Button = $Control/CatnipFarm
@onready var clickpower_upgrade: Button = $Control/ClickpowerUpgrade
@onready var clickpower_amount_label: Label = $Control/ClickpowerUpgrade/ClickpowerAmountLabel
@onready var clickpower_label: RichTextLabel = $Control/ClickpowerLabel
@onready var farm_amount_label: Label = $Control/CatnipFarm/FarmAmountLabel


#upgrades, local
@export var clickpower_upgrade_cost = 50
var clickpower_amount = 0
@export var upgrade1_cost = 100
var upgrade1_amount =0
@export var farm_cost = 150

#gamedata variables


func _ready() -> void:
	print_tree_pretty()

	GameData.catnip_changed.connect(on_catnip_changed)
	#GameData.lifetime_changed.connect(on_lifetime_changed)
	GameData.pics_changed.connect(on_pics_changed)
	GameData.money_changed.connect(on_money_changed)
	GameData.clickpower_changed.connect(on_clickpower_changed)
	#GameData.dps_changed.connect(on_dps_changed)



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
	


#----------------others------------------
func _on_timer_timeout() -> void:
	GameData.add_catnip(GameData.dps)

	if GameData.catnip < 1000000:
		if is_instance_valid(ultimate_upgrade):
			ultimate_upgrade.text = "To be unlocked..."
	else:
		ultimate_upgrade.text = "ULTIMATE UPGRADE: DRAG YOUR CATNIP STACK AROUND: 1 BILLION CATNIP"
	


	
func _on_click_button_pressed() -> void:
	GameData.add_catnip(GameData.clickpower)

func _on_clickpower_upgrade_pressed() -> void:
	if GameData.catnip >= clickpower_upgrade_cost:
		GameData.catnip -= clickpower_upgrade_cost
		GameData.clickpower += 1
		clickpower_amount += 1
		clickpower_upgrade_cost *= 1.2
		
		clickpower_upgrade.text = "Upgrade clickpower " + str(roundf(clickpower_upgrade_cost))
		clickpower_amount_label.text = "Owned: " + str(clickpower_amount)
		

func _on_upgrade_1_pressed() -> void:
	if GameData.money >= upgrade1_cost:
		GameData.money -= upgrade1_cost
		upgrade1_cost *= 1.2
		GameData.dps += 1
		upgrade1_amount += 1
		dps_label.text = "Dps: "+str(GameData.dps)
		upgrade_1.text = "Upgrade 1 cost: " + str(roundf(upgrade1_cost))

#func _on_sell_pressed() -> void:
	#if GameData.pics >= GameData.clickpower:
		#GameData.pics -= GameData.clickpower
		#money += GameData.clickpower
		#pics_label.text = "Pics: " + str(roundf(GameData.pics))
		#

#
func _on_catnip_farm_pressed() -> void:
	if GameData.catnip >= farm_cost:
		GameData.catnip -= farm_cost
		GameData.dps += 2
		farm_cost *= 1.2
		GameData.farm_amount += 1
		catnip_farm.text = "Farm cost: " + str(roundf(farm_cost))
		farm_amount_label.text = "Owned: " + str(GameData.farm_amount)
