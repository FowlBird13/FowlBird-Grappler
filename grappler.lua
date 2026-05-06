-- Sprite.new(identifier, sprite_path, image_number, x_origin, y_origin)


-- Create a table with the basic animations
local sprites = {
    idle			    = Sprite.new("sGrapplerIdle",       "Sprites/idle.png",     1, 15, 12),
    walk		        = Sprite.new("sGrapplerWalk",		"Sprites/walk.png",     1, 22, 16),
    jump		        = Sprite.new("sGrapplerJump",		"Sprites/jump.png",     1, 20, 10),
    jump_peak	        = Sprite.new("sGrapplerJumpPeak",	"Sprites/jumppeak.png", 1, 20, 10),
    lfall		        = Sprite.new("sGrapplerFall",		"Sprites/fall.png",     1, 20, 10),
    climb		        = Sprite.new("sGrapplerClimb",		"Sprites/climb.png",    1, 21, 28),
    climb_hurt	        = Sprite.new("sGrapplerClimbHurt",	"Sprites/climb.png",    1, 21, 28),
    death		        = Sprite.new("sGrapplerDeath",		"Sprites/death.png",    1, 28, 28),
    decoy		        = Sprite.new("sGrapplerDecoy",		"Sprites/decoy.png",    1, 18, 36)
}

-- Create a table with the ability animations (referred to as "shoot")
local sGrapplerShoot = {
    shoot1_a            = Sprite.new("sGrapplerShoot1_a",   "Sprites/shoot1_a",     1, 23, 38),
    shoot1_b            = Sprite.new("sGrapplerShoot1_b",   "Sprites/shoot1_b",     1, 23, 38),
    shoot1_c            = Sprite.new("sGrapplerShoot1_c",   "Sprites/shoot1_c",     1, 23, 38),
    shoot2              = Sprite.new("sGrapplerShoot2",     "Sprites/shoot2",       1, 23, 38),
    shoot3              = Sprite.new("sGrapplerShoot3",     "Sprites/shoot3",       1, 23, 38),
    shoot4              = Sprite.new("sGrapplerShoot4",     "Sprites/shoot4",       1, 23, 38)
}

local sGrapplerSkills = Sprite.new("sGrapplerSkills", "Sprites/skills", 5)

--Create the new survivor instance: grappler
local grappler = Survivor.new("grappler")

grappler.sprite_idle = sprites.idle

Callback.add(grappler.on_init, function(actor)
	actor.sprite_idle			= sprites.idle
	actor.sprite_walk			= sprites.walk
	actor.sprite_jump			= sprites.jump
	actor.sprite_jump_peak		= sprites.jump_peak
	actor.sprite_fall			= sprites.fall
	actor.sprite_climb			= sprites.climb
	actor.sprite_death			= sprites.death
	actor.sprite_decoy			= sprites.decoy
	actor.sprite_climb_hurt		= sprites.climb_hurt
end)

--These base stats and level stats needed to be added and balanced. Miner and Drifter would be good to look at
grappler:set_stats_base({
    health = 1,
    damage = 1,
    regen = 1
})

grappler:set_stats_level({
    health = 1,
    damage = 1,
    regen = 1,
    armor = 1,
})

local grapplerZ = grappler:get_skills(0)[1]
local grapplerX = grappler:get_skills(1)[1]
local grapplerC = grappler:get_skills(2)[1]
local grapplerV = grappler:get_skills(3)[1]

grapplerZ.animation = sGrapplerShoot[1]
grapplerX.animation = sGrapplerShoot[4]
grapplerC.animation = sGrapplerShoot[5]
grapplerV.animation = sGrapplerShoot[6]

