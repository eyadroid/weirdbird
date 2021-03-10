

Hero = Class{}


function Hero:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dy = -125
    self.dx = 0
    self.state = 'jumping'
    self.direction = 1
end

function Hero:switchStatus(jumpHeight)
    -- 1 for normal height
    -- 2 for height jump
    -- 3 for very height jump
    if self.state == 'jumping' then
        self.state = 'falling'
        self.dy = 125
        HERO_FALL_PROGRESS = HERO_JUMP_HEIGHT
    elseif self.state == 'falling' then
        self.state = 'jumping'
        if jumpHeight == 1 then
            HERO_JUMP_HEIGHT = 130
            self.dy = HERO_NORMAL_JUMP_SPEED
            sounds['jump']:play()
        elseif jumpHeight == 2 then
            HERO_JUMP_HEIGHT = VIRTUAL_HEIGHT
            self.dy = HERO_MEDIUM_JUMP_SPEED
            sounds['height_jump']:play()
        elseif jumpHeight == 3 then
            HERO_JUMP_HEIGHT = VIRTUAL_HEIGHT*2
            self.dy = HERO_HEIGHT_JUMP_SPEED
            sounds['very_height_jump']:play()
        end
        HERO_JUMP_PROGRESS = 0
    end
end

function Hero:updateY(dt)
    if self.state == 'jumping' then
        self.y = self.y + self.dy * dt
        -- self.dy = self.dy+-3
    else
        self.y = self.y + self.dy * dt
        -- self.dy = self.dy+3
    end
end

function Hero:updateX(dt)
    self.x = self.x + self.dx * dt
    if self.dx > 0 then self.direction = 1
    elseif self.dx < 0 then self.direction = -1
    end
end

function Hero:render()
    -- love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    if self.direction == 1 then heroImage = HERO_IMAGE_RIGHT
    elseif self.direction == -1 then heroImage = HERO_IMAGE_LEFT
    end
    love.graphics.draw(heroImage, self.x, self.y)
end