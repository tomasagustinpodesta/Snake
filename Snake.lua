--[[
    Making the class Snake
]]

Class = require 'class'
Snake = Class{}

function Snake:init()
    --head and body size 
    self.x = 50
    self.y = 50

    self.width = 10
    
    self.height = 10

    self.direction = 'right'
    self.movementX = SNAKE_SPEED
    self.movementY = 0
end

--In case we lose, it will return true or false
function Snake:collides()
    
end

--restart game
function Snake:reset()
    
end

function Snake:update(dt)
    -- right movement
    if self.direction == 'right' then
        self.movementX = SNAKE_SPEED
        self.movementY = 0
    end
    -- left movement
    if self.direction == 'left' then
        self.movementX = -SNAKE_SPEED
        self.movementY = 0
    end
    -- up movement
    if self.direction == 'up' then
        self.movementX = 0
        self.movementY = -SNAKE_SPEED
    end
    -- down movement
    if self.direction == 'down' then
        self.movementX = 0
        self.movementY = SNAKE_SPEED
    end

    self.x = self.x + self.movementX * dt
    self.y = self.y + self.movementY * dt
end

function Snake:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function Snake:whereToMove(dt)

    -- right movement
    if Snake.direction == 'right' then
        self.movementX = SNAKE_SPEED
        self.movementY = 0
    end
    -- left movement
    if self.direction == 'left' then
        self.movementX = -SNAKE_SPEED
        self.movementY = 0
    end
    -- up movement
    if self.direction == 'up' then
        self.movementX = 0
        self.movementY = -SNAKE_SPEED
    end
    -- down movement
    if self.direction == 'down' then
        self.movementX = 0
        self.movementY = SNAKE_SPEED
    end
end