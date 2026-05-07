-- Sprite.new(identifier, sprite_path, image_number, x_origin, y_origin)

local SPRITE_PATH = path.combine(PATH, "Sprites")

-- Create a table with the basic animations
local sprites = {
    idle			    = Sprite.new("sGrapplerIdle",       path.combine(SPRITE_PATH, "idle.png"),     1, 0, 0),
    walk		        = Sprite.new("sGrapplerWalk",		path.combine(SPRITE_PATH, "walk.png"),     1, 0, 0),
    jump		        = Sprite.new("sGrapplerJump",		path.combine(SPRITE_PATH, "jump.png"),     1, 0, 0),
    jump_peak	        = Sprite.new("sGrapplerJumpPeak",	path.combine(SPRITE_PATH, "jump_peak.png"), 1, 0, 0),
    fall		        = Sprite.new("sGrapplerFall",		path.combine(SPRITE_PATH, "fall.png"),     1, 0, 0),
    climb		        = Sprite.new("sUtilitylimb",		path.combine(SPRITE_PATH, "climb.png"),    1, 0, 0),
    climb_hurt	        = Sprite.new("sUtilitylimbHurt",	path.combine(SPRITE_PATH, "climb.png"),    1, 0, 0),
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
grappler.sprite_title = sprites.walk
grappler.namespace = "Grappler"

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

local primary = grappler:get_skills(0)[1]
local secondary = grappler:get_skills(1)[1]
local utility = grappler:get_skills(2)[1]
local special = grappler:get_skills(3)[1]

primary.animation = sGrapplerShoot[1]
secondary.animation = sGrapplerShoot[4]
utility.animation = sGrapplerShoot[5]
special.animation = sGrapplerShoot[6]

-- assign a skill icon to each of the abilities
primary.sprite = sGrapplerSkills
primary.subimage = 0
secondary.sprite = sGrapplerSkills
secondary.subimage = 1
utility.sprite = sGrapplerSkills
utility.subimage = 2
special.sprite = sGrapplerSkills
special.subimage = 3

primary.damage = 1
primary.cooldown = 40
secondary.damage = 3
secondary.cooldown = 120
utility.damage = 5
utility.cooldown = 240
special.damage = 3
special.cooldown = 120

-- create states that the actor can "be in"
local statePrimary = ActorState.new(primary.identifier)
statePrimary.activity_flags = ActorState.ActivityFlag.ALLOW_ROPE_CANCEL
local stateSecondary = ActorState.new(secondary.identifier)
local stateUtility = ActorState.new(utility.identifier)
local stateSpecial = ActorState.new(special.identifier)

-- set grappler's animation to the ability that is activated
Callback.add(primary.on_activate, function(actor, skill, slot)
	actor:set_state(statePrimary)
end)
Callback.add(secondary.on_activate, function(actor, skill, slot)
	actor:set_state(stateSecondary)
end)
Callback.add(utility.on_activate, function(actor, skill, slot)
	actor:set_state(stateUtility)
end)
Callback.add(special.on_activate, function(actor, skill, slot)
	actor:set_state(stateSpecial)
end)
