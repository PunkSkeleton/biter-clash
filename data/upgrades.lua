local physical_projectile_damage_1_icon = "__base__/graphics/technology/physical-projectile-damage-1.png"
local physical_projectile_damage_2_icon = "__base__/graphics/technology/physical-projectile-damage-2.png"
local stronger_explosives_1_icon = "__base__/graphics/technology/stronger-explosives-1.png"
local stronger_explosives_2_icon = "__base__/graphics/technology/stronger-explosives-2.png"
local stronger_explosives_3_icon = "__base__/graphics/technology/stronger-explosives-3.png"
local refined_flammables_icon = "__base__/graphics/technology/refined-flammables.png"
local energy_weapons_damage_1_icon = "__base__/graphics/technology/energy-weapons-damage.png"
local energy_weapons_damage_2_icon = "__base__/graphics/technology/energy-weapons-damage.png"
local energy_weapons_damage_3_icon = "__base__/graphics/technology/energy-weapons-damage.png"
local weapon_shooting_speed_1_icon = "__base__/graphics/technology/weapon-shooting-speed-1.png"
local weapon_shooting_speed_2_icon = "__base__/graphics/technology/weapon-shooting-speed-2.png"
local weapon_shooting_speed_3_icon = "__base__/graphics/technology/weapon-shooting-speed-3.png"
local laser_shooting_speed_icon = "__base__/graphics/technology/laser-shooting-speed.png"

