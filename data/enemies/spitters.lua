local sounds = require("__base__.prototypes.entity.sounds")
scale_spitter_small    = 0.5
scale_spitter_medium   = 0.7
scale_spitter_big      = 1.0
scale_spitter_behemoth = 1.2
tint_1_spitter_small    = {r=0.94 , g=0.61 , b=0    , a=1 }
tint_2_spitter_small    = {r=0.91 , g=0.92 , b=0.87 , a=1 }
tint_1_spitter_medium   = {r=0.76 , g=0.22 , b=0.30 , a=1 }
tint_2_spitter_medium   = {r=0.89 , g=0.84 , b=0.85 , a=1 }
tint_1_spitter_big      = {r=0.15 , g=0.43 , b=0.68 , a=1 }
tint_2_spitter_big      = {r=0.8  , g=0.82 , b=0.85 , a=1 }
tint_1_spitter_behemoth = {r=0.36 , g=0.18 , b=0.13 , a=1 }
tint_2_spitter_behemoth = {r = 0.7, g = 0.95, b = 0.4, a = 1.000}

data:extend({
	acid_stream({
		name = "acid-stream-spitter-aoe-behemoth",
		scale = scale_spitter_behemoth,
		tint = stream_tint_spitter_behemoth,
		corpse_name = "acid-splash-spitter-behemoth",
		spit_radius = 12,
		particle_spawn_interval = 1,
		particle_spawn_timeout = 6,
		splash_fire_name = "acid-splash-fire-spitter-behemoth",
		sticker_name = "acid-sticker-behemoth"
	})
})

function add_spitter_die_animation(scale, tint1, tint2, corpse)
  corpse.animation = spitterdyinganimation(scale, tint1, tint2)
  corpse.dying_speed = 0.04
  corpse.time_before_removed = 1 * 60 * 60
  corpse.direction_shuffle = { { 1, 2, 3, 16 }, { 4, 5, 6, 7 }, { 8, 9, 10, 11 }, { 12, 13, 14, 15 } }
  corpse.shuffle_directions_at_frame = 4
  corpse.final_render_layer = "lower-object-above-shadow"

  corpse.ground_patch_render_layer = "decals" -- "transport-belt-integration"
  corpse.ground_patch_fade_in_delay = 1 / 0.02 --  in ticks; 1/dying_speed to delay the animation until dying animation finishes
  corpse.ground_patch_fade_in_speed = 0.002
  corpse.ground_patch_fade_out_start = 50 * 60
  corpse.ground_patch_fade_out_duration = 20 * 60

  local a = 1
  local d = 0.9
  corpse.ground_patch =
  {
    sheet =
    {
      filename = "__base__/graphics/entity/biter/blood-puddle-var-main.png",
      flags = { "low-object" },
      line_length = 4,
      variation_count = 4,
      frame_count = 1,
      width = 84,
      height = 68,
      shift = util.by_pixel(1, 0),
      tint = {r = 0.6 * d * a, g = 0.1 * d * a, b = 0.6 * d * a, a = a},
      scale = scale,
      hr_version =
      {
        filename = "__base__/graphics/entity/biter/hr-blood-puddle-var-main.png",
        flags = { "low-object" },
        line_length = 4,
        variation_count = 4,
        frame_count = 1,
        width = 164,
        height = 134,
        shift = util.by_pixel(-0.5,-0.5),
        tint = {r = 0.6 * d * a, g = 0.1 * d * a, b = 0.6 * d * a, a = a},
        scale = 0.5 * scale
      }
    }
  }
  return corpse
end

function drunken_spitter_attack_parameters(data)
  return
  {
    type = "stream",
    ammo_category = "biological",
    cooldown = data.cooldown,
    cooldown_deviation = data.cooldown_deviation,
    range = data.range + 2,
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
smallSpitter.absorptions_to_join_attack = { pollution = 0 }

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
mediumSpitter.absorptions_to_join_attack = { pollution = 0 }

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
bigSpitter.absorptions_to_join_attack = { pollution = 0 }
bigSpitter.spawning_time_modifier = 1

local artilleryBigSpitter = table.deepcopy(bigSpitter)
artilleryBigSpitter.name = "artillery-big-spitter"
artilleryBigSpitter.attack_parameters = spitter_big_attack_parameters(
    {
      acid_stream_name = "acid-stream-spitter-big",
      range = 40,
      min_attack_distance = 20,
      cooldown = 360,
      cooldown_deviation = 0.15,
      damage_modifier = 36,
      scale = scale_spitter_big,
      tint1 = tint_1_spitter_big,
      tint2 = tint_2_spitter_big,
      roarvolume = 0.6,
      range_mode = "bounding-box-to-bounding-box"
    })
    
behemothSpitter = table.deepcopy(data.raw["unit"]["behemoth-spitter"])
behemothSpitter.absorptions_to_join_attack = { pollution = 0 }
behemothSpitter.spawning_time_modifier = 1

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
      scale = 1.2,
      tint1 = tint_1_spitter_behemoth,
      tint2 = tint_2_spitter_behemoth,
      roarvolume = 0.8,
      range_mode = "bounding-box-to-bounding-box"
    })


data:extend{smallSpitter, drunkenSmallSpitter, mediumSpitter, heavyHitterMediumSpitter, bigSpitter, artilleryBigSpitter, behemothSpitter, aoeBehemothSpitter}
data:extend{
  add_spitter_die_animation(scale_spitter_small, tint_1_spitter_small, tint_2_spitter_small,
  {
    type = "corpse",
    name = "small-spitter-corpse",
    icon = "__base__/graphics/icons/big-biter-corpse.png",
    icon_size = 64, icon_mipmaps = 4,
    selectable_in_game = false,
    selection_box = {{-1, -1}, {1, 1}},
    subgroup="corpses",
    order = "c[corpse]-b[spitter]-a[small]",
    flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map"}
  }),

  add_spitter_die_animation(scale_spitter_medium, tint_1_spitter_medium, tint_2_spitter_medium,
  {
    type = "corpse",
    name = "medium-spitter-corpse",
    icon = "__base__/graphics/icons/big-biter-corpse.png",
    icon_size = 64, icon_mipmaps = 4,
    selectable_in_game = false,
    selection_box = {{-1, -1}, {1, 1}},
    subgroup="corpses",
    order = "c[corpse]-b[spitter]-a[small]",
    flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map"}
  }),

  add_spitter_die_animation(scale_spitter_big, tint_1_spitter_big, tint_2_spitter_big,
  {
    type = "corpse",
    name = "big-spitter-corpse",
    icon = "__base__/graphics/icons/big-biter-corpse.png",
    icon_size = 64, icon_mipmaps = 4,
    selectable_in_game = false,
    selection_box = {{-1, -1}, {1, 1}},
    subgroup="corpses",
    order = "c[corpse]-b[spitter]-a[small]",
    flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map"}
  }),

  add_spitter_die_animation(scale_spitter_behemoth, tint_1_spitter_behemoth, tint_2_spitter_behemoth,
  {
    type = "corpse",
    name = "behemoth-spitter-corpse",
    icon = "__base__/graphics/icons/big-biter-corpse.png",
    icon_size = 64, icon_mipmaps = 4,
    selectable_in_game = false,
    selection_box = {{-1, -1}, {1, 1}},
    subgroup="corpses",
    order = "c[corpse]-b[spitter]-a[small]",
    flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map"}
  })
}