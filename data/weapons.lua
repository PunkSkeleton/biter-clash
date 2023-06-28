local math3d = require "math3d"
local sounds = require("__base__.prototypes.entity.sounds")
local fireutil = require("__base__.prototypes.fire-util")

fireutil.turret_gun_shift =
{
  north = util.by_pixel(0.0, -6.0),
  east = util.by_pixel(18.5, 9.5),
  south = util.by_pixel(0.0, 19.0),
  west = util.by_pixel(-12.0, 5.5)
}

fireutil.turret_model_info =
{
  tilt_pivot = { -1.68551, 0, 2.35439 },
  gun_tip_lowered = { 4.27735, 0, 3.97644 },
  gun_tip_raised = { 2.2515, 0, 7.10942 },
  units_per_tile = 4
}

fireutil.gun_center_base = math3d.vector2.sub({0,  -0.725}, fireutil.turret_gun_shift.south)

local flamethrowerTurret = table.deepcopy(data.raw["fluid-turret"]["flamethrower-turret"])
flamethrowerTurret.attack_parameters =
    {
      type = "stream",
      cooldown = 4,
      range = 30,
      min_range = 6,

      turn_range = 1.0 / 3.0,
      fire_penalty = 15,

      -- lead_target_for_projectile_speed = 0.2* 0.75 * 1.5, -- this is same as particle horizontal speed of flamethrower fire stream

      fluids =
      {
        {type = "crude-oil"},
        {type = "heavy-oil", damage_modifier = 1.5},
        {type = "light-oil", damage_modifier = 2}
      },
      fluid_consumption = 1,

      gun_center_shift =
      {
        north = math3d.vector2.add(fireutil.gun_center_base, fireutil.turret_gun_shift.north),
        east = math3d.vector2.add(fireutil.gun_center_base, fireutil.turret_gun_shift.east),
        south = math3d.vector2.add(fireutil.gun_center_base, fireutil.turret_gun_shift.south),
        west = math3d.vector2.add(fireutil.gun_center_base, fireutil.turret_gun_shift.west)
      },
      gun_barrel_length = 0.4,

      ammo_type =
      {
        category = "flamethrower",
        action =
        {
          type = "direct",
          action_delivery =
          {
            type = "stream",
            stream = "flamethrower-fire-stream",
            source_offset = {0.15, -0.5}
          }
        }
      },

      cyclic_sound =
      {
        begin_sound =
        {
          {
            filename = "__base__/sound/fight/flamethrower-turret-start-01.ogg",
            volume = 0.5
          },
          {
            filename = "__base__/sound/fight/flamethrower-turret-start-02.ogg",
            volume = 0.5
          },
          {
            filename = "__base__/sound/fight/flamethrower-turret-start-03.ogg",
            volume = 0.5
          }
        },
        middle_sound =
        {
          {
            filename = "__base__/sound/fight/flamethrower-turret-mid-01.ogg",
            volume = 0.5
          },
          {
            filename = "__base__/sound/fight/flamethrower-turret-mid-02.ogg",
            volume = 0.5
          },
          {
            filename = "__base__/sound/fight/flamethrower-turret-mid-03.ogg",
            volume = 0.5
          }
        },
        end_sound =
        {
          {
            filename = "__base__/sound/fight/flamethrower-turret-end-01.ogg",
            volume = 0.5
          },
          {
            filename = "__base__/sound/fight/flamethrower-turret-end-02.ogg",
            volume = 0.5
          },
          {
            filename = "__base__/sound/fight/flamethrower-turret-end-03.ogg",
            volume = 0.5
          }
        }
      }
    }

local flamethrowerFireStream = table.deepcopy(data.raw["stream"]["flamethrower-fire-stream"])
flamethrowerFireStream.action =
    {
      {
        type = "area",
        radius = 2.5,
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-sticker",
              sticker = "fire-sticker",
              show_in_tooltip = true
            },
            {
              type = "damage",
              damage = { amount = 0.5, type = "fire" },
              apply_damage_to_trees = false
            }
          }
        }
      },
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-fire",
              entity_name = "fire-flame",
              show_in_tooltip = true
            }
          }
        }
      }
    }
    
