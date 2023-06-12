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
	        modifier = 0.50,
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
	        modifier = 0.50,
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
	        modifier = 0.50,
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
	        modifier = 0.50,
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
	        modifier = 0.50,
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
	        modifier = 0.50,
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
	        modifier = 0.50,
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
	        modifier = 0.50,
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
	    prerequisites = {"big-biter", "military-science-pack", "chemical-science-pack", "advanced-electronics", "robotics"},
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
	    prerequisites = {"big-spitter", "military-science-pack", "chemical-science-pack", "advanced-electronics", "robotics"},
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
	  }
  }
)