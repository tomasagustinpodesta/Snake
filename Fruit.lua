--[[
    Fruit of the snake game
]]
Class = require 'class'
Fruit = Class{}

function Fruit:init(x, y)

    self.x = math.random(30,400)
    self.y = math.random(40,200) 
    
    self.width = 10
    self.height = 10

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
