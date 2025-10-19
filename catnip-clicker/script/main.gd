extends Node2D
@onready var catnip_label: RichTextLabel = $Control/CatnipLabel
@onready var click_button: Button = $Control/ClickButton
@onready var upgrade_1: Button = $Control/Upgrade1
@onready var timer: Timer = $Control/Timer
@onready var arm_upgrade: Button = $Control/ArmUpgrade
@onready var clickpower_label: RichTextLabel = $Control/ClickpowerLabel
@onready var dps_label: RichTextLabel = $Control/DPSLabel


var catnip = 50
var clickpower = 1
var upgrade1_cost = 100
var arm_upgrade_cost = 50
var dps = 0
var lifetime_earnings = 0
func _process(delta: float) -> void:
	catnip_label.text = "Catnip: " + str(catnip)


func _on_click_button_pressed() -> void:
	catnip += clickpower


func add_catnip(amount):
	catnip += amount
	lifetime_earnings += amount
	

func _on_timer_timeout() -> void:
	add_catnip(dps)


func _on_arm_upgrade_pressed() -> void:
	if catnip > arm_upgrade_cost:
		catnip -= arm_upgrade_cost
		arm_upgrade_cost *= 1.1
		clickpower += 1
		clickpower_label.text = "Clickpower: "+str(clickpower)
		arm_upgrade.text = "Upgrade arm" + str(arm_upgrade_cost)


func _on_upgrade_1_pressed() -> void:
	if catnip > upgrade1_cost:
		catnip -= upgrade1_cost
		upgrade1_cost *= 1.1
		dps += 1
		dps_label.text = "Dps: "+str(dps)
		upgrade_1.text = "Upgrade 1 cost: " + str(upgrade1_cost)
