extends Node2D
@onready var click_button: Button = $Control/ClickButton
@onready var catnip_label: RichTextLabel = $"Control/CatnipLabel"
@onready var dps_label: RichTextLabel = $Control/DPSLabel
@onready var living_situation: RichTextLabel = $Control/LivingSituation
@onready var status_label: RichTextLabel = $Control/StatusLabel
@onready var money_label: RichTextLabel = $Control/MoneyLabel
@onready var pics_label: RichTextLabel = $Control/PicsLabel
@onready var clickpower_label: RichTextLabel = $Control/ClickpowerLabel
@onready var upgrade_1: Button = $Control/Upgrade1
@onready var ultimate_upgrade: Button = $Control/UltimateUpgrade
@onready var sell: Button = $Control/Sell
@onready var arm_upgrade: Button = $Control/ArmUpgrade
@onready var catnip_farm: Button = $Control/CatnipFarm


#upgrades
var mouse_upgrade_cost = 50
var mouse_level = 0
var upgrade1_cost = 100
var upgrade1_level =0
var farm_cost = 150
var farm_level = 0
#gamedata variables
var catnip: #saves me typing gamedata
	get: return GameData.catnip
	set(value): GameData.catnip = value
var clickpower:
	get: return GameData.clickpower
	set(value): GameData.clickpower = value
var money:
	get: return GameData.money
	set(value): GameData.money = value

func _ready() -> void:
	print_tree_pretty()

	GameData.catnip_changed.connect(on_catnip_changed)
	#GameData.lifetime_changed.connect(on_lifetime_changed)
	GameData.pics_changed.connect(on_pics_changed)
	GameData.money_changed.connect(on_money_changed)
	GameData.clickpower_changed.connect(on_clickpower_changed)
	#GameData.dps_changed.connect(on_dps_changed)


func on_catnip_changed(new_value):
	if catnip_label:
		catnip_label.text = "Catnip: " + str(new_value)
		
func _on_click_button_pressed() -> void:
	GameData.add_catnip(GameData.clickpower)


func _on_timer_timeout() -> void:
	GameData.add_catnip(GameData.dps)

	if catnip < 1000000 and catnip:
		if is_instance_valid(ultimate_upgrade):
			ultimate_upgrade.text = "To be unlocked..."
	else:
		ultimate_upgrade.text = "ULTIMATE UPGRADE: DRAG YOUR CATNIP STACK AROUND: 1 BILLION CATNIP"
	


func _on_arm_upgrade_pressed() -> void:
	if catnip >= mouse_upgrade_cost:
		catnip -= mouse_upgrade_cost
		mouse_upgrade_cost *= 1.2
		clickpower += 1
		mouse_level += 1
		
		arm_upgrade.text = "Upgrade arm " + str(roundf(mouse_upgrade_cost))
		
func on_clickpower_changed(clickpower):
	clickpower_label.text = "Clickpower: "+str(clickpower)

func _on_upgrade_1_pressed() -> void:
	if money >= upgrade1_cost:
		money -= upgrade1_cost
		upgrade1_cost *= 1.2
		GameData.dps += 1
		upgrade1_level += 1
		dps_label.text = "Dps: "+str(GameData.dps)
		upgrade_1.text = "Upgrade 1 cost: " + str(roundf(upgrade1_cost))
func on_money_changed(amount):
	money_label.text = "Money: " + str(roundf(amount))

func _on_sell_pressed() -> void:
	if GameData.pics >= GameData.clickpower:
		GameData.pics -= GameData.clickpower
		money += GameData.clickpower
		pics_label.text = "Pics: " + str(roundf(GameData.pics))
		
func on_pics_changed(pics):
	pics_label.text = "Pics: " + str(roundf(pics))


func _on_catnip_farm_pressed() -> void:
	if catnip >= farm_cost:
		catnip -= farm_cost
		farm_cost *= 1.3
		GameData.dps += 2
		catnip_farm.text = "Farm cost: " + str(roundf(farm_cost))
