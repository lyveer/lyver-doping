local RSGCore = exports['rsg-core']:GetCoreObject()

-- Table to store player usage data: { count = 0, lastTime = 0 }
local playerHistory = {}

RSGCore.Functions.CreateUseableItem(Config.ItemName, function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    
    -- Security Check
    if not RSGCore.Shared.Items[Config.ItemName] then
        print("^1[ERROR] Item '" .. Config.ItemName .. "' not found! Restart Server.^0")
        return
    end

    local currentTime = os.time()

    -- Initialize or Reset Logic
    if not playerHistory[src] or (currentTime - playerHistory[src].lastTime) > Config.ResetTime then
        -- Reset if first time or time passed the limit
        playerHistory[src] = { count = 1, lastTime = currentTime }
    else
        -- Increment count if used within the time window
        playerHistory[src].count = playerHistory[src].count + 1
        playerHistory[src].lastTime = currentTime
    end

    local currentCount = playerHistory[src].count

    -- Remove Item
    if Player.Functions.RemoveItem(Config.ItemName, 1) then
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[Config.ItemName], "remove")
        
        -- Trigger Client with the usage count (1, 2, or 3+)
        TriggerClientEvent('rsg-staminatonic:client:UseSyringe', src, currentCount)
    end
end)