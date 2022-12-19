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

function Fruit:snakeEats(snake)
    if self.x > snake.x + snake.width or snake.x > self.x + self.width then
        return false
    end
    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y > snake.y + snake.height or snake.y > self.y + self.height then
        return false
    end 
    fruit.exists = false
    return true
end


function Fruit:update(dt)
    if self.exists == false then
        fruit.exists = true
    end
end

function Fruit:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
