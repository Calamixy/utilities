-- Unsure why one would ever need this on Roblox
-- by calamixy, 3/31/2024

local left = 0x000000FF
local left_m = 0x0000FF00
local right = 0xFF000000
local right_m = 0x00FF0000

local function swap(number: number): number
	local result: number = nil
	
	local left_byte = bit32.rshift(bit32.band(number, left), 0)
	local left_m_byte = bit32.rshift(bit32.band(number, left_m), 8)
	local right_byte = bit32.rshift(bit32.band(number, right), 24)
	local right_m_byte = bit32.rshift(bit32.band(number, right_m), 16)
	
	left_byte = bit32.lshift(left_byte, 24)
	left_m_byte = bit32.lshift(left_m_byte, 16)
	right_byte = bit32.lshift(right_byte, 0)
	right_m_byte = bit32.lshift(right_m_byte, 8)
	
	result = bit32.bor(left_byte, left_m_byte, right_m_byte, right_byte)
	
	return result
end
