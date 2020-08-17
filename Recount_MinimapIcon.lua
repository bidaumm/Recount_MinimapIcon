RecountButton_Position = 0;
RecountButton_Locked = false;
RecountButton_Hover = false;
Minimap_Circle = {};
Minimap_Circle.X = 0;
Minimap_Circle.Y = 0;

function Recount_IconButton_OnClick(arg1)
	if (arg1 == "RightButton") then
		if Recount_MinimapFrame:IsVisible() then
			Recount_MinimapFrame:Hide();
		else
			Recount_MinimapFrame:Show();
		end
	elseif (arg1 == "LeftButton") then
		Recount_MinimapIcon_Toggle();
	end

end

function Recount_MinimapIcon_SetMinimap()
    Minimap_Circle.X = getglobal("Minimap"):GetWidth()+20;
    Minimap_Circle.Y = getglobal("Minimap"):GetHeight()+20;
    
    getglobal("Recount_ButtonLock_Text"):SetText("Lock");
    getglobal("Recount_ButtonConfig_Text"):SetText("Show Config");
    getglobal("Recount_ButtonReset_Text"):SetText("Reset Data");
end

function Recount_MinimapIcon_ShowTooltip()
    GameTooltip:SetOwner(Recount_IconButton, "ANCHOR_RIGHT");
    GameTooltip:AddLine("Recount", 1, 1, 0);
    GameTooltip:AddLine("Left click: Show Main Window", 1, 1, 1);
    GameTooltip:AddLine("Right click: Show Options", 1, 1, 1);
    GameTooltip:Show();
end

function Recount_MinimapIcon_Toggle()
    if Recount_MainWindow:IsVisible() then
        Recount_MainWindow:Hide();
    else
        Recount_MainWindow:Show();
    end
end

function Recount_MinimapIcon_UpdatePosition()
    Recount_IconButton:SetPoint(
		"TOPLEFT",
		"Minimap",
		"TOPLEFT",
		54 - (Minimap_Circle.X/2 * cos(RecountButton_Position)),
		(Minimap_Circle.Y/2 * sin(RecountButton_Position)) - 55
	);
end

function Recount_MinimapIcon_Drag()
    --thanks to Atlas addon for this code
    local xpos, ypos = GetCursorPosition();
    local xmin, ymin = Minimap:GetLeft(), Minimap:GetBottom();

    xpos = xmin-xpos/UIParent:GetScale()+70;
    ypos = ypos/UIParent:GetScale()-ymin-70;

    Recount_MinimapIcon_SetPosition(math.deg(math.atan2(ypos, xpos)));
end

function Recount_MinimapIcon_SetPosition(pos)
    if (pos < 0) then
        pos = pos + 360;
    end

    RecountButton_Position = pos;
    Recount_MinimapIcon_UpdatePosition();
end

function Recount_MinimapIcon_OnLoad()
    Recount:RegisterEvent("MINIMAP_HIDE");
    if (RecountButton_Locked) then
        getglobal("Recount_IconButton").locked = true;
        getglobal("Recount_ButtonLock_Text"):SetText("Un-Lock");
    else
        getglobal("Recount_IconButton").locked = false;
        getglobal("Recount_ButtonLock_Text"):SetText("Lock");
    end
end

function Recount:MINIMAP_HIDE()
    Recount_MinimapFrame:Hide()
end
