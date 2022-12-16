--[[
    Trying my first game, i plan to do snake on love 2d

]]

require 'Snake'
push = require 'push'
Class = require 'class'

-- place where we are going to play
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

--Snake speed, I might change it later to change difficulty
SNAKE_SPEED = 10 


-- Here we make: filter, title, sound, fonts, virtual res
function love.load()
    -- Set default filter
    love.graphics.setDefaultFilter('nearest', 'nearest')

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
    snake = Snake()

    --Direction of the snake
    direction = 'right'

    gameState = 'start'
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        -- the function LÖVE2D uses to quit the application
        love.event.quit()
    end

    -- right movement
    if love.keyboard.isDown('d') then
        snake.direction = 'right' 
    end
    -- left movement
    if love.keyboard.isDown('a') then
        snake.direction = 'left'
    end
    -- up movement
    if love.keyboard.isDown('w') then
        snake.direction = 'up'
    end
    -- down movement
    if love.keyboard.isDown('s') then
        snake.direction = 'down'
    end
end

function love.update(dt)
    

    snake:update(dt)
end

--All the visuals
function love.draw()
    push:start()

        --background
        love.graphics.clear(40/255, 45/255, 52/255, 255/255)

        --draw the snake
        snake:render()
        
    push:finish()
end
