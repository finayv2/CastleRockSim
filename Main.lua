local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/preztel/AzureLibrary/master/uilib.lua", true))()
local CurrentlyRunning = false
local FarmTab = Library:CreateTab("Farm", "Farm Tab", "Dark")

FarmTab:CreateToggle("AutoFarm", function(value) 
    shared.AutoFarm = value
    while wait() do
        if shared.AutoFarm then
            for i,v in pairs(game:GetService("Workspace").Objects.Spawned:GetChildren()) do
                if v:FindFirstChild("Box") then
                    local mag = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Box.Position).magnitude
                    local Meter = 10
                    if mag < Meter then
                        Meter = mag
                        fireclickdetector(v.Box.Click)
                    end
                end
            end

            if game:GetService("Players").LocalPlayer.PlayerGui.Display.Pass.Visible == true then
                CurrentlyRunning = false
            end

            if game:GetService("Workspace").Objects.Map.Teleporter.Cooldowns:FindFirstChild(game.Players.LocalPlayer.Name) then
                if not CurrentlyRunning then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Objects.Map.Stone.CFrame
                end
            else
                if not CurrentlyRunning then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Objects.Map.Teleporter.CFrame
                end
            end

            if not CurrentlyRunning then
                CurrentlyRunning = true
                wait(1.5)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-35.7204247, -151.75, -500.515045)
                wait(2.5)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-36.2731171, -151.75, -517.983704)
                wait(2.5)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-47.0220528, -151.75, -525.871094)
                wait(2.5)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-62.6885948, -151.75, -526.924866)
                wait(3.5)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Objects.Map.EndTeleporter.CFrame
            end
        else
            CurrentlyRunning = false
        end
    end
end)

FarmTab:CreateToggle("Auto Pickup", function(value) 
    shared.AutoPick = value
    while wait() do
        if shared.AutoPick then
            for i,v in pairs(game:GetService("Workspace").Objects.Spawned:GetChildren()) do
                if v:FindFirstChild("Box") then
                    local mag = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Box.Position).magnitude
                    local Meter = 10
                    if mag < Meter then
                        Meter = mag
                        fireclickdetector(v.Box.Click)
                    end
                end
            end
        end
    end
end)


local LocalPlayerTab = Library:CreateTab("LocalPlayer", "LocalPlayer Tab")

LocalPlayerTab:CreateToggle("No Cooldown", function(value) 
    shared.NoCooldown = value
    while wait() do
        if shared.NoCooldown then
            game:GetService("Players").LocalPlayer.PlayerGui.Client.Frame.Jump.Value = false
            game:GetService("Players").LocalPlayer.PlayerGui.Client.Frame.Stunned.Value = false
            for i,v in pairs(game.Players.LocalPlayer.Character.Humanoid.Cool:GetChildren()) do
                v.Value = false
            end
        end
    end
end)



LocalPlayerTab:CreateToggle("No Fall", function(value) 
    shared.NoFall = value

    local mt = getrawmetatable(game)
    local oldNamecall = mt.__namecall
    setreadonly(mt,false)
    mt.__namecall = function(inst,...)
        local m = getnamecallmethod()
        local args = {...}
        if shared.NoFall and m=="FireServer" and inst.Name == "Action" then
            if args[1] == "Fall" then
                return
            end
        end
        return oldNamecall(inst,unpack(args))
    end

end)

LocalPlayerTab:CreateToggle("Remove Kill Bricks", function(value) 
    shared.KillBricks = value
    while wait() do
        if shared.KillBricks then
            for i,v in pairs(game:GetService("Workspace").Objects.Map:GetChildren()) do
                if v.Name == "Magma" then
                    v:FindFirstChild("TouchInterest"):Remove()
                end
            end
        end
    end
end)

local ManaValue = 0

LocalPlayerTab:CreateToggle("Mana Abjust", function(value) 
    shared.InfMana = value
    while wait() do
        if shared.InfMana then
            game.Players.LocalPlayer.Character.Humanoid.Values.Mana.Value = ManaValue
        end
    end
end)


LocalPlayerTab:CreateSlider("Mana Amount", 0, 100, function(arg) 
    ManaValue = arg
end)


local mt = getrawmetatable(game)
local old = mt.__namecall
local protect = newcclosure or protect_function
    
setreadonly(mt, false)
mt.__namecall = protect(function(self, ...)
    local method = getnamecallmethod()
    if method == "Kick" then
    	wait(9e9)
    	return
    end
    return old(self, ...)
end)
    
hookfunction(game:GetService("Players").LocalPlayer.Kick,protect(function() wait(9e9) end))
