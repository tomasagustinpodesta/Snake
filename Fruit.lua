--[[
    Fruit model lua 
]]
Class = require 'class'
Fruit = Class{}

function Fruit:init(x, y)
    --where is going to be
    self.x = math.random(30,400)
    self.y = math.random(40,200) 
    
    --size
    self.width = 10
    self.height = 10

    --if exists
    self.exists = false
end

function Fruit:update(dt)
    -- to keep always a fruit in the field
    if self.exists == false then
        fruit.exists = true
    end
end

function Fruit:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
