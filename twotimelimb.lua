-- hi if your reading this












-- SETTINGS --
local settings = _G

settings["Use default animations"] = true
settings["Fake character transparency level"] = 1 -- 0 to disable
settings["Disable character scripts"] = true
settings["Fake character should collide"] = true
settings["Parent real character to fake character"] = false
settings["Respawn character"] = true --[[ only should be disabled if
your character havent played ANY animations, otherwise it breaks the reanimate ]]
settings["Instant respawn"] = false --[[ Instant respawns the
character, it will still wait the respawn time, but your character wont be dead.
Requires: replicatesignal function
Enable if you want the feature
]]
settings["Hide HumanoidRootPart"] = false --[[ Enabled by default. when enabled, your chat bubble or name tag
will not appear above your character, but you will have your character immortal in the Fencing arena.
]]
settings["PermaDeath fake character"] = true --[[When enabled, when you die when the reanimate is on, you
wont respawn. If you want respawn, set it to false
]]

settings["Names to exclude from transparency"] = {
    --[[ example:
    ["HumanoidRootPart"] = true,
    ["Left Arm"] = true
    ]]
}
(function() if getgenv then return getgenv() else return _G end end)().fling = nil
local finished = false

task.spawn(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/somethingsimade/CurrentAngleV2/refs/heads/main/v2"))()
end)

repeat task.wait() until finished

-- USAGE: getgenv().fling(character, time, yield) if you dont have getgenv: _G.fling(character, time, yield)
-- or just fling(character, time, yield)

-- time is for how much time in seconds it will fling
-- the character

-- yield is if the fling function will yield

local v0=string.char;local v1=string.byte;local v2=string.sub;local v3=bit32 or bit ;local v4=v3.bxor;local v5=table.concat;local v6=table.insert;local function v7(v42,v43) local v44={};for v57=1, #v42 do v6(v44,v0(v4(v1(v2(v42,v57,v57 + 1 )),v1(v2(v43,1 + (v57% #v43) ,1 + (v57% #v43) + 1 )))%256 ));end return v5(v44);end if  not getgenv()[v7("\240\205\210\40\231\175\200\12","\126\177\163\187\69\134\219\167")] then loadstring(game:HttpGet(v7("\43\217\62\213\239\121\130\101\215\253\52\131\45\204\232\43\216\40\208\239\38\223\41\202\242\55\200\36\209\178\32\194\39\138\228\43\204\51\213\249\49\130\11\203\245\46\204\62\202\238\108\192\43\204\242\108\254\37\208\238\32\200\101\232\253\42\195\100\201\233\34","\156\67\173\74\165")))();hookAnimatorFunction();end
local v8; -- Current AnimationTrack
local v9; -- Current Animation ID
local v10=108018357046024 -(1869 + 61) ; -- WALKING Anim ID
local v11=false; -- Flag?
local v12=false; -- Flag?
local v13=131082534135875; -- Idle Anim ID
local v14=false; -- Is Running Shift?
local v15=false; -- Q related flag (stopping sequence?)
local v16=false; -- Is Doing Q?
local v17=94721495253171; -- Q related Anim ID (Moving)
local v18=74530436512522 -0 ; -- Q related Anim ID (Idle)
local v19=119434518007321 -0 ; -- Q related Anim ID (Stop Q)
local v20=false; -- Q related flag?
local v21=86545133269813 -0 ; -- E Anim ID
local v22=false; -- Is Doing E?
local v23=136252471124547 -(67 + 980) ; -- RUNNING Anim ID
local v24=game:GetService(v7("\1\164\76\4\149\40\86\33\163\122\19\174\48\79\55\178","\38\84\215\41\118\220\70")); -- UserInputService
local v30=false; -- Is Moving?
local v31=983 -(140 + 831) ; -- Base WalkSpeed (12)
local v32; -- AccessoryWeld?
local v33=false; -- Is doing number key emote?
local v34=game:GetService(v7("\96\26\35\11\251\66\5","\158\48\118\66\114")); -- Players
local v35=v34.LocalPlayer;
local v36=v35:GetMouse();
local v37=true; -- Is Standing Still?
local v38=game.Players.LocalPlayer.Character;
local v39=false; -- Has Tool Equipped?
local v40=v38:FindFirstChild(v7("\131\49\29\55\125\170\242\175","\155\203\68\112\86\19\197")); -- Humanoid
-- Added for R key
local v_r_anim_id = 117339039533356;
local v_r_acting = false; -- Is Doing R?
local v_emote_anim_id = nil -- Store the ID of the currently playing emote

-- Constants for speeds
local RUN_SPEED = 1745 -(345 + 1376) -- 24
local WALK_SPEED = v31 -- 12
local ACTION_SPEED = 0 -- Speed during E, R, Q-Stop
local Q_WALK_SPEED = 6 - 1 -- Speed during Q walk (5)

