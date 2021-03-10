push = require 'libs/push'

Class = require 'libs/class'

require 'models/Hero'
require 'models/Obs'

require 'states/ActiveGame'
require 'states/GameEnded'

-- WINDOW_WIDTH = 432
-- WINDOW_HEIGHT = 243
WINDOW_WIDTH = 1920
WINDOW_HEIGHT = 1080

-- size we're trying to emulate with push
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

HERO_WIDTH = 20
HERO_HEIGHT = 20

HERO_SPEED_X = 70
HERO_NORMAL_JUMP_SPEED = -125
HERO_MEDIUM_JUMP_SPEED = -200
HERO_HEIGHT_JUMP_SPEED = -275


HERO_JUMP_HEIGHT = 130
HERO_JUMP_PROGRESS = 0
HERO_FALL_PROGRESS = HERO_JUMP_HEIGHT


OBS_HEIGHT = 5
OBS_WIDTH = 25

OBS_MIN_GAP = 30
OBS_MAX_GAP = HERO_JUMP_HEIGHT/2

MAX_HERO_Y = 150

RENDERED_Y = 0

gameState = 'active'

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('WeirdBird')

    math.randomseed(os.time())

    smallFont = love.graphics.newFont('assets/fonts/font.ttf', 8)
    meduimFont = love.graphics.newFont('assets/fonts/font.ttf', 16)
    largeFont = love.graphics.newFont('assets/fonts/font.ttf', 32)

    activeGame = ActiveGame()
    gameEnded = GameEnded()

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true,
        canvas = false
    })

    HERO_IMAGE_RIGHT = love.graphics.newImage("assets/images/hero.png")
    HERO_IMAGE_LEFT = love.graphics.newImage("assets/images/hero-left.png")
    HERO_CROWN_IMAGE = love.graphics.newImage("assets/images/hero_crown2.png")
    -- HERO_CROWN_IMAGE = love.graphics.newImage("assets/images/hero_crown.png")
    obs_images = {
        love.graphics.newImage("assets/images/obs.png"),
        love.graphics.newImage("assets/images/obs_deadly.png"),
        love.graphics.newImage("assets/images/obs_cloud.png"),
        love.graphics.newImage("assets/images/obs_height_jump.png"),
        love.graphics.newImage("assets/images/obs.png"),
        love.graphics.newImage("assets/images/obs_one_time.png"),
        love.graphics.newImage("assets/images/obs.png"),
    }
    sounds = {
        ['die'] = love.audio.newSource('assets/sounds/die.wav', 'static'),
        ['jump'] = love.audio.newSource('assets/sounds/jump.wav', 'static'),
        ['height_jump'] = love.audio.newSource('assets/sounds/height_jump.wav', 'static'),
        ['very_height_jump'] = love.audio.newSource('assets/sounds/very_height_jump.wav', 'static')
    }

end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed( key )
    if (gameState == 'ended') then
        activeGame:init()
        gameState = 'active'
    end
end

function love.update(dt)

    if love.keyboard.isDown('a') then
        hero.dx = -HERO_SPEED_X
    elseif love.keyboard.isDown('d') then
        hero.dx = HERO_SPEED_X
    else
        hero.dx = 0
    end

    if gameState == 'active' then
        activeGame:update(dt)
    elseif gameState == 'ended' then
        -- gameEnded:render()
    end

end

function love.draw()
    push:start()

    if gameState == 'active' then
        activeGame:render()
    elseif gameState == 'ended' then
        gameEnded:render()
    end


    push:finish()
end