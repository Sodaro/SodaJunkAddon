local frame = CreateFrame("FRAME", "SodaTestFrame");
frame:RegisterEvent("PLAYER_ENTERING_WORLD");
frame:RegisterEvent("MERCHANT_SHOW");
frame:RegisterEvent("MERCHANT_UPDATE");
frame:RegisterEvent("MERCHANT_CLOSED");

soldItems = 0;

local function eventHandler(self, event, ...)
  if (event == "MERCHANT_SHOW") then
    soldItems = 0;
    sellItems();
  end
end

frame:SetScript("OnEvent", eventHandler);

function sellItems(self)

  -- for bag = 0,4 do
  --   numberOfSlots = GetContainerNumSlots(bag);
  --   for slot = 0,numberOfSlots do
  --     texture, itemCount, locked, quality, readable, lootable, itemLink = GetContainerItemInfo(bag, slot);
  --     if(quality == 0) then
  --       UseContainerItem(bag, slot)
  --       soldItems = soldItems + 1;
  --       if (soldItems % 10 == 0) and (soldItems ~= 0) then
  --         C_Timer.After(0.1,sellItems);
  --         return;
  --       end
  --     end
  --   end
  -- end
  for bag = 0,4 do
    sellItemsInBag(bag);
  end
  if (soldItems ~= 0) then
		print("SodaJunkSeller sold: ", soldItems, " items.")
	end
end

function sellItemsInBag(bag)
    numberOfSlots = GetContainerNumSlots(bag);
    for slot = 1,numberOfSlots do
      texture, itemCount, locked, quality, readable, lootable, itemLink = GetContainerItemInfo(bag, slot);
      if(quality == 0) then
        soldItems = soldItems + 1;
        if (soldItems ~= 0) then
          C_Timer.After(soldItems/10, function() UseContainerItem(bag, slot) end)
        end
      end
    end
  end