data:extend(
{
  {
    type = "technology",
    name = "physical-projectile-damage-1",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_damage(physical_projectile_damage_1_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "bullet",
        modifier = 0.2
      },
      {
        type = "turret-attack",
        turret_id = "gun-turret",
        modifier = 0.2
      },
      {
        type = "ammo-damage",
        ammo_category = "shotgun-shell",
        modifier = 0.2
      }
    },
    prerequisites = {"military"},
    unit =
    {
      count = 125*1,
      ingredients =
      {
        {"automation-science-pack", 1}
      },
      time = 30
    },
    upgrade = true,
    order = "e-l-a"
  },
  {
    type = "technology",
    name = "physical-projectile-damage-2",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_damage(physical_projectile_damage_1_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "bullet",
        modifier = 0.2
      },
      {
        type = "turret-attack",
        turret_id = "gun-turret",
        modifier = 0.2
      },
      {
        type = "ammo-damage",
        ammo_category = "shotgun-shell",
        modifier = 0.2
      }
    },
    prerequisites = {"physical-projectile-damage-1"},
    unit =
    {
      count = 125*2,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 30
    },
    upgrade = true,
    order = "e-l-b"
  },
  {
    type = "technology",
    name = "weapon-shooting-speed-1",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_speed(weapon_shooting_speed_1_icon),
    effects =
    {
      {
        type = "gun-speed",
        ammo_category = "bullet",
        modifier = 0.4
      },
      {
        type = "gun-speed",
        ammo_category = "shotgun-shell",
        modifier = 0.4
      }
    },
    prerequisites = {"military"},
    unit =
    {
      count = 100*1,
      ingredients =
      {
        {"automation-science-pack", 1}
      },
      time = 30
    },
    upgrade = true,
    order = "e-j-a"
  },
  {
    type = "technology",
    name = "weapon-shooting-speed-2",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_speed(weapon_shooting_speed_1_icon),
    effects =
    {
      {
        type = "gun-speed",
        ammo_category = "bullet",
        modifier = 0.5
      },
      {
        type = "gun-speed",
        ammo_category = "shotgun-shell",
        modifier = 0.5
      }
    },
    prerequisites = {"weapon-shooting-speed-1"},
    unit =
    {
      count = 100*2,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 30
    },
    upgrade = true,
    order = "e-l-b"
  },
  {
    type = "technology",
    name = "stronger-explosives-1",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_damage(stronger_explosives_1_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "grenade",
        modifier = 0.25
      }
    },
    prerequisites = {"military-2"},
    unit =
    {
      count = 100*1,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 30
    },
    upgrade = true,
    order = "e-j-a"
  },
  {
    type = "technology",
    name = "physical-projectile-damage-3",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_damage(physical_projectile_damage_1_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "bullet",
        modifier = 0.4
      },
      {
        type = "turret-attack",
        turret_id = "gun-turret",
        modifier = 0.4
      },
      {
        type = "ammo-damage",
        ammo_category = "shotgun-shell",
        modifier = 0.4
      }
    },
    prerequisites = {"physical-projectile-damage-2"},
    unit =
    {
      count = 125*3,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-l-c"
  },
  {
    type = "technology",
    name = "physical-projectile-damage-4",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_damage(physical_projectile_damage_1_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "bullet",
        modifier = 0.4
      },
      {
        type = "turret-attack",
        turret_id = "gun-turret",
        modifier = 0.4
      },
      {
        type = "ammo-damage",
        ammo_category = "shotgun-shell",
        modifier = 0.4
      }
    },
    prerequisites = {"physical-projectile-damage-3"},
    unit =
    {
      count = 125*4,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-l-d"
  },
  {
    type = "technology",
    name = "physical-projectile-damage-5",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_damage(physical_projectile_damage_2_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "bullet",
        modifier = 0.4
      },
      {
        type = "turret-attack",
        turret_id = "gun-turret",
        modifier = 0.4
      },
      {
        type = "ammo-damage",
        ammo_category = "shotgun-shell",
        modifier = 0.4
      },
      {
        type = "ammo-damage",
        ammo_category = "cannon-shell",
        modifier = 0.9
      }
    },
    prerequisites = {"physical-projectile-damage-4"},
    unit =
    {
      count = 125*5,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-l-e"
  },
  {
    type = "technology",
    name = "physical-projectile-damage-6",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_damage(physical_projectile_damage_2_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "bullet",
        modifier = 0.8
      },
      {
        type = "turret-attack",
        turret_id = "gun-turret",
        modifier = 0.8
      },
      {
        type = "ammo-damage",
        ammo_category = "shotgun-shell",
        modifier = 0.8
      },
      {
        type = "ammo-damage",
        ammo_category = "cannon-shell",
        modifier = 1.3
      }
    },
    prerequisites = {"physical-projectile-damage-5"},
    unit =
    {
      count = 125*6,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-l-f"
  },
  {
    type = "technology",
    name = "physical-projectile-damage-7",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_damage(physical_projectile_damage_2_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "bullet",
        modifier = 0.8
      },
      {
        type = "turret-attack",
        turret_id = "gun-turret",
        modifier = 0.8
      },
      {
        type = "ammo-damage",
        ammo_category = "shotgun-shell",
        modifier = 0.8
      },
      {
        type = "ammo-damage",
        ammo_category = "cannon-shell",
        modifier = 1
      }
    },
    prerequisites = {"physical-projectile-damage-6", "space-science-pack"},
    unit =
    {
      count_formula = "2^(L-7)*1250",
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1},
        {"space-science-pack", 1}
      },
      time = 60
    },
    max_level = "infinite",
    upgrade = true,
    order = "e-l-f"
  },
  {
    type = "technology",
    name = "stronger-explosives-2",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_damage(stronger_explosives_2_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "grenade",
        modifier = 0.4
      },
      {
        type = "ammo-damage",
        ammo_category = "landmine",
        modifier = 0.4
      }
    },
    prerequisites = {"stronger-explosives-1"},
    unit =
    {
      count = 100*2,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1}
      },
      time = 30
    },
    upgrade = true,
    order = "e-l-b"
  },
  {
    type = "technology",
    name = "stronger-explosives-3",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_damage(stronger_explosives_3_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "rocket",
        modifier = 0.6
      },
      {
        type = "ammo-damage",
        ammo_category = "grenade",
        modifier = 0.4
      },
      {
        type = "ammo-damage",
        ammo_category = "landmine",
        modifier = 0.4
      }
    },
    prerequisites = {"stronger-explosives-2"},
    unit =
    {
      count = 100*3,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
        {"chemical-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-l-c"
  },
  {
    type = "technology",
    name = "stronger-explosives-4",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_damage(stronger_explosives_3_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "rocket",
        modifier = 0.8
      },
      {
        type = "ammo-damage",
        ammo_category = "grenade",
        modifier = 0.4
      },
      {
        type = "ammo-damage",
        ammo_category = "landmine",
        modifier = 0.4
      }
    },
    prerequisites = {"stronger-explosives-3"},
    unit =
    {
      count = 100*4,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
        {"chemical-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-l-d"
  },
  {
    type = "technology",
    name = "stronger-explosives-5",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_damage(stronger_explosives_3_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "rocket",
        modifier = 1
      },
      {
        type = "ammo-damage",
        ammo_category = "grenade",
        modifier = 0.4
      },
      {
        type = "ammo-damage",
        ammo_category = "landmine",
        modifier = 0.4
      }
    },
    prerequisites = {"stronger-explosives-4"},
    unit =
    {
      count = 100*5,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
        {"chemical-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-l-e"
  },
  {
    type = "technology",
    name = "stronger-explosives-6",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_damage(stronger_explosives_3_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "rocket",
        modifier = 1.2
      },
      {
        type = "ammo-damage",
        ammo_category = "grenade",
        modifier = 0.4
      },
      {
        type = "ammo-damage",
        ammo_category = "landmine",
        modifier = 0.4
      }
    },
    prerequisites = {"stronger-explosives-5"},
    unit =
    {
      count = 100*6,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-l-f"
  },
  {
    type = "technology",
    name = "stronger-explosives-7",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_damage(stronger_explosives_3_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "rocket",
        modifier = 1
      },
      {
        type = "ammo-damage",
        ammo_category = "grenade",
        modifier = 0.4
      },
      {
        type = "ammo-damage",
        ammo_category = "landmine",
        modifier = 0.4
      }
    },
    prerequisites = {"stronger-explosives-6", "space-science-pack"},
    unit =
    {
      count_formula = "2^(L-7)*1000",
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1},
        {"space-science-pack", 1}
      },
      time = 60
    },
    max_level = "infinite",
    upgrade = true,
    order = "e-l-f"
  },

})

