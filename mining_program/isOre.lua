local function isOreData(data)
    if data.tags == nil then return false end
      
    if data.tags["forge:ores"] then
            return true
        end

    return false

end

function isOre()
    local success, data = turtle.inspect()
    if success then
        return isOreData(data)
    end
    
    return false    

end

function isOreUp()
    local success, data = turtle.inspectUp()
    return isOreData(data)
end

function isOreDown()
    local success, data = turtle.inspectDown()
    return isOreData(data)
end

return { has_value = has_value, isOre = isOre, isOreUp = isOreUp, isOreDown = isOreDown}
