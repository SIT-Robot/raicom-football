gPlayTable.CreatePlay{  
   firstState = "GetBall",

["GetBall"] = {--r跑位的同时，k去拿球然后面向r,若检测到k拿到了球则跳转到PassBall，
	switch = function()
		if CBall2RoleDist("Kicker") < 30  then
			return "PassBall"
		end
	end,
	Receiver = task.GoRecePos("Receiver"),
	Kicker = task.GetBall("Kicker","Receiver"),
	


},

["PassBall"] = {--k进行传球，若检测到k踢了球就跳转到SecondPassBall
	switch = function()
		if CIsBallKick("Kicker") then
			return "SecondPassBall"
		end
	end,

	Kicker = task.PassBall("Kicker","Receiver"),

},

["SecondPassBall"] = {--k传完之后去跑位，r去拿球然后再传给r，若检测到r踢了球就跳转到Shoot
	switch = function()
		if CIsBallKick("Receiver") then
			return "Shoot"
		end
	end,
	Kicker = task.GoRecePos("Kicker"),
	Receiver = task.GetBall("Receiver","Kicker"),
	Receiver = task.PassBall("Receiver","Kicker"),
},

["Shoot"] = {--k去拿球然后射门，若检测到k踢了球就结束
	switch = function()
		if CIsBallKick("Kicker") then
			return "finish"
		end
	end,
	Kicker = task.GetBall("Kicker","Receiver"),
	Kicker = task.Shoot("Kicker"),

},

  
name = "Ref_f_m2"  
}