local fireSticker = table.deepcopy(data.raw["sticker"]["fire-sticker"])
fireSticker.duration_in_ticks = 10 * 60
fireSticker.damage_per_tick = { amount = 3 * 50 / 60, type = "fire" }

local fireFlame = table.deepcopy(data.raw["fire"]["fire-flame"])
fireFlame.damage_per_tick = {amount = 2 / 60, type = "fire"}

local yellowAmmo = table.deepcopy(data.raw["ammo"]["firearm-magazine"])
yellowAmmo.magazine_size = 20
yellowAmmo.ammo_type =
    {
      category = "bullet",
      action =
      {
        {
          type = "direct",
          action_delivery =
          {
            {
              type = "instant",
              source_effects =
              {
                {
                  type = "create-explosion",
                  entity_name = "explosion-gunshot"
                }
              },
              target_effects =
              {
                {
                  type = "create-entity",
                  entity_name = "explosion-hit",
                  offsets = {{0, 1}},
                  offset_deviation = {{-0.5, -0.5}, {0.5, 0.5}}
                },
                {
                  type = "damage",
                  damage = { amount = 4 , type = "physical"}
                }
              }
            }
          }
        }
      }
    }

local redAmmo = table.deepcopy(data.raw["ammo"]["piercing-rounds-magazine"])
redAmmo.magazine_size = 20
redAmmo.ammo_type =
    {
      category = "bullet",
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          source_effects =
          {
            type = "create-explosion",
            entity_name = "explosion-gunshot"
          },
          target_effects =
          {
            {
              type = "create-entity",
              entity_name = "explosion-hit",
              offsets = {{0, 1}},
              offset_deviation = {{-0.5, -0.5}, {0.5, 0.5}}
            },
            {
              type = "damage",
              damage = { amount = 10, type = "physical"}
            }
          }
        }
      }
    }

local greenAmmo = table.deepcopy(data.raw["ammo"]["uranium-rounds-magazine"])
greenAmmo.magazine_size = 20

local laserTurret = table.deepcopy(data.raw["electric-turret"]["laser-turret"])
laserTurret.attack_parameters =
    {
      type = "beam",
      cooldown = 40,
      range = 50,
      source_direction_count = 64,
      source_offset = {0, -3.423489 / 4},
      damage_modifier = 2,
      ammo_type =
      {
        category = "laser",
        energy_consumption = "800kJ",
        action =
        {
          type = "direct",
          action_delivery =
          {
            type = "beam",
            beam = "laser-beam",
            max_length = 24,
            duration = 40,
            source_offset = {0, -1.31439 }
          }
        }
      }
    }

local poisonCloud = table.deepcopy(data.raw["smoke-with-trigger"]["poison-cloud"])
poisonCloud.duration = 60 * 10

local slowdownSticker = table.deepcopy(data.raw["sticker"]["slowdown-sticker"])
slowdownSticker.duration_in_ticks = 60 * 5

local grenade = table.deepcopy(data.raw["projectile"]["grenade"])
grenade.action =
    {
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-entity",
              entity_name = "grenade-explosion"
            },
            {
              type = "create-entity",
              entity_name = "small-scorchmark-tintable",
              check_buildability = true
            },
            {
              type = "invoke-tile-trigger",
              repeat_count = 1
            },
            {
              type = "destroy-decoratives",
              from_render_layer = "decorative",
              to_render_layer = "object",
              include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
              include_decals = false,
              invoke_decorative_trigger = true,
              decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
              radius = 2 -- large radius for demostrative purposes
            }
          }
        }
      },
      {
        type = "area",
        radius = 5,
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "damage",
              damage = {amount = 35, type = "explosion"}
            },
            {
              type = "create-entity",
              entity_name = "explosion"
            }
          }
        }
      }
    }

data:extend{flamethrowerTurret, flamethrowerFireStream, fireSticker, fireFlame, yellowAmmo, redAmmo, greenAmmo, laserTurret, poisonCloud, slowdownSticker, grenade}