data:extend(
{
  {
    type = "technology",
    name = "refined-flammables-1",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_damage(refined_flammables_icon),
    effects =
    {
            {
        type = "ammo-damage",
        ammo_category = "flamethrower",
        modifier = 0.4
      },
      {
        type = "turret-attack",
        turret_id = "flamethrower-turret",
        modifier = 0.4
      }
    },
    prerequisites = {"flamethrower"},
    unit =
    {
      count = 100*1,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1}
      },
      time = 30
    },
    upgrade = true,
    order = "e-j-a"
  },
  {
    type = "technology",
    name = "refined-flammables-2",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_damage(refined_flammables_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "flamethrower",
        modifier = 0.4
      },
      {
        type = "turret-attack",
        turret_id = "flamethrower-turret",
        modifier = 0.4
      }
    },
    prerequisites = {"refined-flammables-1"},
    unit =
    {
      count = 100*2,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1}
      },
      time = 30
    },
    upgrade = true,
    order = "e-l-b"
  },
  {
    type = "technology",
    name = "refined-flammables-3",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_damage(refined_flammables_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "flamethrower",
        modifier = 0.4
      },
      {
        type = "turret-attack",
        turret_id = "flamethrower-turret",
        modifier = 0.4
      }
    },
    prerequisites = {"refined-flammables-2"},
    unit =
    {
      count = 100*3,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
        {"chemical-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-l-c"
  },
  {
    type = "technology",
    name = "refined-flammables-4",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_damage(refined_flammables_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "flamethrower",
        modifier = 0.6
      },
      {
        type = "turret-attack",
        turret_id = "flamethrower-turret",
        modifier = 0.6
      }
    },
    prerequisites = {"refined-flammables-3"},
    unit =
    {
      count = 100*4,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
        {"chemical-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-l-d"
  },
  {
    type = "technology",
    name = "refined-flammables-5",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_damage(refined_flammables_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "flamethrower",
        modifier = 0.6
      },
      {
        type = "turret-attack",
        turret_id = "flamethrower-turret",
        modifier = 0.6
      }
    },
    prerequisites = {"refined-flammables-4"},
    unit =
    {
      count = 100*5,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
        {"chemical-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-l-e"
  },
  {
    type = "technology",
    name = "refined-flammables-6",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_damage(refined_flammables_icon),
    effects =
    {
     {
        type = "ammo-damage",
        ammo_category = "flamethrower",
        modifier = 0.8
      },
      {
        type = "turret-attack",
        turret_id = "flamethrower-turret",
        modifier = 0.8
      }
    },
    prerequisites = {"refined-flammables-5"},
    unit =
    {
      count = 100*6,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-l-f"
  },
  {
    type = "technology",
    name = "refined-flammables-7",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_damage(refined_flammables_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "flamethrower",
        modifier = 0.8
      },
      {
        type = "turret-attack",
        turret_id = "flamethrower-turret",
        modifier = 0.8
      }
    },
    prerequisites = {"refined-flammables-6", "space-science-pack"},
    unit =
    {
      count_formula = "2^(L-7)*1000",
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1},
        {"space-science-pack", 1}
      },
      time = 60
    },
    max_level = "infinite",
    upgrade = true,
    order = "e-l-f"
  },

})

