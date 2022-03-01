local o = require "mining_program/isOre"

function inspectSurr(up, fillIn)
	turtle.select(2)
	surr = {}
	if o.isOreUp() then table.insert(surr, "up") else if up and fillIn then turtle.placeUp() end end
	if o.isOreDown() then table.insert(surr, "down") else if not up and fillIn then turtle.placeDown() end end
	if o.isOre() then table.insert(surr, "forward") end
	turtle.turnLeft()
	if o.isOre() then table.insert(surr, "left") else if fillIn then turtle.place() end end
	turtle.turnRight()
	turtle.turnRight()
	if o.isOre() then table.insert(surr, "right") else if fillIn then turtle.place() end end
	turtle.turnLeft()
	turtle.select(1)
	return surr
end    

function digOre()

	turtle.dig()
	turtle.forward()
	goOre(false, false)
	turtle.back()

end

function goOre(up, fillIn)
	local directions = inspectSurr(up, fillIn)
	for key, value in ipairs(directions)
	do
		if value == "forward" then digOre() end
		if value == "left" then turtle.turnLeft() digOre() turtle.turnRight() end
		if value == "right" then turtle.turnRight() digOre() turtle.turnLeft() end
		if value == "down" then turtle.digDown() turtle.down() goOre(false, false) turtle.up() end
		if value == "up" then turtle.digUp() turtle.up() goOre(false, false) turtle.down() end
		if value == "back" then turtle.turnRight() turtle.turnRight() digOre() turtle.turnRight() turtle.turnRight() end
	end

end

totalDistance = 0

fuel = turtle.getFuelLevel()

function stripMine(distance)
	while (fuel - totalDistance) > 70 and totalDistance < distance
		do

			turtle.placeDown()

			print("Distance", totalDistance)
			print("Fuel", fuel)

			local max

			if (distance - totalDistance) < 25 then max = (distance - totalDistance) else max = 25 end

			for i=0, max, 1
			do
				turtle.dig()
				turtle.forward()
				if i % 2 == 0 then
					turtle.digDown()
					goOre(true, true)
					turtle.down()
					goOre(false, true)
				else
					turtle.digUp()
					goOre(false, true)
					turtle.up()
					goOre(true, true)
				end
			end

			totalDistance = totalDistance + 25

			fuel = turtle.getFuelLevel()
		end

	turtle.placeDown()

	for i = 1,totalDistance,1
	do
		turtle.back()
	end
	turtle.select(2)
	turtle.place()
	turtle.select(1)
end




return {stripMine = stripMine}
