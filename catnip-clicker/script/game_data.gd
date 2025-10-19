extends Node
signal catnip_changed(new_value)
var catnip := 100:
	set(value):#when value is changed
		catnip = clamp(value, 0, 100)
		catnip_changed.emit(catnip)
		
	#get(value):#when value accessed
		#pass
		
		



var clickpower = 1
var dps = 0
var lifetime_earnings = 99.0
var money = -50.0
signal lifetime_earnings_changed(ok)
var pics =0
