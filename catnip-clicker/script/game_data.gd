extends Node
signal catnip_changed(new_value)
signal lifetime_changed(new_value)
signal pics_changed(new_value)
signal money_changed(new_value)
signal clickpower_changed(new_value)
signal dps_changed(new_value)

var clickpower = 1:
	get:#get(value):#when value accessed
		return clickpower
	set(value):#when value is changed
		clickpower_changed.emit(clickpower)
		
var dps = 0:
	get:
		return dps
	set(value):
		dps_changed.emit(dps)

var catnip := 0:
	get:
		return catnip
	set(value):
		catnip_changed.emit(catnip)
		lifetime_earnings += value
	
var lifetime_earnings = 99:
	get: 
		return lifetime_earnings
	set(value):
		lifetime_earnings = max(0, value)
		lifetime_changed.emit(lifetime_changed)


func add_catnip(amount):
	catnip += amount

var pics=0:
	get: return pics
	set(value):
		pics = max(0, value)
		pics_changed.emit(pics)

var money = -50:
	get: 
		return money
	set(value):
		money_changed.emit(money)
