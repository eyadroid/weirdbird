ActiveGame = Class{}

randomTypes = {
    1,1,1,
    2,
    3,
    4,4,
    5,
    6,
    7
}
function ActiveGame:init()
    RENDERED_Y = 0
    HERO_JUMP_HEIGHT = 130
    HERO_JUMP_PROGRESS = 0
    HERO_FALL_PROGRESS = HERO_JUMP_HEIGHT

    MAX_HERO_Y = 80

    hero = Hero(VIRTUAL_WIDTH/2, VIRTUAL_HEIGHT-(HERO_HEIGHT), HERO_WIDTH, HERO_HEIGHT)
    self.obses = {}
    for i = 1,10,1 do
        obs_y = 0
        if i > 1 then
            obs_y =  self.obses[i-1].y - math.random(OBS_MIN_GAP, OBS_MAX_GAP)
        else
            obs_y =  VIRTUAL_HEIGHT - math.random(OBS_MIN_GAP, OBS_MAX_GAP)
        end
        self.obses[i] = Obs(getRandomObsX(), obs_y, OBS_WIDTH, OBS_HEIGHT, 5)
    end

end

function ActiveGame:update(dt)

    for _, obs in pairs(self.obses) do
        if obs:collides(hero) and hero.state == 'falling' then
            if obs.type == 1 then
                hero:switchStatus(1)
            elseif obs.type == 2 then
                gameState = 'ended'
                sounds['die']:play()
            elseif obs.type == 3 then
                obs.active = false
            elseif obs.type == 4 then
                hero:switchStatus(2)
            elseif obs.type == 5 then
                hero:switchStatus(3)
            elseif obs.type == 6 then
                if obs.active then
                    hero:switchStatus(1)
                    obs.active = false
                end
            elseif obs.type == 7 then
                hero:switchStatus(1)
            end
        end
    end

    if (hero.state == 'jumping') then
        
        HERO_JUMP_PROGRESS=HERO_JUMP_PROGRESS-hero.dy * dt
        if (HERO_JUMP_PROGRESS >= HERO_JUMP_HEIGHT) then
            hero:switchStatus()
        end

        if (hero.y > MAX_HERO_Y) then
            hero:updateY(dt)
        else
            RENDERED_Y=RENDERED_Y+hero.dy*dt
        end
    end
    
    if (hero.state == 'falling') then

        HERO_FALL_PROGRESS=HERO_FALL_PROGRESS-hero.dy * dt
        if (HERO_FALL_PROGRESS <= 0) then
            gameState = 'ended'
        end
        
        if (hero.y < VIRTUAL_HEIGHT-hero.height) then
            hero:updateY(dt)
        else
            RENDERED_Y=RENDERED_Y+hero.dy*dt
        end
    end
    hero:updateX(dt)

    for _, obs in pairs(self.obses) do
        if obs:getRenderedY()  > VIRTUAL_HEIGHT then
            obs.y = self:getUpperObs() - math.random(OBS_MIN_GAP, OBS_MAX_GAP)
            obs.type = getRandomObsType()
            obs.active = true
        end
    end
end

function ActiveGame:render()
    hero:render()
    
    for _, obs in pairs(self.obses) do
        obsRenderedY = obs:getRenderedY()
        if obsRenderedY + 5 > 0 and obsRenderedY < VIRTUAL_HEIGHT then
            obs:render()
        end
    end
end

function getRandomObsX() 
    return (VIRTUAL_WIDTH/2)-math.random(-VIRTUAL_WIDTH/4, VIRTUAL_WIDTH/4)
end

function ActiveGame:getUpperObs() 
    leastY = 0
    
    for _, obs in pairs(self.obses) do
        if obs.y < leastY then
            leastY = obs.y
        end
    end

    return leastY
end

function getRandomObsType() 
    -- return 5
    return randomTypes[math.random(1,10)]
end