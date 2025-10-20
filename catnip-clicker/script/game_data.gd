extends Node
signal catnip_changed(new_value)
signal lifetime_changed(new_value)
signal pics_changed(new_value)
signal money_changed(new_value)
signal clickpower_changed(new_value)
signal dps_changed(new_value)

@export var _clickpower: int = 1
@export var _catnip: int = 100
@export var _money: int = -50
@export var _dps: int = 0
@export var _pics: int = 0
@export var _lifetime_earnings: int # do this so catnip = value doesn't trigger loop endlessly

@export var farm_amount = 0
@export var farm_dps = 2
@export var farm_upgrade_cost = 150
@export var clickpower_amount = 0
@export var clickpower_dps = 1
@export var clickpower_upgrade_cost = 50
var catnip_old_amount = 0
#---------------------definitons----------------
var catnip = 0:# get is not really needed unless you need to change the logic while accessing it.
	get:
		return _catnip
	set(value):
		_catnip = value # wait set doesn't automatically change the value??
		catnip_old_amount = value
		catnip_changed.emit(value)#set is void. don't return value

var clickpower = 1:
	get:
		return _clickpower # now you have to use underscore bc the other is just container
	set(value):#when value is changed
		_clickpower = value
		clickpower_changed.emit(value)
		
var dps = 0:
	get:
		return farm_dps * farm_amount
	set(value):
		dps_changed.emit(value)

	
var lifetime_earnings = 99:
	get: 
		return _lifetime_earnings
	set(value):
		_lifetime_earnings = value
		lifetime_changed.emit(value)



var pics=0:
	get: return _pics
	set(value):
		_pics = value
		pics_changed.emit(value)

var money = -50:
	get: 
		return _money
	set(value):
		_money = value
		money_changed.emit(money)

#--------FUNCTIONS---------

func add_catnip(amount):
	catnip += amount 
	lifetime_earnings += amount
