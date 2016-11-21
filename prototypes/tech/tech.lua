data:extend(
{
    {
        type = "technology",
        name = "skan-wireless-telemetry",
        icon = "__skan_wireless-signals__/resources/icons/telemetry.png",
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
        name = "skan-wireless-telemetry-2",
        icon = "__skan_wireless-signals__/resources/icons/telemetry.png",
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "skan-radio-transmitter-2"
            },
        },
        prerequisites = {"skan-telemetry", "effectivity-module-2"},
        unit =
        {
            count = 100,
            ingredients =
            {
                {"science-pack-1", 1},
                {"science-pack-2", 1},
                {"science-pack-3", 1},
                {"alien-science-pack", 1},
            },
            time = 45
        },
        order = "a-d-e",
    },
}
)