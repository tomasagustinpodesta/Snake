--[[
    Making the class Snake
]]

Class = require 'class'
require 'Factorization'
Snake = Class{}
snake_body = {}

fact = Factorization()
function Snake:init()
    --head and body size 
    self.x = 50
    self.y = 50
    self.width = 10
    self.height = 10

    -- direction, and movement of the snake
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

--movements and borders functionalities
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

    --movement updates
    self.x = self.x + self.movementX * dt
    self.y = self.y + self.movementY * dt

    --snake borders
    if self.x < 0 then
        self.x = VIRTUAL_WIDTH
    elseif self.x > VIRTUAL_WIDTH then
        self.x = 0
    elseif self.y > VIRTUAL_HEIGHT then
        self.y = 0
    elseif self.y < 0 then
        self.y = VIRTUAL_HEIGHT
    end

end

function Snake:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

-- changing the movement depending on the direction atribute
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

--snake eating implemented, returns true if eats, false if its not
function Snake:eats(fruit)
    return fact:collides(snake.x, snake.y, fruit.x, fruit.y)
end

function Snake:add()
    table.insert(snake_body, {0, 0})
end