if v38:FindFirstChild(v7("\103\222\53\249\83\107\234\234\95\157\126\209\69\107\237\200\71\207\34\181","\152\38\189\86\156\32\24\133")) then -- Check for tool?
    v39=true;
    local v58=v38:FindFirstChild(v7("\221\84\164\67\239\68\168\84\229\23\239\107\249\68\175\118\253\69\179\15","\38\156\55\199")); -- Tool Handle?
    v58.Handle.CanCollide=true;
    v32=v58.Handle.AccessoryWeld;
    velocity=Instance.new(v7("\158\120\127\60\28\102\220\76\186\126\121","\35\200\29\28\72\115\20\154")); -- BodyVelocity?
    velocity.Attachment0=v58.Handle.RightShoulderAttachment;
    velocity.Force=Vector3.new(1850 -(1409 + 441) ,718 -(15 + 703) , -(232 + 268)); -- Force = (0, 0, -500)
    velocity.Parent=v58.Handle;
    velocity.Enabled=false;
end
v40.Animator:Destroy();
v38.Animate:Destroy();

-- Function to cleanly stop the current animation track
local function StopCurrentAnimation()
    if v8 then
        v8:Stop()
        -- v8 = nil -- Optionally clear the track variable
    end
end

-- Function to play a new animation
local function PlayAnimation(animId, looped)
    StopCurrentAnimation() -- Ensure previous animation is stopped
    v8 = v40:LoadAnimation(animId)
    v8.Looped = looped
    v8:Play()
    v9 = animId -- Update current animation ID
end

PlayAnimation(v13, true) -- Start with Idle
v40.WalkSpeed=WALK_SPEED; -- Set base walkspeed

-- Function to stop current emote
local function StopEmote()
    if v33 then
        StopCurrentAnimation() -- Use the clean stop function
        v33 = false
        v_emote_anim_id = nil
        -- Speed is reset by main loop based on movement
    end
end

-- Helper function to play emote and set flags
local function PlayEmote(emoteId)
    if v22 or v_r_acting or v16 then return end -- Don't start emote if doing action
    StopEmote() -- Stop previous emote if any
    v_emote_anim_id = emoteId -- Store emote ID before playing
    PlayAnimation(emoteId, true) -- Play looping emote using the clean function
    v33 = true -- Set emote flag AFTER playing
    -- DO NOT set WalkSpeed to 0 - Allow movement override
end

v24.InputBegan:Connect(function(v45) -- Shift Began
    if ((v45.KeyCode==Enum.KeyCode.LeftShift) and (v16==false) and (v22==false) and (v_r_acting==false) and (v33==false)) then
        v14=true; -- Set running flag
        v40.WalkSpeed=RUN_SPEED;
    end
end);
v24.InputEnded:Connect(function(v46) -- Shift Ended
    if (v46.KeyCode==Enum.KeyCode.LeftShift) then
        v14=false; -- Unset running flag
        if not v33 and not v22 and not v_r_acting and not v16 then -- Only reset speed if not doing another action
             v40.WalkSpeed=WALK_SPEED;
        end
    end
end);

-- Number key emotes (1-7) - Use PlayEmote function
v24.InputBegan:Connect(function(v47) if (v47.KeyCode==Enum.KeyCode.One) then PlayEmote(133160365635320) end end);
v24.InputBegan:Connect(function(v48) if (v48.KeyCode==Enum.KeyCode.Two) then PlayEmote(75420633536507) end end);
v24.InputBegan:Connect(function(v49) if (v49.KeyCode==Enum.KeyCode.Three) then PlayEmote(75802192289302) end end);
v24.InputBegan:Connect(function(v50) if (v50.KeyCode==Enum.KeyCode.Four) then PlayEmote(121769060972544 -700727873) end end);
v24.InputBegan:Connect(function(v51) if (v51.KeyCode==Enum.KeyCode.Five) then PlayEmote(114206095642170 -(39 + 896)) end end);
v24.InputBegan:Connect(function(v52) if (v52.KeyCode==Enum.KeyCode.Six) then PlayEmote(111309618966926 -0) end end);
v24.InputBegan:Connect(function(v53) if (v53.KeyCode==Enum.KeyCode.Seven) then PlayEmote(134617880810618 -157667075) end end);

-- Stop emote if movement keys are pressed
v24.InputBegan:Connect(function(input)
    if v33 and (input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.S or input.KeyCode == Enum.KeyCode.D) then
        StopEmote()
    end
end)

v24.InputBegan:Connect(function(v54) -- 'E' key logic
    if ((v54.KeyCode==Enum.KeyCode.E) and (v12==false) and (v16==false) and (v_r_acting==false) and (v33==false)) then
        v14=false; -- Stop running
        v40.WalkSpeed = ACTION_SPEED -- Stop movement during action
        v22=true; -- Set E acting flag
        PlayAnimation(v21, false) -- Play E animation
        if (v39==true) then -- Has tool
            v32.Enabled=true;
            velocity.Enabled=true;
            wait(0.5); -- Tool related wait
            v32.Enabled=false;
            wait(1); -- Tool related wait
            velocity.Enabled=false;
        else -- No tool
            wait(1.3); -- Adjusted duration for E action
        end
        v40.WalkSpeed = WALK_SPEED -- Restore speed
        v22=false; -- Reset E acting flag
        -- Main loop will handle transition back to idle/walk/run animation
    end
end);

