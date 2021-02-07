push = require 'push'

Class = require 'class'

require 'Hero'
require 'Obs'


WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
-- size we're trying to emulate with push
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

HERO_WIDTH = 25
HERO_HEIGHT = 50

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('WeirdBird')

    math.randomseed(os.time())

    hero = Hero(VIRTUAL_WIDTH/2, VIRTUAL_HEIGHT-(HERO_HEIGHT), HERO_WIDTH, HERO_HEIGHT)
    obs = Obs((VIRTUAL_WIDTH/2)-50, VIRTUAL_HEIGHT/2, 50, 5)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true,
        canvas = false
    })

end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    if obs.active == true and obs:collides(hero) and hero.state == 'down' then
        obs.active = false
        hero:switchStatus()
    end
    if love.keyboard.isDown('a') then
        hero.dx = -20
    elseif love.keyboard.isDown('d') then
        hero.dx = 20
    else
        hero.dx = 0
    end

    hero:update(dt)
end

function love.draw()
    push:start()

    hero:render()
    obs:render()

    push:finish()

end