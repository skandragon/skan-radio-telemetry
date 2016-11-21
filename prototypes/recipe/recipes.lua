data:extend(
{
	{
		type = "recipe",
		name = "skan-radio-transmitter-1",
		enabled = false,
		ingredients =
		{
			{"steel-plate", 20},
			{"iron-stick", 16},
			{"advanced-circuit", 15},
			{"electronic-circuit", 20},
		},
		result = "skan-radio-transmitter-1"
	},
	{
		type = "recipe",
		name = "skan-radio-transmitter-2",
		enabled = false,
		ingredients =
		{
			{"skan-radio-transmitter-1", 1},
			{"steel-plate", 30},
			{"processing-unit", 15},
			{"effectivity-module", 2},
		},
		result = "skan-radio-transmitter-2"
	},
	{
		type = "recipe",
		name = "skan-radio-receiver",
		enabled = false,
		ingredients =
		{
			{"steel-plate", 10},
			{"iron-stick", 4},
			{"electronic-circuit", 10},
			{"battery", 10},
		},
		result = "skan-radio-receiver"
	}
}
)