gPlayTable.CreatePlay{  
   firstState = "GetBall",

["GetBall"] = {--r跑位的同时，k去拿球然后面向r,若检测到k拿到了球则跳转到PassBall，
	switch = function()
		if CIsGetBall("Kicker")  then
			return "Shoot"
		end
	end,
	
	Kicker = task.GetBall("Kicker","Kicker"),
	


},



["Shoot"] = {--k去拿球然后射门，若检测到k踢了球就结束
	switch = function()
		if CIsBallKick("Kicker") then
			return "finish"
		end
	end,
	
	Kicker = task.Shoot("Kicker"),

},

  
name = "Ref_p"  
}