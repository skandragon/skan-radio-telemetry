data:extend(
{
	{
		type = "item",
		name = "skan_skan-radio-transmitter-1",
		icon = "__wireless-signals__/resources/icons/radio-transmitter-1.png",
		flags = {"goes-to-quickbar"},
		subgroup = "circuit-network",
		order = "c[radio]-a[transmitter-1]",
		place_result = "skan-radio-transmitter-1",
		stack_size = 10,
	},
	{
		type = "item",
		name = "skan_skan-radio-transmitter-2",
		icon = "__wireless-signals__/resources/icons/radio-transmitter-2.png",
		flags = {"goes-to-quickbar"},
		subgroup = "circuit-network",
		order = "c[radio]-b[transmitter-2]",
		place_result = "skan-radio-transmitter-2",
		stack_size = 10,
	},
	{
		type = "item",
		name = "skan-radio-receiver",
		icon = "__skan_wireless-signals__/resources/icons/radio-receiver.png",
		flags = {"goes-to-quickbar"},
		subgroup = "circuit-network",
		order = "c[radio]-d[receiver]",
		place_result = "skan-radio-receiver",
		stack_size = 10,
	},
}
)