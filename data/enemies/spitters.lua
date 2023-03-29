local sounds = require("__base__.prototypes.entity.sounds")

data:extend({
	acid_stream({
		name = "acid-stream-spitter-aoe-behemoth",
		scale = scale_spitter_behemoth,
		tint = stream_tint_spitter_behemoth,
		corpse_name = "acid-splash-spitter-behemoth",
		spit_radius = 5,
		particle_spawn_interval = 1,
		particle_spawn_timeout = 6,
		splash_fire_name = "acid-splash-fire-spitter-behemoth",
		sticker_name = "acid-sticker-behemoth"
	})
})

function drunken_spitter_attack_parameters(data)
  return
  {
    type = "stream",
    ammo_category = "biological",
    cooldown = data.cooldown,
    cooldown_deviation = data.cooldown_deviation,
    range = data.range,
    range_mode = data.range_mode,
    min_attack_distance = data.min_attack_distance,
    --projectile_creation_distance = 1.9,
    damage_modifier = data.damage_modifier,
    warmup = 30,
    projectile_creation_parameters = spitter_shoot_shiftings(data.scale, data.scale * scale_spitter_stream),
    use_shooter_direction = true,

    lead_target_for_projectile_speed = 0,

    ammo_type =
    {
      category = "biological",
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "stream",
          stream = data.acid_stream_name
        }
      }
    },
    cyclic_sound =
    {
      begin_sound =
      {
        {
          filename = "__base__/sound/creatures/spitter-spit-start-1.ogg",
          volume = 0.27
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-start-2.ogg",
          volume = 0.27
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-start-3.ogg",
          volume = 0.27
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-start-4.ogg",
          volume = 0.27
        }
      },
      middle_sound =
      {
        {
          filename = "__base__/sound/fight/flamethrower-mid.ogg",
          volume = 0
        }
      },
      end_sound =
      {
        {
          filename = "__base__/sound/creatures/spitter-spit-end-1.ogg",
          volume = 0
        }
      }
    },
    --sound = sounds.spitter_roars(data.roarvolume),
    animation = spitterattackanimation(data.scale, data.tint1, data.tint2)
  }
end

smallSpitter = table.deepcopy(data.raw["unit"]["small-spitter"])
smallSpitter.pollution_to_join_attack = 0

local drunkenSmallSpitter = table.deepcopy(smallSpitter)
drunkenSmallSpitter.name = "drunken-small-spitter"
drunkenSmallSpitter.attack_parameters =  drunken_spitter_attack_parameters({
      acid_stream_name = "acid-stream-spitter-small",
      range = range_spitter_small,
      min_attack_distance = 10,
      cooldown = 100,
      cooldown_deviation = 0.15,
      damage_modifier = damage_modifier_spitter_small,
      scale = scale_spitter_small,
      tint1 = tint_1_spitter_small,
      tint2 = tint_2_spitter_small,
      roarvolume = 0.4,
      range_mode = "bounding-box-to-bounding-box"
    })
    
mediumSpitter = table.deepcopy(data.raw["unit"]["medium-spitter"])
mediumSpitter.pollution_to_join_attack = 0

local heavyHitterMediumSpitter = table.deepcopy(mediumSpitter)
heavyHitterMediumSpitter.name = "heavy-hitter-medium-spitter"
heavyHitterMediumSpitter.attack_parameters = spitter_mid_attack_parameters(
    {
      acid_stream_name = "acid-stream-spitter-medium",
      range = range_spitter_medium,
      min_attack_distance = 10,
      cooldown = 100,
      cooldown_deviation = 0.15,
      damage_modifier = 48,
      scale = scale_spitter_medium,
      tint1 = tint_1_spitter_medium,
      tint2 = tint_2_spitter_medium,
      roarvolume = 0.5,
      range_mode = "bounding-box-to-bounding-box"
    })
    
bigSpitter = table.deepcopy(data.raw["unit"]["big-spitter"])
bigSpitter.pollution_to_join_attack = 0

local artilleryBigSpitter = table.deepcopy(bigSpitter)
artilleryBigSpitter.name = "artillery-big-spitter"
artilleryBigSpitter.attack_parameters = spitter_big_attack_parameters(
    {
      acid_stream_name = "acid-stream-spitter-big",
      range = 40,
      min_attack_distance = 20,
      cooldown = 600,
      cooldown_deviation = 0.15,
      damage_modifier = 36,
      scale = scale_spitter_big,
      tint1 = tint_1_spitter_big,
      tint2 = tint_2_spitter_big,
      roarvolume = 0.6,
      range_mode = "bounding-box-to-bounding-box"
    })
    
behemothSpitter = table.deepcopy(data.raw["unit"]["behemoth-spitter"])
behemothSpitter.pollution_to_join_attack = 0

local aoeBehemothSpitter = table.deepcopy(behemothSpitter)
aoeBehemothSpitter.name = "aoe-behemoth-spitter"
aoeBehemothSpitter.attack_parameters = spitter_behemoth_attack_parameters(
    {
      acid_stream_name = "acid-stream-spitter-aoe-behemoth",
      range = range_spitter_behemoth,
      min_attack_distance = 10,
      cooldown = 100,
      cooldown_deviation = 0.15,
      damage_modifier = damage_modifier_spitter_behemoth,
      scale = 5,
      tint1 = tint_1_spitter_behemoth,
      tint2 = tint_2_spitter_behemoth,
      roarvolume = 0.8,
      range_mode = "bounding-box-to-bounding-box"
    })


data:extend{smallSpitter, drunkenSmallSpitter, mediumSpitter, heavyHitterMediumSpitter, bigSpitter, artilleryBigSpitter, behemothSpitter, aoeBehemothSpitter}