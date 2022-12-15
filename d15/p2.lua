function get_neighbors(x, y, dist)
    local result = {}
    result[1] = {x = x, y = y + 1 + dist}
    result[2] = {x = x, y = y - 1 - dist}

    local c = 0
    for j=y-dist, y do
        c = c + 1
        result[#result + 1] = {x = x + c, y = j}
        result[#result + 1] = {x = x - c, y = j}
    end
    for j=y+1, y+dist do
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
    local sol = {x = 0, y = 0, d = 999999999}
    
    for _,sensor in pairs(sensors) do
        local neighbors = get_neighbors(sensor.x, sensor.y, sensor.dist)

        for _,n in pairs(neighbors) do
            if not is_covered(n.x, n.y) then
                local d = math.abs(n.x - geo_center.x) + math.abs(n.y - geo_center.y)
                if d < sol.d then
                    sol = {x = n.x, y = n.y, d = d}
                end
            end
        end
    end

    return sol
end

lines = io.open("input.txt", "r"):lines()
sensors = {}
ans = 0
geo_center = {x = 0, y = 0, c = 0}

for line in lines do
    local matches = line:gmatch("%-?%d+")
    local sx, sy, bx, by = tonumber(matches()), tonumber(matches()), tonumber(matches()), tonumber(matches())
    local dist = math.abs(sx - bx) + math.abs(sy - by)

    geo_center.x = geo_center.x + sx
    geo_center.y = geo_center.y + sy
    geo_center.c = geo_center.c + 1

    local sensor = {x = sx, y = sy, dist = dist}
    sensors[#sensors + 1] = sensor
end

geo_center.x = geo_center.x / geo_center.c
geo_center.y = geo_center.y / geo_center.c

beacon = get_beacon()
ans = beacon.x * 4000000 + beacon.y
print(ans)