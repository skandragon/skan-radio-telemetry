--
-- Set the number of updates per second for the telemetry network.  This
-- is an approximate value, set from 1 to 60.  Values outside this range
-- will be clamped to that range.  Integer only, please.
--
-- Smaller values will cause more time to be spent updating receivers.
--
updatesPerSecond = 10
