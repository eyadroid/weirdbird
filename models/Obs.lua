

Obs = Class{}


function Obs:init(x, y, width, height, type)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.active = true;
    self.type = type;

    --1 for normal obs 0.2
    --2 for deadly obs 0.2
    --3 for cloud (fake) obs 0.1
    --4 for hight jump obs 0.2
    --5 for very hight jump obs 0.1
    --6 for one time jump obs 0.1
    --7 for moving obs 0.1

    -- TODO:
    --8 moving very hight jump obs
    --9 moving deadly obs
end

function Obs:render()
    -- if self.type == 1 then

    -- elseif self.type == 2 then
    --     love.graphics.setColor(255,0,0)
    -- elseif self.type == 3 then
    --     -- love.graphics.setColor(255,0,255)
    -- elseif self.type == 4 then
    --     love.graphics.setColor(125,125,0)
    -- elseif self.type == 5 then
    --     love.graphics.setColor(0,255,0)
    -- elseif self.type == 6 then
    --     if (self.active) then
    --         love.graphics.setColor(0,255,255)
    --     else
    --         love.graphics.setColor(0,0,0)
    --     end
    -- elseif self.type == 7 then
    --     love.graphics.setColor(255,255,255)
    -- end
    -- if self.type == 3 then
    --     -- love.graphics.rectangle('fill', self.x, self:getRenderedY(), self.width, self.height)
    --     love.graphics.draw(OBS_CLOUD_IMAGE, self.x, self:getRenderedY())
    -- else
    --     love.graphics.draw(OBS_IMAGE, self.x, self:getRenderedY())
    -- end
    -- love.graphics.setColor(255,255,255)
    if self.active then
        love.graphics.draw(obs_images[self.type], self.x, self:getRenderedY())
    end
    if self.type == 5 then
        love.graphics.draw(HERO_CROWN_IMAGE, self.x+self.width/2, self:getRenderedY()- 10)
    end
end

function Obs:collides(hero)
    theY = self:getRenderedY()
    if self.x > hero.x + hero.width or hero.x > self.x + self.width then
        return false
    end
        
    if theY+5 > hero.y + hero.height and theY-5 < hero.y +hero.height then
        return true
    end 
end

function Obs:getRenderedY()
    if (self.y < 0) then
        return math.abs(RENDERED_Y)-math.abs(self.y)
    else
        if (RENDERED_Y < 0) then
            return math.abs(RENDERED_Y)+self.y
        else
            return self.y
        end
    end
end