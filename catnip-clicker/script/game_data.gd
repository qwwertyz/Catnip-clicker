extends Node
signal catnip_changed(new_value)
signal lifetime_changed(new_value)
signal pics_changed(new_value)
signal money_changed(new_value)
signal clickpower_changed(new_value)
signal dps_changed(new_value)

@export var _clickpower: int = 1
@export var _catnip: int = 999
@export var _money: int = 150 #must be initialized to a constant expression or have a type specifier in the variable
@export var _dps: int = 0
@export var _pics: int = 0
@export var _lifetime_earnings: int =300# do this so catnip = value doesn't trigger loop endlessly

@export var farm_amount = 0
@export var farm_dps = 2
@export var farm_upgrade_cost = 150
@export var clickpower_amount = 0
@export var clickpower_dps = 1
@export var clickpower_upgrade_cost = 50
#---------------------definitons----------------
var catnip :# get is not really needed unless you need to change the logic while accessing it.
	get:
		return _catnip
	set(value):
		_catnip = value # wait set doesn't automatically change the value??
		catnip_changed.emit(value)#set is void. don't return value

var clickpower:
	get:
		return _clickpower # now you have to use underscore bc the other is just container
	set(value):#when value is changed
		_clickpower = value
		clickpower_changed.emit(value)
		
var dps:
	get:
		return farm_dps * farm_amount
	set(value):
		dps_changed.emit(value)

	
var lifetime_earnings:
	get: 
		return _lifetime_earnings
	set(value):
		_lifetime_earnings = value
		lifetime_changed.emit(value)



var pics:
	get: return _pics
	set(value):
		_pics = value
		pics_changed.emit(value)

var money:
	get: 
		return _money
	set(value):
		_money = value
		money_changed.emit(money)

#--------FUNCTIONS---------

func add_catnip(amount):
	catnip += amount 
	lifetime_earnings += amount
	
func _ready() -> void:
	catnip_changed.emit(catnip)
	money_changed.emit(money)