data:extend(
{
  {
    type = "technology",
    name = "energy-weapons-damage-1",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_damage(energy_weapons_damage_1_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "laser",
        modifier = 0.4
      }
    },
    prerequisites = {"laser", "military-science-pack"},
    unit =
    {
      count = 100*1,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
        {"chemical-science-pack", 1}
      },
      time = 30
    },
    upgrade = true,
    order = "e-j-a"
  },
  {
    type = "technology",
    name = "energy-weapons-damage-2",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_damage(energy_weapons_damage_1_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "laser",
        modifier = 0.4
      }
    },
    prerequisites = {"energy-weapons-damage-1"},
    unit =
    {
      count = 100*2,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
        {"chemical-science-pack", 1}
      },
      time = 30
    },
    upgrade = true,
    order = "e-l-b"
  },
  {
    type = "technology",
    name = "energy-weapons-damage-3",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_damage(energy_weapons_damage_1_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "laser",
        modifier = 0.6
      }
    },
    prerequisites = {"energy-weapons-damage-2"},
    unit =
    {
      count = 100*3,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
        {"chemical-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-l-c"
  },
  {
    type = "technology",
    name = "energy-weapons-damage-4",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_damage(energy_weapons_damage_2_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "laser",
        modifier = 0.8
      }
    },
    prerequisites = {"energy-weapons-damage-3"},
    unit =
    {
      count = 100*4,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
        {"chemical-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-l-d"
  },
  {
    type = "technology",
    name = "energy-weapons-damage-5",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_damage(energy_weapons_damage_3_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "laser",
        modifier = 1
      },
      {
        type = "ammo-damage",
        ammo_category = "beam",
        modifier = 0.8
      }
    },
    prerequisites = {"energy-weapons-damage-4"},
    unit =
    {
      count = 100*5,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-l-e"
  },
  {
    type = "technology",
    name = "energy-weapons-damage-6",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_damage(energy_weapons_damage_3_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "laser",
        modifier = 1.4
      },
      {
        type = "ammo-damage",
        ammo_category = "electric",
        modifier = 1.4
      },
      {
        type = "ammo-damage",
        ammo_category = "beam",
        modifier = 1.2
      }
    },
    prerequisites = {"energy-weapons-damage-5"},
    unit =
    {
      count = 100*6,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-l-f"
  },
  {
    type = "technology",
    name = "energy-weapons-damage-7",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_damage(energy_weapons_damage_3_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "laser",
        modifier = 1.4
      },
      {
        type = "ammo-damage",
        ammo_category = "electric",
        modifier = 1.4
      },
      {
        type = "ammo-damage",
        ammo_category = "beam",
        modifier = 0.6
      }
    },
    prerequisites = {"energy-weapons-damage-6", "space-science-pack"},
    unit =
    {
      count_formula = "2^(L-7)*1000",
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1},
        {"space-science-pack", 1}
      },
      time = 60
    },
    max_level = "infinite",
    upgrade = true,
    order = "e-l-f"
  }
})

