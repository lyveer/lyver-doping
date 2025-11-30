local RSGCore = exports['rsg-core']:GetCoreObject()
local isBusy = false 

-- [[ 2. ANIMATION FUNCTION ]] --
local function PlayAnimSyringe(propName)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local dict = "mech_inventory@item@stimulants@inject@quick"
    local anim = "quick_stimulant_inject_lhand"

    RequestAnimDict(dict); while not HasAnimDictLoaded(dict) do Wait(10) end
    local hashItem = GetHashKey(propName)
    RequestModel(hashItem); while not HasModelLoaded(hashItem) do Wait(10) end

    local prop = CreateObject(hashItem, playerCoords.x, playerCoords.y, playerCoords.z, true, true, false)
    local boneIndex = GetEntityBoneIndexByName(playerPed, "SKEL_L_HAND")

    ClearPedTasks(playerPed)
    TaskPlayAnim(playerPed, dict, anim, 8.0, -8.0, 2500, 31, 0.0, false, false, false)
    AttachEntityToEntity(prop, playerPed, boneIndex, 0.10, 0.0, 0.03, 0.0, -80.0, -90.0, true, true, false, true, 1, true)

    Wait(2000)

    ClearPedTasks(playerPed)
    DeleteObject(prop)
    SetModelAsNoLongerNeeded(hashItem)
    RemoveAnimDict(dict)
end

-- [[ 3. CONSTANT FALL LOOP (SOFT FADE) ]] --
local function ApplyDrunkEffect(duration)
    local ped = PlayerPedId()
    local endTime = GetGameTimer() + (duration * 1000)

    AnimpostfxPlay(Config.DrunkEffectName, 0, true)
    ShakeGameplayCam("DRUNK_SHAKE", 2.0)

    -- DÖNGÜ BAŞLIYOR
    while GetGameTimer() < endTime do
        Wait(2500)

        if GetGameTimer() >= endTime then break end

        DoScreenFadeOut(1000) 
        Wait(1000)           

        SetPedToRagdoll(ped, 4000, 4000, 0, true, true, false)

        Wait(3000)

        DoScreenFadeIn(1500) 


        Wait(1000)
    end

    AnimpostfxStop(Config.DrunkEffectName)
    StopGameplayCamShaking(true)
end

-- [[ 4. MAIN EVENT ]] --
RegisterNetEvent('rsg-staminatonic:client:UseSyringe', function(usageCount)
    if isBusy then
        TriggerEvent('rNotify:NotifyLeft', "ACTION", "You are busy!", "menu_textures", "cross", 2000)
        return
    end

    isBusy = true
    local ped = PlayerPedId()

    TriggerEvent('rNotify:NotifyLeft', "ADRENALINE", "Injecting " .. Config.Label .. "...", "generic_textures", "tick",
        2000)
    PlayAnimSyringe(Config.PropName)

    local fillAmount = (Config.StaminaFill / 100.0)
    RestorePlayerStamina(PlayerId(), fillAmount)
    Citizen.InvokeNative(0xC6258F41D86676E0, ped, 1, Config.StaminaFill)

    isBusy = false

    -- [[ OVERDOSE LOGIC ]] --

    if usageCount == 1 then
        if Config.EnableScreenEffect then
            AnimpostfxPlay(Config.ScreenEffectName, 0, false)
            Wait(Config.EffectDuration)
            AnimpostfxStop(Config.ScreenEffectName)
        end
    elseif usageCount == 2 then

        TriggerEvent('rNotify:NotifyLeft', "WARNING", "You used too much! You will collapse if you take another.",
            "menu_textures", "cross", 5000)
    elseif usageCount >= 3 then

        TriggerEvent('rNotify:NotifyLeft', "DANGER", "Heart Failure! System Collapse!", "menu_textures", "cross", 5000)

        isBusy = true
        AnimpostfxPlay(Config.ScreenEffectName, 0, false)
        Wait(500)

        DoScreenFadeOut(1000)
        Wait(1000)

        SetPedToRagdoll(ped, 6000, 6000, 0, true, true, false)
        Wait(6000)

        DoScreenFadeIn(1500)
        ClearPedTasks(ped)
        isBusy = false

        TriggerEvent('rNotify:NotifyLeft', "RECOVERY", "You can't stand up properly...", "menu_textures", "cross", 5000)

        CreateThread(function()
            ApplyDrunkEffect(Config.DrunkDuration)
        end)
    end
end)
