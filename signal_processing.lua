local function debugPrint(string)
    local p
    if game and game.players[1] then
        p = game.players[1].print
    else
        p = print
    end
    p(string)
end

function printOnce(id, msg)
    if not global.skan_wireless_signals.print_once then
        global.skan_wireless_signals.print_once = {}
    end
    if not global.skan_wireless_signals.print_once[id] then
        global.skan_wireless_signals.print_once[id] = true
        debugPrint(msg)
    end
end

function merge_signals(state, signals)
    for _,signal in ipairs(signals) do
        local key = signal.signal.type .. ":" .. signal.signal.name
        --debugPrint("Found a signal: " .. key)
        local previous = state[key]
        if not previous then
            state[key] = { signal = signal.signal, count = signal.count }
        else
            state[key] = { signal = signal.signal, count = signal.count + previous.count }
        end
    end
end

function merge_state(state, a)
    for key, signal in pairs(a) do
        local previous = state[key]
        if not previous then
            state[key] = signal
        else
            state[key] = { signal = signal.signal, count = signal.count + previous.count }
        end
    end
end

function format_signals(state, maxcount)
    local signals = {}
    local index = 1
    for _,signal in pairs(state) do
        signal.index = index
        if index <= maxcount then
            --debugPrint("Formatting: " .. signal.signal.name)
            table.insert(signals, signal)
        else
            printOnce("maxsignals",
                "More than " .. maxcount .. " signals sent into a transmitter.  Random signals will propagate.")
        end
        index = index + 1
    end
    return signals
end