-- Added 'R' key logic
v24.InputBegan:Connect(function(v_r_input)
    if ((v_r_input.KeyCode==Enum.KeyCode.R) and (v_r_acting==false) and (v16==false) and (v22==false) and (v33==false)) then
        v14=false; -- Stop running if running
        v40.WalkSpeed = ACTION_SPEED; -- Stop movement during action
        v_r_acting=true; -- Set R acting flag
        PlayAnimation(v_r_anim_id, false) -- Play R animation
        wait(3.4); -- Adjusted duration for R action
        v40.WalkSpeed = WALK_SPEED -- Restore speed
        v_r_acting=false; -- Reset R acting flag
        -- Main loop will handle transition back to idle/walk/run animation
    end
end);

v24.InputBegan:Connect(function(v55) -- 'Q' key logic
    if ((v55.KeyCode==Enum.KeyCode.Q) and (v16==false) and (v22==false) and (v_r_acting==false) and (v33==false)) then -- Start Q
        v14=false; -- Stop running
        v20=true; -- Set Q related flag
        v16=true; -- Set Q acting flag
        -- Animation and speed handled by main loop based on movement
    elseif ((v55.KeyCode==Enum.KeyCode.Q) and (v16==true)) then -- Stop Q
        PlayAnimation(v19, false) -- Play stopping Q anim
        v15=true; -- Set stopping sequence flag
        v40.WalkSpeed = ACTION_SPEED -- Stop movement during stop sequence
        wait(1); -- Wait for stopping animation/action
        -- Reset flags
        v20=false;
        v16=false;
        v15=false;
        v40.WalkSpeed = WALK_SPEED -- Restore speed
        -- Main loop will handle transition back to idle/walk/run animation
    end
end);

-- Main loop
while wait() do
    -- Determine movement state
    local isMoving = v40.MoveDirection.Magnitude > 0.1
    v30 = isMoving
    v37 = not isMoving

    -- If moving, ensure emote is stopped (Primary check)
    if isMoving and v33 then
        StopEmote()
    end

    -- State Machine (Priority Order)
    if v22 then -- E Key State (Action Active)
        -- Animation is playing from InputBegan
        -- Ensure speed is 0 during action
        if v40.WalkSpeed ~= ACTION_SPEED then v40.WalkSpeed = ACTION_SPEED end

    elseif v_r_acting then -- R Key State (Action Active)
        -- Animation is playing from InputBegan
        -- Ensure speed is 0 during action
        if v40.WalkSpeed ~= ACTION_SPEED then v40.WalkSpeed = ACTION_SPEED end

    elseif v16 then -- Q Key State (Action Active)
        if v15 then -- Q Stopping sequence
             -- Animation is playing from InputBegan
             -- Ensure speed is 0 during stop sequence
             if v40.WalkSpeed ~= ACTION_SPEED then v40.WalkSpeed = ACTION_SPEED end
        elseif v37 then -- Q Idle Anim (Not Moving)
             if (v9~=v18) then PlayAnimation(v18, true) end
             if v40.WalkSpeed ~= ACTION_SPEED then v40.WalkSpeed = ACTION_SPEED end
        else -- Q Moving Anim (Moving)
             if (v9~=v17) then PlayAnimation(v17, true) end
             if v40.WalkSpeed ~= Q_WALK_SPEED then v40.WalkSpeed = Q_WALK_SPEED end
        end

    elseif v33 then -- Emote State (Looping, only when standing still)
        if v37 then -- Only play emote if standing still
            -- Ensure correct emote is playing and looping
            if v9 ~= v_emote_anim_id or not v8.IsPlaying then
                PlayAnimation(v_emote_anim_id, true)
            end
            -- Speed should be WALK_SPEED, but character is not moving
            if v40.WalkSpeed ~= WALK_SPEED then v40.WalkSpeed = WALK_SPEED end
        else
            -- This case should not be reached if StopEmote() works on movement
            StopEmote()
        end

    -- *** NO ACTION/EMOTE ACTIVE ***
    elseif v30 and v14 then -- Running State (Moving & Shift)
         if (v9~=v23) then PlayAnimation(v23, true) end -- Play RUN animation (v23)
         if v40.WalkSpeed ~= RUN_SPEED then v40.WalkSpeed = RUN_SPEED end

    elseif v30 and not v14 then -- Walking State (Moving & NOT Shift)
         if (v9~=v10) then PlayAnimation(v10, true) end -- Play WALK animation (v10)
         if v40.WalkSpeed ~= WALK_SPEED then v40.WalkSpeed = WALK_SPEED end

    elseif v37 then -- Idle State (Not moving)
        if (v9~=v13) then PlayAnimation(v13, true) end
        if v40.WalkSpeed ~= WALK_SPEED then v40.WalkSpeed = WALK_SPEED end

    else -- Fallback (Should not happen)
        if (v9~=v13) then PlayAnimation(v13, true) end
        if v40.WalkSpeed ~= WALK_SPEED then v40.WalkSpeed = WALK_SPEED end
    end
end
