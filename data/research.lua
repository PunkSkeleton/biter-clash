data:extend({
		{
	    type = "technology",
	    name = "adrenaline",
	    mod = "BiterWars",
	    icon_size = 256,
	    icon_mipmaps = 1,
	    icons = {
	      {
	        icon = "__biter-clash__/graphics/biter-upgrade.png",
	        icon_size = 256,
	        icon_mipmaps = 1,
	      }
	    },
	    effects = {
	      {
	        type = "nothing",
	        effect_description = "adrenaline"
	      },
	    },
	    prerequisites = {"logistic-science-pack", "small-biter"},
	    unit = {
	      count = 100,
	      ingredients = {
	        { "automation-science-pack", 1 },
	        { "logistic-science-pack", 1 },
	      },
	      time = 30,
	    },
	    order = "b-c-a",
	  },
	  {
	    type = "technology",
	    name = "alcohol",
	    mod = "BiterWars",
	    icon_size = 256,
	    icon_mipmaps = 1,
	    icons = {
	      {
	        icon = "__biter-clash__/graphics/spitter-upgrade.png",
	        icon_size = 256,
	        icon_mipmaps = 1,
	      }
	    },
	    effects = {
	      {
	        type = "nothing",
	        effect_description = "alcohol"
	      },
	    },
	    prerequisites = {"logistic-science-pack", "small-spitter"},
	    unit = {
	      count = 100,
	      ingredients = {
	        { "automation-science-pack", 1 },
	        { "logistic-science-pack", 1 },
	      },
	      time = 30,
	    },
	    order = "b-c-a",
	  },
	  {
	    type = "technology",
	    name = "resistance",
	    mod = "BiterWars",
	    icon_size = 256,
	    icon_mipmaps = 1,
	    icons = {
	      {
	        icon = "__biter-clash__/graphics/biter-upgrade.png",
	        icon_size = 256,
	        icon_mipmaps = 1,
	        tint = {r=1.0, g=0.7, b=0.7, a=1.0}
	      },
	    },
	    effects = {
	      {
	        type = "nothing",
	        effect_description = "resistance"
	      },
	    },
	    prerequisites = {"military-science-pack", "medium-biter"},
	    unit = {
	      count = 100,
	      ingredients = {
	        { "automation-science-pack", 1 },
	        { "logistic-science-pack", 1 },
	        { "military-science-pack", 1 },
	      },
	      time = 30,
	    },
	    order = "b-c-a",
	  },
	  {
	    type = "technology",
	    name = "heavy-spit",
	    mod = "BiterWars",
	    icon_size = 256,
	    icon_mipmaps = 1,
	    icons = {
	      {
	        icon = "__biter-clash__/graphics/spitter-upgrade.png",
	        icon_size = 256,
	        icon_mipmaps = 1,
	        tint = {r=1.0, g=0.7, b=0.7, a=1.0}
	      },
	    },
	    effects = {
	      {
	        type = "nothing",
	        effect_description = "heavy-spit"
	      },
	    },
	    prerequisites = {"military-science-pack", "medium-spitter"},
	    unit = {
	      count = 100,
	      ingredients = {
	        { "automation-science-pack", 1 },
	        { "logistic-science-pack", 1 },
	        { "military-science-pack", 1 },
	      },
	      time = 30,
	    },
	    order = "b-c-a",
	  },
	  {
	    type = "technology",
	    name = "sharp-teeth",
	    mod = "BiterWars",
	    icon_size = 256,
	    icon_mipmaps = 1,
	    icons = {
	      {
	        icon = "__biter-clash__/graphics/biter-upgrade.png",
	        icon_size = 256,
	        icon_mipmaps = 1,
	        tint = {r=0.13, g=0.56, b=0.66, a=1.0}
	      }
	    },
	    effects = {
	      {
	        type = "nothing",
	        effect_description = "sharp-teeth"
	      },
	    },
	    prerequisites = {"chemical-science-pack", "big-biter"},
	    unit = {
	      count = 100,
	      ingredients = {
	        { "automation-science-pack", 1 },
	        { "logistic-science-pack", 1 },
	        { "military-science-pack", 1 },
	        { "chemical-science-pack", 1 },
	      },
	      time = 30,
	    },
	    order = "b-c-a",
	  },
	  {
	    type = "technology",
	    name = "artillery-spitter",
	    mod = "BiterWars",
	    icon_size = 256,
	    icon_mipmaps = 1,
	    icons = {
	      {
	        icon = "__biter-clash__/graphics/spitter-upgrade.png",
	        icon_size = 256,
	        icon_mipmaps = 1,
	        tint = {r=0.13, g=0.56, b=0.66, a=1.0}
	      }
	    },
	    effects = {
	      {
	        type = "nothing",
	        effect_description = "artillery-spitter"
	      },
	    },
	    prerequisites = {"chemical-science-pack", "big-spitter"},
	    unit = {
	      count = 100,
	      ingredients = {
	        { "automation-science-pack", 1 },
	        { "logistic-science-pack", 1 },
	        { "military-science-pack", 1 },
	        { "chemical-science-pack", 1 },
	      },
	      time = 30,
	    },
	    order = "b-c-a",
	  },
	  {
	    type = "technology",
	    name = "rapid-regeneration",
	    mod = "BiterWars",
	    icon_size = 256,
	    icon_mipmaps = 1,
	    icons = {
	      {
	        icon = "__biter-clash__/graphics/biter-upgrade.png",
	        icon_size = 256,
	        icon_mipmaps = 1,
	        tint = {r=0.3, g=1.0, b=0.1, a=1.0}
	      }
	    },
	    effects = {
	      {
	        type = "nothing",
	        effect_description = "rapid-regeneration"
	      },
	    },
	    prerequisites = {"production-science-pack", "behemoth-biter"},
	    unit = {
	      count = 100,
	      ingredients = {
	        { "automation-science-pack", 1 },
	        { "logistic-science-pack", 1 },
	        { "military-science-pack", 1 },
	        { "chemical-science-pack", 1 },
	        { "production-science-pack", 1 },
	      },
	      time = 30,
	    },
	    order = "b-c-a",
	  },
	  {
	    type = "technology",
	    name = "aoe-spitter",
	    mod = "BiterWars",
	    icon_size = 256,
	    icon_mipmaps = 1,
	    icons = {
	      {
	        icon = "__biter-clash__/graphics/spitter-upgrade.png",
	        icon_size = 256,
	        icon_mipmaps = 1,
	        tint = {r=0.3, g=1.0, b=0.1, a=1.0}
	      }
	    },
	    effects = {
	      {
	        type = "nothing",
	        effect_description = "aoe-spitter"
	      },
	    },
	    prerequisites = {"production-science-pack", "behemoth-spitter"},
	    unit = {
	      count = 100,
	      ingredients = {
	        { "automation-science-pack", 1 },
	        { "logistic-science-pack", 1 },
	        { "military-science-pack", 1 },
	        { "chemical-science-pack", 1 },
	        { "production-science-pack", 1 },
	      },
	      time = 30,
	    },
	    order = "b-c-a",
	  },
	  {
	    type = "technology",
	    name = "small-biter",
	    mod = "BiterWars",
	    icon_size = 256,
	    icon_mipmaps = 1,
	    icons = {
	      {
	        icon = "__biter-clash__/graphics/biter.png",
	        icon_size = 256,
	        icon_mipmaps = 1,
	      },
	    },
	    effects = {
	      {
	        type = "unlock-recipe",
	        recipe = "small-biter-nest",
	      },
	    },
	    prerequisites = {},
	    unit = {
	      count = 100,
	      ingredients = {
	        { "automation-science-pack", 1 },
	      },
	      time = 30,
	    },
	    order = "b-c-a",
	  },
	  {
	    type = "technology",
	    name = "medium-biter",
	    mod = "BiterWars",
	    icon_size = 256,
	    icon_mipmaps = 1,
	    icons = {
	      {
	        icon = "__biter-clash__/graphics/biter.png",
	        icon_size = 256,
	        icon_mipmaps = 1,
	        tint = {r=1.0, g=0.7, b=0.7, a=1.0}
	      },
	    },
	    effects = {
	      {
	        type = "unlock-recipe",
	        recipe = "medium-biter-nest",
	      },
	    },
	    prerequisites = {"small-biter", "logistic-science-pack", "steel-processing"},
	    unit = {
	      count = 100,
	      ingredients = {
	        { "automation-science-pack", 1 },
	        { "logistic-science-pack", 1 },
	      },
	      time = 30,
	    },
	    order = "b-c-a",
	  },
	  {
	    type = "technology",
	    name = "big-biter",
	    mod = "BiterWars",
	    icon_size = 256,
	    icon_mipmaps = 1,
	    icons = {
	      {
	        icon = "__biter-clash__/graphics/biter.png",
	        icon_size = 256,
	        icon_mipmaps = 1,
	        tint = {r=0.13, g=0.56, b=0.66, a=1.0}
	      }
	    },
	    effects = {
	      {
	        type = "unlock-recipe",
	        recipe = "big-biter-nest",
	      },
	    },
	    prerequisites = {"medium-biter", "military-science-pack", "plastics", "engine"},
	    unit = {
	      count = 100,
	      ingredients = {
	        { "automation-science-pack", 1 },
	        { "logistic-science-pack", 1 },
	        { "military-science-pack", 1 },
	      },
	      time = 30,
	    },
	    order = "b-c-a",
	  },
	  {
	    type = "technology",
	    name = "behemoth-biter",
	    mod = "BiterWars",
	    icon_size = 256,
	    icon_mipmaps = 1,
	    icons = {
	      {
	        icon = "__biter-clash__/graphics/biter.png",
	        icon_size = 256,
	        icon_mipmaps = 1,
	        tint = {r=0.3, g=1.0, b=0.1, a=1.0}
	      },
	    },
	    effects = {
	      {
	        type = "unlock-recipe",
	        recipe = "behemoth-biter-nest",
	      },
	    },
	    prerequisites = {"big-biter", "military-science-pack", "chemical-science-pack", "advanced-circuit", "robotics"},
	    unit = {
	      count = 100,
	      ingredients = {
	        { "automation-science-pack", 1 },
	        { "logistic-science-pack", 1 },
	        { "military-science-pack", 1 },
	        { "chemical-science-pack", 1 },
	      },
	      time = 30,
	    },
	    order = "b-c-a",
	  },
	  {
	    type = "technology",
	    name = "small-spitter",
	    mod = "BiterWars",
	    icon_size = 256,
	    icon_mipmaps = 1,
	    icons = {
	      {
	        icon = "__biter-clash__/graphics/spitter.png",
	        icon_size = 256,
	        icon_mipmaps = 1,
	      }
	    },
	    effects = {
	      {
	        type = "unlock-recipe",
	        recipe = "small-spitter-nest",
	      },
	    },
	    prerequisites = {},
	    unit = {
	      count = 100,
	      ingredients = {
	        { "automation-science-pack", 1 },
	      },
	      time = 30,
	    },
	    order = "b-c-a",
	  },
	  {
	    type = "technology",
	    name = "medium-spitter",
	    mod = "BiterWars",
	    icon_size = 256,
	    icon_mipmaps = 1,
	    icons = {
	      {
	        icon = "__biter-clash__/graphics/spitter.png",
	        icon_size = 256,
	        icon_mipmaps = 1,
	        tint = {r=1.0, g=0.7, b=0.7, a=1.0}
	      },
	    },
	    effects = {
	      {
	        type = "unlock-recipe",
	        recipe = "medium-spitter-nest",
	      },
	    },
	    prerequisites = {"small-spitter", "logistic-science-pack", "steel-processing"},
	    unit = {
	      count = 100,
	      ingredients = {
	        { "automation-science-pack", 1 },
	        { "logistic-science-pack", 1 },
	      },
	      time = 30,
	    },
	    order = "b-c-a",
	  },
	  {
	    type = "technology",
	    name = "big-spitter",
	    mod = "BiterWars",
	    icon_size = 256,
	    icon_mipmaps = 1,
	    icons = {
	      {
	        icon = "__biter-clash__/graphics/spitter.png",
	        icon_size = 256,
	        icon_mipmaps = 1,
	        tint = {r=0.13, g=0.56, b=0.66, a=1.0}
	      }
	    },
	    effects = {
	      {
	        type = "unlock-recipe",
	        recipe = "big-spitter-nest",
	      },
	    },
	    prerequisites = {"medium-spitter", "military-science-pack", "plastics", "engine"},
	    unit = {
	      count = 100,
	      ingredients = {
	        { "automation-science-pack", 1 },
	        { "logistic-science-pack", 1 },
	        { "military-science-pack", 1 },
	      },
	      time = 30,
	    },
	    order = "b-c-a",
	  },
	  {
	    type = "technology",
	    name = "behemoth-spitter",
	    mod = "BiterWars",
	    icon_size = 256,
	    icon_mipmaps = 1,
	    icons = {
	      {
	        icon = "__biter-clash__/graphics/spitter.png",
	        icon_size = 256,
	        icon_mipmaps = 1,
	        tint = {r=0.3, g=1.0, b=0.1, a=1.0}
	      }
	    },
	    effects = {
	      {
	        type = "unlock-recipe",
	        recipe = "behemoth-spitter-nest",
	      },
	    },
	    prerequisites = {"big-spitter", "military-science-pack", "chemical-science-pack", "advanced-circuit", "robotics"},
	    unit = {
	      count = 100,
	      ingredients = {
	        { "automation-science-pack", 1 },
	        { "logistic-science-pack", 1 },
	        { "military-science-pack", 1 },
	        { "chemical-science-pack", 1 },
	      },
	      time = 30,
	    },
	    order = "b-c-a",
	  },
	  {
	    type = "technology",
	    name = "laser",
	    icon = "__base__/graphics/technology/laser.png",
	    icon_size = 256,
	    prerequisites = {"battery", "chemical-science-pack"},
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
	    }
  	},
  	{
	    type = "technology",
	    name = "laser-turret",
	    icon = "__base__/graphics/technology/laser-turret.png",
	    icon_size = 256,
	    effects =
	    {
	      {
	        type = "unlock-recipe",
	        recipe = "laser-turret"
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
	    }
	 },
	 {
	    type = "technology",
	    name = "heavy-armor",
	    icon = "__base__/graphics/technology/heavy-armor.png",
	    icon_size = 256,
	    effects =
	    {
	      {
	        type = "unlock-recipe",
	        recipe = "heavy-armor"
	      }
	    },
	    prerequisites = {"military", "steel-processing"},
	    unit =
	    {
	      count = 50,
	      ingredients = {{"automation-science-pack", 1}},
	      time = 30
	    }
	  },
	  {
	    type = "technology",
	    name = "plastics",
	    icon = "__base__/graphics/technology/plastics.png",
	    icon_size = 256,
	    prerequisites = {"oil-gathering"},
	    effects =
	    {
	      {
	        type = "unlock-recipe",
	        recipe = "plastic-bar"
	      }
	    },
	    unit =
	    {
	      count = 200,
	      ingredients = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}},
	      time = 30
	    }
	  },
	  {
	    type = "technology",
	    name = "sulfur-processing",
	    icon = "__base__/graphics/technology/sulfur-processing.png",
	    icon_size = 256,
	    prerequisites = {"oil-gathering"},
	    effects =
	    {
	      {
	        type = "unlock-recipe",
	        recipe = "sulfuric-acid"
	      },
	      {
	        type = "unlock-recipe",
	        recipe = "sulfur"
	      }
	    },
	    unit =
	    {
	      count = 150,
	      ingredients = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}},
	      time = 30
	    }
	  },
	  {
	    type = "technology",
	    name = "flammables",
	    icon = "__base__/graphics/technology/flammables.png",
	    icon_size = 256,
	    prerequisites = {"oil-gathering"},
	    unit =
	    {
	      count = 50,
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
	    name = "oil-gathering",
	    icon = "__base__/graphics/technology/oil-gathering.png",
	    icon_size = 256,
	    prerequisites = {"fluid-handling"},
	    effects =
	    {
	      {
	        type = "unlock-recipe",
	        recipe = "pumpjack"
	      },
	      {
	        type = "unlock-recipe",
	        recipe = "oil-refinery"
	      },
	      {
	        type = "unlock-recipe",
	        recipe = "chemical-plant"
	      },
	      {
	        type = "unlock-recipe",
	        recipe = "basic-oil-processing"
	      },
	      {
	        type = "unlock-recipe",
	        recipe = "solid-fuel-from-petroleum-gas"
	      }
	    },
	    unit =
	    {
	      count = 100,
	      ingredients = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}},
	      time = 30
	    }
	  },
	  {
	    type = "technology",
	    name = "oil-processing",
	    icon = "__base__/graphics/technology/oil-processing.png",
	    icon_size = 256,
	    prerequisites = {"oil-gathering"},
	    effects =
	    {
	    },
	    research_trigger =
	    {
	      type = "mine-entity",
	      entity = "crude-oil"
	    }
	  }
  }   
)