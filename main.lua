--[[
    Trying my first game, i plan to do snake on love 2d
]]

--Class for factorizing code
require 'Factorization'

--Fruit that the snake eats 
require 'Fruit'

--Snake 
require 'Snake'

--In order to render I use this lib
push = require 'push'

--Lib for making classes
Class = require 'class'

--Place where we are going to play
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

--Snake speed, I might change it later to change difficulty
SNAKE_SPEED = 100


-- Here we make: filter, title, sound, fonts, virtual res
function love.load()
    -- Set default filter
    love.graphics.setDefaultFilter('nearest', 'nearest')

    --For the math.random function, its seems to work without it
    math.randomseed(os.time())

    -- Title of the game
    love.window.setTitle('Snake')

    --Fonts of different sizes
    smallFont = love.graphics.newFont('font.ttf', 8)
    largeFont = love.graphics.newFont('font.ttf', 16)
    scoreFont = love.graphics.newFont('font.ttf', 32)

    --Sound section

    --Initializing the virtual resolition
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true,
        canvas = false
    })

    --Initializing variables
    --Snake score
    snake_score = 0 

    --Snake object
    snake = Snake()

    --Fruit object
    fruit = Fruit()

    --Factorization object for saving code whenever I can
    fact = Factorization()

    --Direction of the snake
    direction = 'right'

    --Tail table for the snake, I might make an object to make it better
    tail = {}

    --I use this to avoid making the snake collides with its neck
    time_delay = 15

    --Flag to make you lose
    flag = false
end

--[[function love.resize(w, h)
    push:resize(w, h)
end]]


function love.keypressed(key)

    -- the function LÖVE2D uses to quit the application
    if key == 'escape' then
        love.event.quit()
    end

    --Set all the movements
    -- right movement
    if love.keyboard.isDown('d') then
        if fact:checkDirection('right', snake.direction) then
            snake.direction = 'right' 
        end
    end
    -- left movement
    if love.keyboard.isDown('a') then
        if fact:checkDirection('left', snake.direction) then
            snake.direction = 'left' 
        end
    end
    -- up movement
    if love.keyboard.isDown('w') then
        if fact:checkDirection('up', snake.direction) then
            snake.direction = 'up' 
        end
    end
    -- down movement
    if love.keyboard.isDown('s') then
        if fact:checkDirection('down', snake.direction) then
            snake.direction = 'down' 
        end
    end
    
end

function love.update(dt)
    if not(flag) then
        --Saving the last place of the snake to make the tail
        oldPosX = snake.x
        oldPosY = snake.y

        --If the snake eats a fruit
        if snake:eats(fruit) then
            for i = 1, time_delay, 1 do
                table.insert(tail, {0, 0})
            end
            fruit:init()
            snake_score = snake_score + 1
        end
    
        --Updates for the objects
        fruit:update(dt)
        snake:update(dt)

        --Assing to every part of the tail the coordinates of their prevous link in the chain to make follow it
        for k, v in ipairs(tail) do
            local x, y = v[1], v[2]
            v[1], v[2] = oldPosX, oldPosY
            oldPosX, oldPosY = x, y 
        end

        --Check if the snake collides with itself
        --Note: I avoid the first two links of the snake in order to avoid the snake collides with its neck
        for k, v in ipairs(tail) do
            if k > 30 then
                if fact:collides(v[1],v[2], snake.x, snake.y) then
                    flag = true
                    errorPlace = k
                end
            end
        end
    end
end


function displayScore()
    -- score display
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(snake_score), VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 6)
end

--All the visuals
function love.draw()
    --Using the push lib
    push:start()

        --Background
        love.graphics.clear(40/255, 45/255, 52/255, 255/255)
        
        --Draw fruits
        if fruit.exists == true then
            fruit:render()
        end

        --score
        displayScore()

        --Lose indicator in case the snake collides
        if flag == true then 
            love.graphics.print('You Lose', VIRTUAL_WIDTH / 3, VIRTUAL_HEIGHT / 3)
        else
            snake:render()

            for k, v in ipairs(tail) do
                love.graphics.rectangle('fill', v[1], v[2], 10, 10)
            end
        end

    push:finish()
end


