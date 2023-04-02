local sounds = require("__base__.prototypes.entity.sounds")

small_biter_scale = 0.5
small_biter_tint1 = {r=0.60, g=0.58, b=0.51, a=1}
small_biter_tint2 = {r=0.9 , g=0.83, b=0.54, a=1}

medium_biter_scale = 0.7
medium_biter_tint1 = {r=0.49, g=0.46, b=0.51, a=1}
medium_biter_tint2 = {r=0.93, g=0.72, b=0.72, a=1}

big_biter_scale = 1.0
big_biter_tint1 = {r=0.37, g=0.40, b=0.72, a=1}
big_biter_tint2 = {r=0.55, g=0.76, b=0.75, a=1}

behemoth_biter_scale = 1.2
behemoth_biter_tint1 = {r=0.21, g=0.19, b=0.25, a=1}
behemoth_biter_tint2 = {r = 0.657, g = 0.95, b = 0.432, a = 1.000}

function add_biter_die_animation(scale, tint1, tint2, corpse)
  corpse.animation = biterdieanimation(scale, tint1, tint2)
  corpse.dying_speed = 0.04
  corpse.time_before_removed = 2 * 60 * 60
  corpse.direction_shuffle = { { 1, 2, 3, 16 }, { 4, 5, 6, 7 }, { 8, 9, 10, 11 }, { 12, 13, 14, 15 } }
  corpse.shuffle_directions_at_frame = 7
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

smallBiter = table.deepcopy(data.raw["unit"]["small-biter"])
smallBiter.pollution_to_join_attack = 0

local adrenalineSmallBiter = table.deepcopy(smallBiter)
adrenalineSmallBiter.name = "adrenaline-small-biter"
adrenalineSmallBiter.attack_parameters =
    {
      type = "projectile",
      range = 0.5,
      cooldown = 20,
      cooldown_deviation = 0.15,
      ammo_type = make_unit_melee_ammo_type(7),
      sound = sounds.biter_roars(0.35),
      animation = biterattackanimation(small_biter_scale, small_biter_tint1, small_biter_tint2),
      range_mode = "bounding-box-to-bounding-box"
    }
adrenalineSmallBiter.movement_speed = 0.4
adrenalineSmallBiter.distance_per_frame = 0.25
adrenalineSmallBiter.distraction_cooldown = 0.25

mediumBiter = table.deepcopy(data.raw["unit"]["medium-biter"])
mediumBiter.pollution_to_join_attack = 0

resistantMediumBiter = table.deepcopy(mediumBiter) 
resistantMediumBiter.name = "resistant-medium-biter"
resistantMediumBiter.resistances =
    {
      {
        type = "physical",
        decrease = 6,
        percent = 40
      },
      {
        type = "explosion",
        decrease = 4,
        percent = 40
      }
      ,
      {
        type = "poison",
        percent = 95
      }
      ,
      {
        type = "fire",
        percent = 50
      }
      ,
      {
        type = "laser",
        decrease = 5,
        percent = 30
      }
      ,
      {
        type = "electric",
        percent = 30
      }
      ,
      {
        type = "impact",
        decrease = 4,
        percent = 30
      }
    }

bigBiter = table.deepcopy(data.raw["unit"]["big-biter"])
bigBiter.pollution_to_join_attack = 0

sharpTeethBigBiter = table.deepcopy(bigBiter)
sharpTeethBigBiter.name = "sharp-teeth-big-biter"
sharpTeethBigBiter.attack_parameters =
    {
      type = "projectile",
      range = 1.5,
      cooldown = 35,
      cooldown_deviation = 0.15,
      ammo_type = make_unit_melee_ammo_type(60),
      sound =  sounds.biter_roars_big(0.37),
      animation = biterattackanimation(big_biter_scale, big_biter_tint1, big_biter_tint2),
      range_mode = "bounding-box-to-bounding-box"
    }
    
behemothBiter = table.deepcopy(data.raw["unit"]["behemoth-biter"])
behemothBiter.pollution_to_join_attack = 0

regenerativeBehemothBiter = table.deepcopy(behemothBiter)
regenerativeBehemothBiter.name = "regenerative-behemoth-biter"
regenerativeBehemothBiter.healing_per_tick = 2

data:extend{adrenalineSmallBiter, smallBiter, resistantMediumBiter, mediumBiter, sharpTeethBigBiter, bigBiter, behemothBiter, regenerativeBehemothBiter}
data:extend{
	add_biter_die_animation(small_biter_scale, small_biter_tint1, small_biter_tint2,
	  {
	    type = "corpse",
	    name = "small-biter-corpse",
	    icon = "__base__/graphics/icons/small-biter-corpse.png",
	    icon_size = 64, icon_mipmaps = 4,
	    selection_box = {{-0.8, -0.8}, {0.8, 0.8}},
	    selectable_in_game = false,
	    subgroup="corpses",
	    order = "c[corpse]-a[biter]-a[small]",
	    flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-repairable", "not-on-map"}
	  }),
	add_biter_die_animation(medium_biter_scale, medium_biter_tint1, medium_biter_tint2,
	  {
	    type = "corpse",
	    name = "medium-biter-corpse",
	    icon = "__base__/graphics/icons/medium-biter-corpse.png",
	    icon_size = 64, icon_mipmaps = 4,
	    selectable_in_game = false,
	    selection_box = {{-1, -1}, {1, 1}},
	    subgroup="corpses",
	    order = "c[corpse]-a[biter]-b[medium]",
	    flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map"}
	  }),
	add_biter_die_animation(big_biter_scale, big_biter_tint1, big_biter_tint2,
	  {
	    type = "corpse",
	    name = "big-biter-corpse",
	    icon = "__base__/graphics/icons/big-biter-corpse.png",
	    icon_size = 64, icon_mipmaps = 4,
	    selectable_in_game = false,
	    selection_box = {{-1, -1}, {1, 1}},
	    subgroup="corpses",
	    order = "c[corpse]-a[biter]-c[big]",
	    flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map"}
	  }),
	add_biter_die_animation(behemoth_biter_scale, behemoth_biter_tint1, behemoth_biter_tint2,
	  {
	    type = "corpse",
	    name = "behemoth-biter-corpse",
	    icon = "__base__/graphics/icons/big-biter-corpse.png",
	    icon_size = 64, icon_mipmaps = 4,
	    selectable_in_game = false,
	    selection_box = {{-1, -1}, {1, 1}},
	    subgroup="corpses",
	    order = "c[corpse]-a[biter]-c[big]",
	    flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map"}
	})
}
