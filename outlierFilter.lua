-- Useful for many data science and game development applications where it is necessary to filter outliers out of a data set!
-- by calamixy, 8/16/2023

local function numEvenOdd(a: number): boolean
    return a % 2 == 0
end

local function median(a: {}): number
    if numEvenOdd(#a) then
        return (a[math.floor(#a/2)] + a[math.floor(#a/2) + 1]) / 2
    else
        return a[math.ceil(#a/2)]
    end
end

local function limits(a: {})
    local lowerRange = {}
    local upperRange = {}
    local lowerM;
    local upperM;
    local iqr;

    table.sort(a)

    if math.ceil(median(a)) == median(a) then
        local center = math.ceil(#a/2)
        for i,v in a do
            if i < center then
                lowerRange[#lowerRange+1] = v
            end
            if i > center then
                upperRange[#upperRange+1] = v
            end
        end
    else
        local center1 = math.floor(#a/2)
        local center2 = center1 + 1
        for i,v in a do
            if i <= center1 then
                lowerRange[#lowerRange+1] = v
            end
            if i >= center2 then
                upperRange[#upperRange+1] = v
            end
        end
    end
    
    lowerM = median(lowerRange)
    upperM = median(upperRange)
    iqr = upperM - lowerM

    return lowerM - 1.5 * iqr, upperM + 1.5 * iqr
end

function filter(a: {}): {}
    local lower, upper = limits(a)
    local filtered = {}

    for _, v in a do
        if v >= lower and v <= upper then
            filtered[#filtered+1] = v
        end 
    end

    return filtered
end

return filter
