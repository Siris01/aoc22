function get_neighbors(x, y, dist)
    local result = {}
    result[1] = {x = x, y = y + 1 + dist}
    result[2] = {x = x, y = y - 1 - dist}

    local c = 0
    for j = y - dist, y do
        c = c + 1
        result[#result + 1] = {x = x + c, y = j}
        result[#result + 1] = {x = x - c, y = j}
    end
    for j = y + 1, y + dist do
        c = c - 1
        result[#result + 1] = {x = x + c, y = j}
        result[#result + 1] = {x = x - c, y = j}
    end
    
    return result
end

function is_covered(x, y)
    for _,s in pairs(sensors) do
        if math.abs(s.x - x) + math.abs(s.y - y) <= s.dist then
            return true
        end
    end
    return false
end

function get_beacon()    
    for _,sensor in pairs(sensors) do
        local neighbors = get_neighbors(sensor.x, sensor.y, sensor.dist)

        for _,n in pairs(neighbors) do
            local is_within = bounds.minx <= n.x and n.x <= bounds.maxx and bounds.miny <= n.y and n.y <= bounds.maxy
            
            if is_within and not is_covered(n.x, n.y) then
                return {x = n.x, y = n.y}
            end
        end
    end

    return sol
end

lines = io.open("input.txt", "r"):lines()
sensors = {}
ans = 0
bounds = {minx = 999999999, maxx = 0, miny = 999999999, maxy = 0}

for line in lines do
    local matches = line:gmatch("%-?%d+")
    local sx, sy, bx, by = tonumber(matches()), tonumber(matches()), tonumber(matches()), tonumber(matches())
    local dist = math.abs(sx - bx) + math.abs(sy - by)

    if sx < bounds.minx then bounds.minx = sx end
    if sx > bounds.maxx then bounds.maxx = sx end
    if sy < bounds.miny then bounds.miny = sy end
    if sy > bounds.maxy then bounds.maxy = sy end

    sensors[#sensors + 1] = {x = sx, y = sy, dist = dist}
end

beacon = get_beacon()
ans = beacon.x * 4000000 + beacon.y
print(ans)