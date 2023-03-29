local sounds = require("__base__.prototypes.entity.sounds")

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