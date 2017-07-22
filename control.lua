require "config"

require "util"
require "signal_processing"

local mod_version = "1.1.3"
local mod_data_version = "1.1.3"

local wire_colors =
{
    defines.wire_type.red,
    defines.wire_type.green
}

local function init_global()
    global.version = mod_version
    global.data_version = mod_data_version

    if not global.skan_wireless_signals then
        global.skan_wireless_signals = {transmitters = {}, receivers = {}, print_once = {}}
    end
end

local function onInit()
    init_global()
end

local function checkForMigration(old_version, new_version)
  -- TODO: when a migration is necessary, trigger it here or set a flag.
end

local function checkForDataMigration(old_data_version, new_data_version)
  -- TODO: when a migration is necessary, trigger it here or set a flag.
end

local function onConfigChange(data)
    checkForMigration(global.version, mod_version)
    checkForDataMigration(global.data_version, mod_data_version)
end

local function near(transmitter, receiver)
    if transmitter.range == 0 then return true end
    return transmitter.range >= math.sqrt((receiver.entity.position.x - transmitter.entity.position.x) ^ 2
                                          + (receiver.entity.position.y - transmitter.entity.position.y) ^ 2)
end

-- returns a list of transmitters that the receiver is in range of
local function findTransmittersInRange(receiver)
    local in_range = {}
    for k, transmitter in pairs(global.skan_wireless_signals.transmitters) do
        if transmitter.entity.valid and near(transmitter, receiver) then
            table.insert(in_range, transmitter)
        end
    end
    return in_range
end

local updatesPerSecond = 10


local tickFrequency = 60 / updatesPerSecond

local function onTick(event)
    if ((event.tick % tickFrequency) > 0) then return end

    for k, transmitter in pairs(global.skan_wireless_signals.transmitters) do -- update transmitters
        if transmitter.entity.valid then
            if transmitter.entity.energy > 0 then -- transmitters only work when powered
                local active_signals = {}
                for i = 1, #wire_colors do -- check both red and green wires
                    local c = transmitter.entity.get_circuit_network(wire_colors[i])
                    if c and c.signals then
                        merge_signals(active_signals, c.signals)
                    end
                end
                transmitter.signals.parameters = active_signals
            elseif transmitter.position ~= nil then -- workaround for game incorrectly thinking devices are invalid on load
                rtest = game.surfaces["nauvis"].find_entity("skan-radio-transmitter-1", transmitter.position)
                if rtest and rtest.valid then
                    transmitter.entity = rtest
                    --debugPrint("invalid transmitter 1 found")
                else -- must do this for both types of transmitters
                    rtest = game.surfaces["nauvis"].find_entity("skan-radio-transmitter-2", transmitter.position)
                    if rtest and rtest.valid then
                        transmitter.entity = rtest
                        --debugPrint("invalid transmitter 2 found")
                    end
                end
            end
        end
     end
     for _, receiver in pairs(global.skan_wireless_signals.receivers) do -- update receivers
        if receiver.entity.valid then
            local merged_state = {}
            local nearby_transmitters = findTransmittersInRange(receiver) -- find which transmitters are in range
            for __, transmitter in ipairs(nearby_transmitters) do -- get global signal tables from those transmitters
                merge_state(merged_state, transmitter.signals.parameters)
            end
            local formatted = format_signals(merged_state, receiver.entity.get_control_behavior().signals_count)
            if #formatted > 0 then
                receiver.entity.get_control_behavior().parameters = { parameters = formatted }
            else
                receiver.entity.get_control_behavior().parameters = nil -- there are no incoming signals, so zero out the output
            end
         elseif receiver.position ~= nil then -- workaround for game sometimes losing track of devices on load
            rtest = game.surfaces["nauvis"].find_entity("skan-radio-receiver", receiver.position)
            if rtest and rtest.valid then
                receiver.entity = rtest
                -- debugPrint("invalid reciever found")
            end
        end
    end
end

local signal_everything = {
  condition = {
      comparator = ">",
      first_signal = {type = "virtual", name = "signal-everything"},
      constant = 0
  }
}

local function onPlaceEntity(event)
    local entity = event.created_entity
    if entity.name == "skan-radio-transmitter-1" then
        entity.operable = false -- disable the UI
        entity.get_or_create_control_behavior().connect_to_logistic_network = false -- keep it separate from the logistic network
        entity.get_control_behavior().circuit_condition = signal_everything
        table.insert(global.skan_wireless_signals.transmitters, -- add the transmitter to the global list
        {
            entity = entity,
            range = 3000, -- how far the transmitter can broadcast
            channel = 1, -- future expansion
            signals = {parameters = {}}, -- the actual signals, will be dynamically updated in OnTick
            position = entity.position -- part of workaround for game thinking devices are invalid on load, may become unnecessary in the future??
        })
    elseif entity.name == "skan-radio-transmitter-2" then
        entity.operable = false
        entity.get_or_create_control_behavior().connect_to_logistic_network = false
        entity.get_control_behavior().circuit_condition = signal_everything
        table.insert(global.skan_wireless_signals.transmitters,
        {
            entity = entity,
            range = 0, -- unlimited range
            channel = 1, -- future expansion
            signals = {parameters = {}},
            position = entity.position
        })
    elseif entity.name == "skan-radio-receiver" then
        entity.operable = false
        entity.get_or_create_control_behavior().parameters = nil
        table.insert(global.skan_wireless_signals.receivers, -- add the receiver to the global list
        {
            entity = entity,
            channel = 1,
            position = entity.position
        })
    end
end

local function onRemoveEntity(event) -- the removed device needs to be removed from the global list(s)
    local entity = event.entity
    if entity.name == "skan-radio-transmitter-1" or entity.name == "skan-radio-transmitter-2" then
        for i = 1, #global.skan_wireless_signals.transmitters do
            if entity == global.skan_wireless_signals.transmitters[i].entity then
                table.remove(global.skan_wireless_signals.transmitters, i)
                return
            end
        end
    elseif entity.name == "skan-radio-receiver" then
        for i = 1, #global.skan_wireless_signals.receivers do
            if entity == global.skan_wireless_signals.receivers[i].entity then
                table.remove(global.skan_wireless_signals.receivers, i)
                return
            end
        end
    end
end

script.on_init(onInit)

script.on_configuration_changed(onConfigChange)

script.on_event(defines.events.on_built_entity, onPlaceEntity)
script.on_event(defines.events.on_robot_built_entity, onPlaceEntity)

script.on_event(defines.events.on_preplayer_mined_item, onRemoveEntity)
script.on_event(defines.events.on_robot_pre_mined, onRemoveEntity)
script.on_event(defines.events.on_entity_died, onRemoveEntity)

script.on_event(defines.events.on_tick, onTick)
