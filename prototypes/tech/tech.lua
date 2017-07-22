data:extend(
{
    {
        type = "technology",
        name = "skan-radio-telemetry",
        icon = "__skan-radio-telemetry__/resources/icons/telemetry.png",
        icon_size = 128,
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "skan-radio-transmitter-1"
            },
            {
                type = "unlock-recipe",
                recipe = "skan-radio-receiver"
            },
        },
        prerequisites = {"circuit-network", "advanced-electronics-2"},
        unit =
        {
            count = 50,
            ingredients =
            {
                {"science-pack-1", 1},
                {"science-pack-2", 1},
                {"science-pack-3", 1},
            },
            time = 30
        },
        order = "a-d-e",
    },
    {
        type = "technology",
        name = "skan-radio-telemetry-2",
        icon = "__skan-radio-telemetry__/resources/icons/telemetry.png",
        icon_size = 128,
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "skan-radio-transmitter-2"
            },
        },
        prerequisites = {"skan-radio-telemetry", "effectivity-module-2"},
        unit =
        {
            count = 100,
            ingredients =
            {
                {"science-pack-1", 1},
                {"science-pack-2", 1},
                {"science-pack-3", 1},
                {"high-tech-science-pack", 1},
            },
            time = 45
        },
        order = "a-d-e",
    },
}
)