data:extend(
{
  {
    type = "technology",
    name = "weapon-shooting-speed-3",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_speed(weapon_shooting_speed_2_icon),
    effects =
    {
      {
        type = "gun-speed",
        ammo_category = "bullet",
        modifier = 0.6
      },
      {
        type = "gun-speed",
        ammo_category = "shotgun-shell",
        modifier = 0.6
      },
      {
        type = "gun-speed",
        ammo_category = "rocket",
        modifier = 0.6
      }
    },
    prerequisites = {"weapon-shooting-speed-2"},
    unit =
    {
      count = 100*3,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-l-c"
  },
  {
    type = "technology",
    name = "weapon-shooting-speed-4",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_speed(weapon_shooting_speed_2_icon),
    effects =
    {
      {
        type = "gun-speed",
        ammo_category = "bullet",
        modifier = 0.8
      },
      {
        type = "gun-speed",
        ammo_category = "shotgun-shell",
        modifier = 0.8
      },
      {
        type = "gun-speed",
        ammo_category = "rocket",
        modifier = 1.5
      }
    },
    prerequisites = {"weapon-shooting-speed-3"},
    unit =
    {
      count = 100*4,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-l-d"
  },
  {
    type = "technology",
    name = "weapon-shooting-speed-5",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_speed(weapon_shooting_speed_3_icon),
    effects =
    {
      {
        type = "gun-speed",
        ammo_category = "bullet",
        modifier = 0.8
      },
      {
        type = "gun-speed",
        ammo_category = "shotgun-shell",
        modifier = 1.0
      },
      {
        type = "gun-speed",
        ammo_category = "cannon-shell",
        modifier = 1.7
      },
      {
        type = "gun-speed",
        ammo_category = "rocket",
        modifier = 1.9
      }
    },
    prerequisites = {"weapon-shooting-speed-4"},
    unit =
    {
      count = 100*5,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-l-e"
  },
  {
    type = "technology",
    name = "weapon-shooting-speed-6",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_speed(weapon_shooting_speed_3_icon),
    effects =
    {
      {
        type = "gun-speed",
        ammo_category = "bullet",
        modifier = 0.8
      },
      {
        type = "gun-speed",
        ammo_category = "shotgun-shell",
        modifier = 0.9
      },
      {
        type = "gun-speed",
        ammo_category = "cannon-shell",
        modifier = 3.1
      },
      {
        type = "gun-speed",
        ammo_category = "rocket",
        modifier = 2.7
      }
    },
    prerequisites = {"weapon-shooting-speed-5"},
    unit =
    {
      count = 100*6,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-l-f"
  },

})

data:extend(
{
  {
    type = "technology",
    name = "laser-shooting-speed-1",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_speed(laser_shooting_speed_icon),
    effects =
    {
      {
        type = "gun-speed",
        ammo_category = "laser",
        modifier = 0.3
      }
    },
    prerequisites = {"laser", "military-science-pack"},
    unit =
    {
      count = 50,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
        {"chemical-science-pack", 1}
      },
      time = 30
    },
    upgrade = true,
    order = "e-n-h"
  },
  {
    type = "technology",
    name = "laser-shooting-speed-2",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_speed(laser_shooting_speed_icon),
    effects =
    {
      {
        type = "gun-speed",
        ammo_category = "laser",
        modifier = 0.5
      }
    },
    prerequisites = {"laser-shooting-speed-1"},
    unit =
    {
      count = 100,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
        {"chemical-science-pack", 1}
      },
      time = 30
    },
    upgrade = true,
    order = "e-n-i"
  },
  {
    type = "technology",
    name = "laser-shooting-speed-3",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_speed(laser_shooting_speed_icon),
    effects =
    {
      {
        type = "gun-speed",
        ammo_category = "laser",
        modifier = 0.7
      }
    },
    prerequisites = {"laser-shooting-speed-2"},
    unit =
    {
      count = 200,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-n-j"
  },
  {
    type = "technology",
    name = "laser-shooting-speed-4",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_speed(laser_shooting_speed_icon),
    effects =
    {
      {
        type = "gun-speed",
        ammo_category = "laser",
        modifier = 0.7
      }
    },
    prerequisites = {"laser-shooting-speed-3"},
    unit =
    {
      count = 200,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-n-k"
  },
  {
    type = "technology",
    name = "laser-shooting-speed-5",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_speed(laser_shooting_speed_icon),
    effects =
    {
      {
        type = "gun-speed",
        ammo_category = "laser",
        modifier = 0.9
      }
    },
    prerequisites = {"laser-shooting-speed-4"},
    unit =
    {
      count = 200,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-n-l"
  },
  {
    type = "technology",
    name = "laser-shooting-speed-6",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_speed(laser_shooting_speed_icon),
    effects =
    {
      {
        type = "gun-speed",
        ammo_category = "laser",
        modifier = 0.9
      }
    },
    prerequisites = {"laser-shooting-speed-5"},
    unit =
    {
      count = 350,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-n-m"
  },
  {
    type = "technology",
    name = "laser-shooting-speed-7",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_speed(laser_shooting_speed_icon),
    effects =
    {
      {
        type = "gun-speed",
        ammo_category = "laser",
        modifier = 1.1
      }
    },
    prerequisites = {"laser-shooting-speed-6"},
    unit =
    {
      count = 450,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-n-n"
  }
})

data:extend(
{
  {
    type = "technology",
    name = "mining-productivity-1",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_productivity("__base__/graphics/technology/mining-productivity.png"),
    effects =
    {
      {
        type = "mining-drill-productivity-bonus",
        modifier = 0.3
      }
    },
    prerequisites = {"automation-2"},
    unit =
    {
      count = 250,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "c-k-f-e"
  },
  {
    type = "technology",
    name = "mining-productivity-2",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_productivity("__base__/graphics/technology/mining-productivity.png"),
    effects =
    {
      {
        type = "mining-drill-productivity-bonus",
        modifier = 0.3
      }
    },
    prerequisites = {"mining-productivity-1"},
    unit =
    {
      count = 500,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "c-k-f-e"
  },
  {
    type = "technology",
    name = "mining-productivity-3",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_productivity("__base__/graphics/technology/mining-productivity.png"),
    effects =
    {
      {
        type = "mining-drill-productivity-bonus",
        modifier = 0.3
      }
    },
    prerequisites = {"mining-productivity-2"},
    unit =
    {
      count = 1000,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "c-k-f-e"
  },
  {
    type = "technology",
    name = "mining-productivity-4",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_productivity("__base__/graphics/technology/mining-productivity.png"),
    effects =
    {
      {
        type = "mining-drill-productivity-bonus",
        modifier = 0.3
      }
    },
    prerequisites = {"mining-productivity-3", "space-science-pack"},
    unit =
    {
      count_formula = "2500*(L - 3)",
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
        {"space-science-pack", 1}
      },
      time = 60
    },
    max_level = "infinite",
    upgrade = true,
    order = "c-k-f-e"
  }
})

data:extend(
{
	{
    type = "technology",
    name = "toolbelt",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_capacity("__base__/graphics/technology/toolbelt.png"),
    prerequisites = {"logistic-science-pack"},
    effects =
    {
      {
        type = "character-inventory-slots-bonus",
        modifier = 40
      },
      {
        type = "character-crafting-speed",
        modifier = 0.4
      }
    },
    unit =
    {
      count = 100,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 30
    }
	},
	{
    type = "technology",
    name = "steel-axe",
    icon_size = 256, icon_mipmaps = 4,
    icon = "__base__/graphics/technology/steel-axe.png",
    effects =
    {
      {
        type = "character-mining-speed",
        modifier = 2
      },
      {
        type = "character-crafting-speed",
        modifier = 0.2
      }
    },
    prerequisites = {"steel-processing"},
    unit =
    {
      count = 50,
      ingredients =
      {
        {"automation-science-pack", 1}
      },
      time = 30
    },
    order = "c-c-a"
  },
	{
    type = "technology",
    name = "worker-robots-speed-1",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_movement_speed("__base__/graphics/technology/worker-robots-speed.png"),
    effects =
    {
      {
        type = "worker-robot-speed",
        modifier = 0.7
      }
    },
    prerequisites = {"robotics"},
    unit =
    {
      count = 50,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1}
      },
      time = 30
    },
    upgrade = true,
    order = "c-k-f-a"
  },
  {
    type = "technology",
    name = "worker-robots-speed-2",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_movement_speed("__base__/graphics/technology/worker-robots-speed.png"),
    effects =
    {
      {
        type = "worker-robot-speed",
        modifier = 0.8
      }
    },
    prerequisites = {"worker-robots-speed-1"},
    unit =
    {
      count = 100,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1}
      },
      time = 30
    },
    upgrade = true,
    order = "c-k-f-b"
  },
  {
    type = "technology",
    name = "worker-robots-speed-3",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_movement_speed("__base__/graphics/technology/worker-robots-speed.png"),
    effects =
    {
      {
        type = "worker-robot-speed",
        modifier = 0.9
      }
    },
    prerequisites = {"worker-robots-speed-2"},
    unit =
    {
      count = 150,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "c-k-f-c"
  },
  {
    type = "technology",
    name = "worker-robots-speed-4",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_movement_speed("__base__/graphics/technology/worker-robots-speed.png"),
    effects =
    {
      {
        type = "worker-robot-speed",
        modifier = 1.1
      }
    },
    prerequisites = {"worker-robots-speed-3"},
    unit =
    {
      count = 250,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "c-k-f-d"
  },
  {
    type = "technology",
    name = "worker-robots-speed-5",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_movement_speed("__base__/graphics/technology/worker-robots-speed.png"),
    effects =
    {
      {
        type = "worker-robot-speed",
        modifier = 1.3
      }
    },
    prerequisites = {"worker-robots-speed-4"},
    unit =
    {
      count = 500,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "c-k-f-e"
  },
  {
    type = "technology",
    name = "worker-robots-speed-6",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_movement_speed("__base__/graphics/technology/worker-robots-speed.png"),
    effects =
    {
      {
        type = "worker-robot-speed",
        modifier = 1.3
      }
    },
    prerequisites = {"worker-robots-speed-5", "space-science-pack"},
    unit =
    {
      count_formula = "2^(L-6)*1000",
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
        {"space-science-pack", 1}
      },
      time = 60
    },
    max_level = "infinite",
    upgrade = true,
    order = "c-k-f-e"
  }
})

data:extend(
{
  {
    type = "technology",
    name = "research-speed-1",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_speed("__base__/graphics/technology/research-speed.png"),
    effects =
    {
      {
        type = "laboratory-speed",
        modifier = 0.4
      }
    },
    prerequisites = {"automation-2"},
    unit =
    {
      count = 100,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 30
    },
    upgrade = true,
    order = "c-m-a"
  },
  {
    type = "technology",
    name = "research-speed-2",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_speed("__base__/graphics/technology/research-speed.png"),
    effects =
    {
      {
        type = "laboratory-speed",
        modifier = 0.6
      }
    },
    prerequisites = {"research-speed-1"},
    unit =
    {
      count = 200,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 30
    },
    upgrade = true,
    order = "c-m-b"
  },
  {
    type = "technology",
    name = "research-speed-3",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_speed("__base__/graphics/technology/research-speed.png"),
    effects =
    {
      {
        type = "laboratory-speed",
        modifier = 0.8
      }
    },
    prerequisites = {"research-speed-2"},
    unit =
    {
      count = 250,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1}
      },
      time = 30
    },
    upgrade = true,
    order = "c-m-c"
  },
  {
    type = "technology",
    name = "research-speed-4",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_speed("__base__/graphics/technology/research-speed.png"),
    effects =
    {
      {
        type = "laboratory-speed",
        modifier = 1
      }
    },
    prerequisites = {"research-speed-3"},
    unit =
    {
      count = 500,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1}
      },
      time = 30
    },
    upgrade = true,
    order = "c-m-d"
  },
  {
    type = "technology",
    name = "research-speed-5",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_speed("__base__/graphics/technology/research-speed.png"),
    effects =
    {
      {
        type = "laboratory-speed",
        modifier = 1
      }
    },
    prerequisites = {"research-speed-4"},
    unit =
    {
      count = 500,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1}
      },
      time = 30
    },
    upgrade = true,
    order = "c-m-d"
  },
  {
    type = "technology",
    name = "research-speed-6",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_speed("__base__/graphics/technology/research-speed.png"),
    effects =
    {
      {
        type = "laboratory-speed",
        modifier = 1.2
      }
    },
    prerequisites = {"research-speed-5"},
    unit =
    {
      count = 500,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 30
    },
    upgrade = true,
    order = "c-m-d"
  }
})