-- Sprite.new(identifier, sprite_path, image_number, x_origin, y_origin)

local SPRITE_PATH = path.combine(PATH, "Sprites")

-- Create a table with the basic animations
local sprites = {
    idle			    = Sprite.new("sGrapplerIdle",       path.combine(SPRITE_PATH, "idle.png"),     1, 0, 0),
    walk		        = Sprite.new("sGrapplerWalk",		path.combine(SPRITE_PATH, "walk.png"),     1, 0, 0),
    jump		        = Sprite.new("sGrapplerJump",		path.combine(SPRITE_PATH, "jump.png"),     1, 0, 0),
    jump_peak	        = Sprite.new("sGrapplerJumpPeak",	path.combine(SPRITE_PATH, "jump_peak.png"), 1, 0, 0),
    fall		        = Sprite.new("sGrapplerFall",		path.combine(SPRITE_PATH, "fall.png"),     1, 0, 0),
    climb		        = Sprite.new("sGrapplerClimb",		path.combine(SPRITE_PATH, "climb.png"),    1, 0, 0),
    climb_hurt	        = Sprite.new("sGrapplerClimbHurt",	path.combine(SPRITE_PATH, "climb.png"),    1, 0, 0),
    death		        = Sprite.new("sGrapplerDeath",		path.combine(SPRITE_PATH, "death.png"),    1, 0, 0),
    decoy		        = Sprite.new("sGrapplerDecoy",		path.combine(SPRITE_PATH, "decoy.png"),    1, 0, 0)
}

-- Create a table with the ability animations (referred to as "shoot")
local sGrapplerShoot = {
    shoot1_a            = Sprite.new("sGrapplerShoot1_a",   path.combine(SPRITE_PATH, "shoot1_a.png"),     1, 0, 0),
    shoot1_b            = Sprite.new("sGrapplerShoot1_b",   path.combine(SPRITE_PATH, "shoot1_b.png"),     1, 0, 0),
    shoot1_c            = Sprite.new("sGrapplerShoot1_c",   path.combine(SPRITE_PATH, "shoot1_c.png"),     1, 0, 0),
    shoot2              = Sprite.new("sGrapplerShoot2",     path.combine(SPRITE_PATH, "shoot2.png"),       1, 0, 0),
    shoot3              = Sprite.new("sGrapplerShoot3",     path.combine(SPRITE_PATH, "shoot3.png"),       1, 0, 0),
    shoot4              = Sprite.new("sGrapplerShoot4",     path.combine(SPRITE_PATH, "shoot4.png"),       1, 0, 0)
}

local sGrapplerSkills = Sprite.new("sGrapplerSkills", path.combine(SPRITE_PATH, "skills.png"), 5)

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

-- assign a skill icon to each of the abilities
grapplerZ.sprite = sGrapplerSkills
grapplerZ.subimage = 0
grapplerX.sprite = sGrapplerSkills
grapplerX.subimage = 1
grapplerC.sprite = sGrapplerSkills
grapplerC.subimage = 2
grapplerV.sprite = sGrapplerSkills
grapplerV.subimage = 3

grapplerZ.damage = 1
grapplerZ.cooldown = 40
grapplerX.damage = 3
grapplerX.cooldown = 120
grapplerC.damage = 5
grapplerC.cooldown = 240
grapplerV.damage = 3
grapplerV.cooldown = 120

-- create states that the actor can "be in"
local stateGrapplerZ = ActorState.new(grapplerZ.identifier)
stateGrapplerZ.activity_flags = ActorState.ActivityFlag.ALLOW_ROPE_CANCEL
local stateGrapplerX = ActorState.new(grapplerX.identifier)
local stateGrapplerC = ActorState.new(grapplerC.identifier)
local stateGrapplerV = ActorState.new(grapplerV.identifier)

-- set grappler's animation to the ability that is activated
Callback.add(grapplerZ.on_activate, function(actor, skill, slot)
	actor:set_state(stateGrapplerZ)
end)
Callback.add(grapplerX.on_activate, function(actor, skill, slot)
	actor:set_state(stateGrapplerX)
end)
Callback.add(grapplerC.on_activate, function(actor, skill, slot)
	actor:set_state(stateGrapplerC)
end)
Callback.add(grapplerV.on_activate, function(actor, skill, slot)
	actor:set_state(stateGrapplerV)
end)