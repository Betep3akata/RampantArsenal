local vehicles = {}

local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")
local vehicleUtils = require("utils/VehicleUtils")
local gridUtils = require("utils/GridUtils")
local itemUtils = require("utils/ItemUtils")
local gunUtils = require("utils/GunUtils")
local equipmentUtils = require("utils/EquipmentUtils")

local addCategory = equipmentUtils.addCategory
local makeGun = gunUtils.makeGun
local addFuelToItem = itemUtils.addFuelToItem
local modifyItem = itemUtils.modifyItem
local makeGrid = gridUtils.makeGrid
local addEquipmentGrid = vehicleUtils.addEquipmentGrid
local makeRecipe = recipeUtils.makeRecipe
local addEffectToTech = technologyUtils.addEffectToTech
local makeTank = vehicleUtils.makeTank
local makeCar = vehicleUtils.makeCar
local makeTrain = vehicleUtils.makeTrain

function vehicles.enable()

    local advancedTankMachineGun = makeGun(
	{
	    name = "advanced-tank-machine-gun",
	    icon = "__RampantArsenal__/graphics/icons/minigun.png",
	    flags = {"goes-to-main-inventory", "hidden"},
	    order = "e[mortar]-b"
	},
	{
	    type = "projectile",
	    ammo_category = "bullet",
	    cooldown = 3,
	    movement_slow_down_factor = 0.7,
	    damage_modifier = 2.5,
	    shell_particle =
		{
		    name = "shell-particle",
		    direction_deviation = 0.1,
		    speed = 0.1,
		    speed_deviation = 0.03,
		    center = {0, 0},
		    creation_distance = -0.6875,
		    starting_frame_speed = 0.4,
		    starting_frame_speed_deviation = 0.1
		},
	    projectile_center = {-0.15625, -0.07812},
	    projectile_creation_distance = 2,
	    range = 22,
	    sound = make_heavy_gunshot_sounds()
    })

    local advancedTankCannon = makeGun(
	{
	    name = "advanced-tank-cannon",
	    icon = "__base__/graphics/icons/tank-cannon.png",
	    flags = {"goes-to-main-inventory", "hidden"},
	    order = "e[mortar]-b"
	},
	{
	    type = "projectile",
	    ammo_category = "cannon-shell",
	    cooldown = 90,
	    damage_modifier = 1.5,
	    movement_slow_down_factor = 0,
	    projectile_creation_distance = 2,
	    projectile_center = {-0.15625, -0.07812},
	    range = 27,
	    sound =
		{
		    {
			filename = "__base__/sound/fight/tank-cannon.ogg",
			volume = 1.0
		    }
		}
    })

    local advancedTankFlamethrower = makeGun(
	{
	    name = "advanced-tank-flamethrower",
	    icon = "__base__/graphics/icons/flamethrower.png",
	    flags = {"goes-to-main-inventory", "hidden"},
	    order = "e[mortar]-b"
	},
	{
	    type = "stream",
	    ammo_category = "flamethrower",
	    cooldown = 1,
	    projectile_creation_distance = 1,
	    gun_barrel_length = 1.4,
	    damage_modifier = 1.5,
	    gun_center_shift = { -0.17, -1.15 },
	    range = 12,
	    min_range = 3,
	    cyclic_sound =
		{
		    begin_sound =
			{
			    {
				filename = "__base__/sound/fight/flamethrower-start.ogg",
				volume = 1
			    }
			},
		    middle_sound =
			{
			    {
				filename = "__base__/sound/fight/flamethrower-mid.ogg",
				volume = 1
			    }
			},
		    end_sound =
			{
			    {
				filename = "__base__/sound/fight/flamethrower-end.ogg",
				volume = 1
			    }
			}
		}
    })

    local advancedTankLauncher = makeGun(
	{
	    name = "advanced-tank-launcher",
	    icon = "__RampantArsenal__/graphics/icons/mortar.png",
	    flags = {"goes-to-main-inventory", "hidden"},
	    order = "e[mortar]-b"
	},
	{
	    type = "stream",
	    ammo_category = "capsule-launcher",
	    cooldown = 350,
	    movement_slow_down_factor = 0.9,
	    damage_modifier = 2.5,
	    gun_center_shift = {
		north = {0, 0},
		east = {0, 0},
		south = {0, 0},
		west = {0, 0}
	    },
	    gun_barrel_length = 1,
	    range = 31,
	    sound = make_heavy_gunshot_sounds()
    })

    local advTankGrid = makeGrid({
	    name = "advanced-tank",
	    width = 15,
	    height = 15
    })

    local nuclearTankGrid = makeGrid({
	    name = "nuclear-tank",
	    width = 18,
	    height = 18
    })
    
    local advTank = makeTank({
	    name = "advanced",
	    scale = 0.8,
	    order = "b[personal-transport]-b[zatank]",
	    icon = "__RampantArsenal__/graphics/icons/advanced-tank.png",
	    health = 3500,
	    consumption = "2.0MW",
	    weight = 30000,
	    inventorySize = 100,
	    collisionBox = {{-1.7, -2.7}, {1.4, 2}},
	    selectionBox = {{-1.7, -2.7}, {1.4, 2}},
	    drawingBox = {{-3.4, -3.4}, {3.4, 2.8}},
	    brakingPower = "1MW",
	    equipmentGrid = advTankGrid,
	    immuneToTrees = true,
	    weapons = { advancedTankMachineGun, advancedTankCannon, advancedTankFlamethrower, advancedTankLauncher},
	    tint = { r = 0.45, g = 0, b = 0, a = 1 },
	    energySource = {
		fuel_category = "chemical",
		effectivity = 0.85,
		emissions = 0.02,
		fuel_inventory_size = 2,
		smoke =
		    {
			{
			    name = "tank-smoke",
			    deviation = {0.25, 0.25},
			    frequency = 50,
			    position = {0, 1.5},
			    starting_frame = 0,
			    starting_frame_deviation = 60
			}
		    }
	    },
	    resistances = {
		{
		    type = "fire",
		    decrease = 20,
		    percent = 60
		},
		{
		    type = "electric",
		    decrease = 10,
		    percent = 50
		},
		{
		    type = "physical",
		    decrease = 25,
		    percent = 70
		},
		{
		    type = "impact",
		    decrease = 50,
		    percent = 80
		},
		{
		    type = "explosion",
		    decrease = 25,
		    percent = 70
		},
		{
		    type = "acid",
		    decrease = 30,
		    percent = 65
		}
	    }
    })

    local nuclearTankMachineGun = makeGun(
	{
	    name = "nuclear-tank-machine-gun",
	    icon = "__RampantArsenal__/graphics/icons/minigun.png",
	    flags = {"goes-to-main-inventory", "hidden"},
	    order = "e[mortar]-b"
	},
	{
	    type = "projectile",
	    ammo_category = "bullet",
	    cooldown = 2.5,
	    movement_slow_down_factor = 0.7,
	    damage_modifier = 3,
	    shell_particle =
		{
		    name = "shell-particle",
		    direction_deviation = 0.1,
		    speed = 0.1,
		    speed_deviation = 0.03,
		    center = {0, 0},
		    creation_distance = -0.6875,
		    starting_frame_speed = 0.4,
		    starting_frame_speed_deviation = 0.1
		},
	    projectile_center = {-0.15625, -0.07812},
	    projectile_creation_distance = 2.5,
	    range = 24,
	    sound = make_heavy_gunshot_sounds()
    })

    local nuclearTankCannon = makeGun(
	{
	    name = "nuclear-tank-cannon",
	    icon = "__base__/graphics/icons/tank-cannon.png",
	    flags = {"goes-to-main-inventory", "hidden"},
	    order = "e[mortar]-b"
	},
	{
	    type = "projectile",
	    ammo_category = "cannon-shell",
	    cooldown = 90,
	    damage_modifier = 2,
	    movement_slow_down_factor = 0,
	    projectile_creation_distance = 2,
	    projectile_center = {-0.15625, -0.07812},
	    range = 30,
	    sound =
		{
		    {
			filename = "__base__/sound/fight/tank-cannon.ogg",
			volume = 1.0
		    }
		}
    })

    local nuclearTankFlamethrower = makeGun(
	{
	    name = "nuclear-tank-flamethrower",
	    icon = "__base__/graphics/icons/flamethrower.png",
	    flags = {"goes-to-main-inventory", "hidden"},
	    order = "e[mortar]-b"
	},
	{
	    type = "stream",
	    ammo_category = "flamethrower",
	    cooldown = 1,
	    projectile_creation_distance = 1,
	    gun_barrel_length = 1.4,
	    damage_modifier = 2,
	    gun_center_shift = { -0.17, -1.15 },
	    range = 15,
	    min_range = 3,
	    cyclic_sound =
		{
		    begin_sound =
			{
			    {
				filename = "__base__/sound/fight/flamethrower-start.ogg",
				volume = 1
			    }
			},
		    middle_sound =
			{
			    {
				filename = "__base__/sound/fight/flamethrower-mid.ogg",
				volume = 1
			    }
			},
		    end_sound =
			{
			    {
				filename = "__base__/sound/fight/flamethrower-end.ogg",
				volume = 1
			    }
			}
		}
    })

    local nuclearTankLauncher = makeGun(
	{
	    name = "nuclear-tank-launcher",
	    icon = "__RampantArsenal__/graphics/icons/mortar.png",
	    flags = {"goes-to-main-inventory", "hidden"},
	    order = "e[mortar]-b"
	},
	{
	    type = "stream",
	    ammo_category = "capsule-launcher",
	    cooldown = 350,
	    movement_slow_down_factor = 0.9,
	    damage_modifier = 2.7,
	    gun_center_shift = {
		north = {0, 0},
		east = {0, 0},
		south = {0, 0},
		west = {0, 0}
	    },
	    gun_barrel_length = 2,
	    range = 32,
	    sound = make_heavy_gunshot_sounds()
    })

    
    local nuclearTankRocket = makeGun(
	{
	    name = "nuclear-tank-rocket",
	    icon = "__base__/graphics/icons/rocket-launcher.png",
	    flags = {"goes-to-main-inventory", "hidden"},
	    order = "e[mortar]-b"
	},
	{
	    type = "stream",
	    ammo_category = "rocket",
	    cooldown = 50,
	    movement_slow_down_factor = 0.8,
	    damage_modifier = 1.5,
	    gun_center_shift = {
		north = {0, 0},
		east = {0, 0},
		south = {0, 0},
		west = {0, 0}
	    },
	    gun_barrel_length = 2.5,
	    range = 30,
	    sound = {
		{
		    filename = "__base__/sound/fight/rocket-launcher.ogg",
		    volume = 0.7
		}
	    }
    })
    
    local nuclearTank = makeTank({
	    name = "nuclear",
	    scale = 1,
	    order = "b[personal-transport]-b[zbtank]",
	    icon = "__RampantArsenal__/graphics/icons/nuclear-tank.png",
	    collisionBox = {{-1.9, -3.2}, {1.7, 2.4}},
	    selectionBox = {{-1.9, -3.2}, {1.7, 2.4}},
	    drawingBox = {{-3.6, -3.6}, {3.4, 2.8}},
	    equipmentGrid = nuclearTankGrid,
	    weapons = { nuclearTankMachineGun, nuclearTankCannon, nuclearTankFlamethrower, nuclearTankLauncher, nuclearTankRocket},
	    immuneToTrees = true,
	    health = 5000,
	    brakingForce = "1MW",
	    consumption = "3.0MW",
	    weight = 40000,
	    inventorySize = 180,
	    tint = { r = 0, g = 0.45, b = 0, a = 1 },
	    energySource = {
		fuel_category = "nuclear",
		effectivity = 0.9,
		emissions = 0.02,
		fuel_inventory_size = 2,
		burnt_inventory_size = 2,
		smoke =
		    {
			{
			    name = "tank-smoke",
			    deviation = {0.25, 0.25},
			    frequency = 50,
			    position = {0, 1.5},
			    starting_frame = 0,
			    starting_frame_deviation = 60
			}
		    }
	    },
	    resistances = {
		{
		    type = "fire",
		    decrease = 20,
		    percent = 70
		},
		{
		    type = "electric",
		    decrease = 15,
		    percent = 60
		},
		{
		    type = "physical",
		    decrease = 25,
		    percent = 80
		},
		{
		    type = "impact",
		    decrease = 50,
		    percent = 90
		},
		{
		    type = "explosion",
		    decrease = 25,
		    percent = 80
		},
		{
		    type = "acid",
		    decrease = 30,
		    percent = 75
		}
	    }
    })

    local advCarGrid = makeGrid({
	    name = "advanced-car",
	    width = 10,
	    height = 10
    })

    local nuclearCarGrid = makeGrid({
	    name = "nuclear-car",
	    width = 13,
	    height = 13
    })

    local advancedCarMachineGun = makeGun(
	{
	    name = "advanced-car-machine-gun",
	    icon = "__RampantArsenal__/graphics/icons/minigun.png",
	    flags = {"goes-to-main-inventory", "hidden"},
	    order = "e[mortar]-b"
	},
	{
	    type = "projectile",
	    ammo_category = "bullet",
	    cooldown = 2.7,
	    movement_slow_down_factor = 0.7,
	    damage_modifier = 2,
	    shell_particle =
		{
		    name = "shell-particle",
		    direction_deviation = 0.1,
		    speed = 0.1,
		    speed_deviation = 0.03,
		    center = {0, 0},
		    creation_distance = -0.6875,
		    starting_frame_speed = 0.4,
		    starting_frame_speed_deviation = 0.1
		},
	    projectile_center = {-0.15625, -0.07812},
	    projectile_creation_distance = 2,
	    range = 21,
	    sound = make_heavy_gunshot_sounds()
    })

    local advancedCarShotgun = makeGun(
	{
	    name = "advanced-car-shotgun",
	    icon = "__base__/graphics/icons/combat-shotgun.png",
	    flags = {"goes-to-main-inventory", "hidden"},
	    order = "e[mortar]-b"
	},
	{
	    type = "projectile",
	    ammo_category = "shotgun-shell",
	    cooldown = 30,
	    movement_slow_down_factor = 0.5,
	    damage_modifier = 2,
	    projectile_creation_distance = 1.5,
	    range = 20,
	    sound =
		{
		    {
			filename = "__base__/sound/pump-shotgun.ogg",
			volume = 0.5
		    }
		}
    })
    
    local advCar = makeCar({
	    name = "advanced",
	    scale = 0.6,
	    equipmentGrid = advCarGrid,
	    order = "b[personal-transport]-a[zacar]",
	    icon = "__RampantArsenal__/graphics/icons/advanced-car.png",
	    immuneToTrees = true,
	    health = 1200,
	    friction = 0.003,
	    weapons = {advancedCarMachineGun, advancedCarShotgun},
	    effectivity = 0.80,
	    brakingForce = "400kW",
	    consumption = "1.0MW",
	    weight = 1600,
	    inventorySize = 130,
	    energySource = {
		fuel_category = "chemical",
		effectivity = 0.6,
		fuel_inventory_size = 1,
		emissions = 0.02,
		smoke =
		    {
			{
			    name = "car-smoke",
			    deviation = {0.25, 0.25},
			    frequency = 200,
			    position = {0, 1.5},
			    starting_frame = 0,
			    starting_frame_deviation = 60
			}
		    }
	    },
	    collisionBox = {{-0.9, -1.2}, {0.9, 1.2}},
	    selectionBox = {{-0.9, -1.2}, {0.9, 1.2}},
	    tint = { r = 0.45, g = 0, b = 0, a = 1 },
	    resistances = {
		{
		    type = "fire",
		    percent = 55
		},
		{
		    type = "impact",
		    percent = 30,
		    decrease = 60
		},
		{
		    type = "physical",
		    percent = 40,
		    decrease = 10
		},
		{
		    type = "acid",
		    percent = 20,
		    decrease = 10
		},
		{
		    type = "electric",
		    percent = 40,
		    decrease = 8
		}
	    }
    })

    local nuclearCarMachineGun = makeGun(
	{
	    name = "nuclear-car-machine-gun",
	    icon = "__RampantArsenal__/graphics/icons/minigun.png",
	    flags = {"goes-to-main-inventory", "hidden"},
	    order = "e[mortar]-b"
	},
	{
	    type = "projectile",
	    ammo_category = "bullet",
	    cooldown = 2.5,
	    movement_slow_down_factor = 0.7,
	    damage_modifier = 2.5,
	    shell_particle =
		{
		    name = "shell-particle",
		    direction_deviation = 0.1,
		    speed = 0.1,
		    speed_deviation = 0.03,
		    center = {0, 0},
		    creation_distance = -0.6875,
		    starting_frame_speed = 0.4,
		    starting_frame_speed_deviation = 0.1
		},
	    projectile_center = {-0.15625, -0.07812},
	    projectile_creation_distance = 2,
	    range = 22,
	    sound = make_heavy_gunshot_sounds()
    })

    local nuclearCarShotgun = makeGun(
	{
	    name = "nuclear-car-shotgun",
	    icon = "__base__/graphics/icons/combat-shotgun.png",
	    flags = {"goes-to-main-inventory", "hidden"},
	    order = "e[mortar]-b"
	},
	{
	    type = "projectile",
	    ammo_category = "shotgun-shell",
	    cooldown = 25,
	    movement_slow_down_factor = 0.5,
	    damage_modifier = 2.5,
	    projectile_creation_distance = 1.5,
	    range = 20,
	    sound =
		{
		    {
			filename = "__base__/sound/pump-shotgun.ogg",
			volume = 0.5
		    }
		}
    })
    
    local nuclearCarLauncher = makeGun(
	{
	    name = "nuclear-car-launcher",
	    icon = "__RampantArsenal__/graphics/icons/mortar.png",
	    flags = {"goes-to-main-inventory", "hidden"},
	    order = "e[mortar]-b"
	},
	{
	    type = "stream",
	    ammo_category = "capsule-launcher",
	    cooldown = 350,
	    movement_slow_down_factor = 0.9,
	    damage_modifier = 2.5,
	    gun_center_shift = {
		north = {0, 0},
		east = {0, 0},
		south = {0, 0},
		west = {0, 0}
	    },
	    gun_barrel_length = 1.5,
	    range = 30,
	    sound = make_heavy_gunshot_sounds()
    })
    
    local nuclearCar = makeCar({
	    name = "nuclear",
	    scale = 0.7,
	    equipmentGrid = nuclearCarGrid,
	    order = "b[personal-transport]-a[zbcar]",
	    immuneToTrees = true,
	    health = 2000,
	    effectivity = 0.85,
	    friction = 0.004,
	    weapons = {nuclearCarMachineGun, nuclearCarShotgun, nuclearCarLauncher},
	    brakingForce = "600kW",
	    consumption = "1.5MW",
	    weight = 2500,
	    inventorySize = 200,
	    icon = "__RampantArsenal__/graphics/icons/nuclear-car.png",
	    collisionBox = {{-1.1, -1.4}, {1.1, 1.4}},
	    selectionBox = {{-1.1, -1.4}, {1.1, 1.4}},
	    tint = { r = 0, g = 0.45, b = 0, a = 1 },
	    energySource = {
		fuel_category = "nuclear",
		effectivity = 1,
		emissions = 0.02,
		fuel_inventory_size = 1,
		burnt_inventory_size = 1,
		smoke =
		    {
			{
			    name = "tank-smoke",
			    deviation = {0.25, 0.25},
			    frequency = 50,
			    position = {0, 1.5},
			    starting_frame = 0,
			    starting_frame_deviation = 60
			}
		    }
	    },
	    resistances = {
		{
		    type = "fire",
		    percent = 60
		},
		{
		    type = "impact",
		    percent = 30,
		    decrease = 70
		},
		{
		    type = "physical",
		    percent = 40,
		    decrease = 15
		},
		{
		    type = "acid",
		    percent = 35,
		    decrease = 15
		},
		{
		    type = "electric",
		    percent = 40,
		    decrease = 16
		}
	    }
    })

    local nuclearTrainGrid = makeGrid({
	    name = "nuclear-train",
	    width = 16,
	    height = 16,
	    categories = {"noInventory"}
    })
    
    local nuclearTrain = makeTrain({
	    name = "nuclear",
	    scale = 0.5,
	    order = "a[train-system]-f[zdiesel-locomotive]",
	    icon = "__RampantArsenal__/graphics/icons/nuclear-locomotive.png",
	    equipmentGrid = nuclearTrainGrid,
	    health = 2400,
	    brakingForce = 15,
	    consumption = "3.0MW",
	    maxSpeed = 1.3,
	    maxReverse = 0.7,
	    maxPower = "1MW",
	    weight = 6000,
	    tint = { r = 0, g = 0.45, b = 0, a = 1 },
	    energySource = {
		fuel_category = "nuclear",
		effectivity = 0.9,
		fuel_inventory_size = 3,
		burnt_inventory_size = 3,
		smoke =
		    {
			{
			    name = "tank-smoke",
			    deviation = {0.25, 0.25},
			    frequency = 50,
			    position = {0, 1.5},
			    starting_frame = 0,
			    starting_frame_deviation = 60
			}
		    }
	    }
    })    
    
    local advTankRecipe = makeRecipe({
	    name = "advanced-tank",
	    icon = "__RampantArsenal__/graphics/icons/advanced-tank.png",
	    enabled = false,
	    category = "crafting",
	    ingredients = {
		{"tank", 1},
		{"plastic-bar", 100},
		{"steel-plate", 150},
		{"processing-unit", 30}
	    },
	    result = advTank,
    })

    local nuclearTankRecipe = makeRecipe({
	    name = "nuclear-tank",
	    icon = "__RampantArsenal__/graphics/icons/nuclear-tank.png",
	    enabled = false,
	    category = "crafting",
	    ingredients = {
		{advTank, 1},
		{"nuclear-reactor", 1},
		{"steel-plate", 200},
		{"processing-unit", 50}
	    },
	    result = nuclearTank,
    })
    
    local advCarRecipe = makeRecipe({
	    name = "advanced-car",
	    icon = "__RampantArsenal__/graphics/icons/advanced-car.png",
	    enabled = false,
	    category = "crafting",
	    ingredients = {
		{"car", 1},
		{"steel-plate", 30},
		{"copper-plate", 40},
		{"processing-unit", 25}
	    },
	    result = advCar,
    })
    
    local nuclearCarRecipe = makeRecipe({
	    name = "nuclear-car",
	    icon = "__RampantArsenal__/graphics/icons/nuclear-car.png",
	    enabled = false,
	    category = "crafting",
	    ingredients = {
		{advCar, 1},
		{"nuclear-reactor", 1},
		{"steel-plate", 75},
		{"processing-unit", 30}
	    },
	    result = nuclearCar,
    })
    
    local nuclearTrainRecipe = makeRecipe({
	    name = "nuclear-train",
	    icon = "__RampantArsenal__/graphics/icons/nuclear-locomotive.png",
	    enabled = false,
	    category = "crafting",
	    ingredients = {
		{"locomotive", 1},
		{"nuclear-reactor", 1},
		{"steel-plate", 100},
		{"processing-unit", 20}
	    },
	    result = nuclearTrain,
    })
    
    addEquipmentGrid("locomotive",
		     "locomotive",
		     makeGrid({
			     name = "locomotive",
			     width = 12,
			     height = 12,
			     categories = {"noInventory"}
    }))
    
    addEquipmentGrid("artillery-wagon",
		     "artillery-wagon",
		     makeGrid({
			     name = "artillery-wagon",
			     width = 16,
			     height = 16,
			     categories = {"noInventory"}
    }))
    
    addEquipmentGrid("cargo-wagon",
		     "cargo-wagon",
		     makeGrid({
			     name = "cargo-wagon",
			     width = 8,
			     height = 8,
			     categories = {"immobile"}
    }))

    addEquipmentGrid("fluid-wagon",
		     "fluid-wagon",
		     makeGrid({
			     name = "fluid-wagon",
			     width = 8,
			     height = 8,
			     categories = {"noInventory"}
    }))
    
    addEquipmentGrid("car",
		     "car",
		     makeGrid({
			     name = "car",
			     width = 8,
			     height = 8
    }))

    addEquipmentGrid("car",
		     "tank",
		     makeGrid({
			     name = "tank",
			     width = 10,
			     height = 10
    }))

    addEffectToTech("rampant-arsenal-technology-tanks-2",
		    {
			type = "unlock-recipe",
			recipe = advTankRecipe
    })
    
    addEffectToTech("rampant-arsenal-technology-nuclear-tanks",
		    {
			type = "unlock-recipe",
			recipe = nuclearTankRecipe
    })

    
    addEffectToTech("rampant-arsenal-technology-cars-2",
		    {
			type = "unlock-recipe",
			recipe = advCarRecipe
    })
    
    addEffectToTech("rampant-arsenal-technology-nuclear-cars",
		    {
			type = "unlock-recipe",
			recipe = nuclearCarRecipe
    })
    
    addEffectToTech("rampant-arsenal-technology-nuclear-railway",
		    {
			type = "unlock-recipe",
			recipe = nuclearTrainRecipe
    })

    addFuelToItem({
	    eType = "item",
	    eName = "uranium-fuel-cell",
	    accelerationMutlipler = 1.5,
	    topSpeedMultipler = 1.10,
	    fuelEmissionsMultipler = 3
    })

    addFuelToItem({
	    eType = "item",
	    eName = "solid-fuel",
	    fuelEmissionsMultipler = 0.75
    })
    
    addFuelToItem({
	    eType = "item",
	    eName = "rocket-fuel",
	    fuelEmissionsMultipler = 1.5
    })

    addFuelToItem({
	    eType = "item",
	    eName = "coal",
	    fuelEmissionsMultipler = 2
    })
    
    addFuelToItem({
	    eType = "item",
	    eName = "nuclear-fuel",
	    fuelEmissionsMultipler = 4
    })

    modifyItem({
	    eType = "item",
	    eName = "nuclear-fuel",
	    stackSize = 10
    })

    addCategory("night-vision-equipment", "immobile")
    addCategory("energy-shield-equipment", "immobile")
    addCategory("battery-equipment", "immobile")
    addCategory("solar-panel-equipment", "immobile")
    addCategory("generator-equipment", "immobile")
    addCategory("active-defense-equipment", "immobile")
    addCategory("roboport-equipment", "immobile")

    addCategory("night-vision-equipment", "noInventory")
    addCategory("energy-shield-equipment", "noInventory")
    addCategory("battery-equipment", "noInventory")
    addCategory("solar-panel-equipment", "noInventory")
    addCategory("generator-equipment", "noInventory")
    addCategory("active-defense-equipment", "noInventory")
end

return vehicles
