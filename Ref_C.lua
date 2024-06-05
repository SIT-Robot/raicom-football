--desc: 
goto_x = function() 
	local x
	x = 180
	return x
end

goto_y  = function()
	local y 
	if CGetBallY() > 0 then
		y = -80
	else
		y = 80
	end
	return y
end

goto_dir = function()
	return CRole2OppGoalDir("Kicker")
end

gPlayTable.CreatePlay{
firstState = "GetBall",

["GetBall"] = {
	switch = function()
		if CBall2RoleDist("Receiver") < 30 and CIsGetBall("Receiver") then
			return "PassBall"
		end
	end,
	Kicker   = task.GotoPos("Kicker",goto_x,goto_y,goto_dir),
	Receiver = task.GetBall("Receiver","Receiver"),
	Goalie   = task.Goalie()
},

["PassBall"] = {
	switch = function()
		if CIsBallKick("Receiver") then
			return "SecondPassBall"
		end
	end,
	Kicker   = task.GotoPos("Kicker",goto_x,goto_y,goto_dir),
	Receiver = task.PassBall("Receiver","Kicker"),
	Goalie   = task.Goalie()
},



["SecondPassBall"] = {--k传完之后去跑位，r去拿球然后再传给r，若检测到r踢了球就跳转到Shoot
	switch = function()
		if CIsBallKick("Kicker") then
			return "Shoot"
		end
	end,
	Receiver = task.GoRecePos("Kicker",goto_x,goto_y,goto_dir),
	Kicker = task.GetBall("Kicker","Receiver"),
	Kicker = task.PassBall("Kicker","Receiver"),
},



["Shoot"] = {
	switch = function()
		if CIsBallKick("Kicker") then
			return "finish"
		end
	end,
	Receiver = task.GetBall("Receiver","Kicker"),
	Receiver = task.Shoot("Receiver"),
	--Receiver = task.RefDef("Receiver"),
	
},

name = "Ref_CornerKick"
}