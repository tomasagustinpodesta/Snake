--[[
    Trying my first game, i plan to do snake on love 2d
]]
require 'Factorization'
require 'Fruit'
require 'Snake'
push = require 'push'
Class = require 'class'

-- place where we are going to play
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

    --For the math.random function
    --math.randomseed(os.time())

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

    --snake object
    snake = Snake()

    --fruit object
    fruit = Fruit()

    --factorization object
    fact = Factorization()

    --Direction of the snake
    direction = 'right'

    tail = {}

    time_delay = 15

    flag = false
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)

    -- the function LÖVE2D uses to quit the application
    if key == 'escape' then
        love.event.quit()
    end

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
    oldPosX = snake.x
    oldPosY = snake.y
    if snake:eats(fruit) then
        for i = 1, time_delay, 1 do
            table.insert(tail, {0, 0})
        end
        fruit:init()
        snake_score = snake_score + 1
    end
    time = dt
    
    fruit:update(dt)
    snake:update(dt)

    for k, v in ipairs(tail) do
        local x, y = v[1], v[2]
        v[1], v[2] = oldPosX, oldPosY
        oldPosX, oldPosY = x, y 
    end

    for k, v in ipairs(tail) do
        if k > 30 then
            if fact:collides(v[1],v[2], snake.x, snake.y) then
                flag = true
                errorPlace = k
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
    push:start()

        --background
        love.graphics.clear(40/255, 45/255, 52/255, 255/255)

        --draw the snake
        snake:render()
        
        for k, v in ipairs(tail) do
            love.graphics.rectangle('fill', v[1], v[2], 10, 10)
        end
        --spawn fruits
        if fruit.exists == true then
            fruit:render()
        end
        --score
        displayScore()

        if flag == true then 
            love.graphics.print('you lose', VIRTUAL_WIDTH / 3, VIRTUAL_HEIGHT / 6)
        end

    push:finish()
end


