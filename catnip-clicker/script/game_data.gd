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
@export var _farm_dps: int = 0
@export var _pics: int = 0
@export var _lifetime_earnings: int = 99 # do this so catnip = value doesn't trigger loop endlessly

var _farm_amount = 0
#---------------------definitons----------------
var catnip = 0:# get is not really needed unless you need to change the logic while accessing it.
	get:
		return _catnip
	set(value):
		_catnip = value # wait set doesn't automatically change the value??
		lifetime_earnings += value
		catnip_changed.emit(value)#set is void. don't return value

var clickpower = 1:
	get:
		return _clickpower # now you have to use underscore bc the other is just container
	set(value):#when value is changed
		_clickpower = value
		clickpower_changed.emit(value)
		
var dps = 0:
	get:
		return _farm_dps
	set(value):
		dps_changed.emit(value)

	
var lifetime_earnings = 99:
	get: 
		return lifetime_earnings
	set(value):
		lifetime_earnings = max(0, value)
		lifetime_changed.emit(lifetime_changed)

var farm_amount = 0:
	get: 
		return _farm_amount * 2


#var pics=0:
	#get: return pics
	#set(value):
		#pics = max(0, value)
		#pics_changed.emit(pics)
#
#var money = -50:
	#get: 
		#return money
	#set(value):
		#money_changed.emit(money)

#--------FUNCTIONS---------

func add_catnip(amount):
	catnip += amount # catnip change autoadd lifetime earnings
