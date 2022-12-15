function len(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

lines = io.open("input.txt", "r"):lines()

covered = {}
beacons = {}
depth = 2000000

for line in lines do
    local matches = line:gmatch("%-?%d+")
    local sx, sy, bx, by = tonumber(matches()), tonumber(matches()), tonumber(matches()), tonumber(matches())
    local dist = math.abs(sx - bx) + math.abs(sy - by)

    if by == depth then beacons[bx] = true end
    
    local xdiff = dist - math.abs(sy - depth)
    if xdiff >= 0 then
        local x1 = sx - xdiff
        local x2 = sx + xdiff
    
        for x = math.min(x1, x2), math.max(x1, x2) do
            covered[x] = true
        end
    end
end

ans = len(covered) - len(beacons)
print(ans)