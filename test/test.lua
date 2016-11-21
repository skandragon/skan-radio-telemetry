require "signal_processing"

local signals_red = {
    { count = 1, signal = { name = "one", type = "virtual" }},
    { count = 2, signal = { name = "iron-ore", type = "item" }},
    { count = 9, signal = { name = "two", type = "virtual" }},
}

local signals_green = {
    { count = 1, signal = { name = "one", type = "virtual" }},
    { count = 2, signal = { name = "copper-ore", type = "item" }},
}

local state = {}
merge_signals(state, signals_red)
merge_signals(state, signals_green)
print("State:")
for k,v in pairs(state) do
    print(k .. " => " .. "{ count=" .. v.count .. ", { name=" .. v.signal.name .. ", type=" .. v.signal.type .. " }}")
end
print()

local formatted = {}
format_signals(formatted, state)
for k,v in ipairs(formatted) do
    print("{ count=" .. v.count .. ", { name=" .. v.signal.name .. ", type=" .. v.signal.type .. " }}")
end
