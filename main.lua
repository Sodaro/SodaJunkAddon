local frame = CreateFrame("FRAME", "SodaTestFrame");
frame:RegisterEvent("PLAYER_ENTERING_WORLD");
frame:RegisterEvent("MERCHANT_SHOW");
frame:RegisterEvent("MERCHANT_UPDATE");
soldItems = 0;
sellValue = 0;
bag = 0;
slot = 1;
local function eventHandler(self, event, ...)
  if (event == "MERCHANT_SHOW") then
    soldItems = 0;
    sellValue = 0;
    sellItems(bag, slot);
  end
end

frame:SetScript("OnEvent", eventHandler);

function sellItems(bag, slot)
  for bag = 0,4 do
    numberOfSlots = GetContainerNumSlots(bag);
    for slot = 1,numberOfSlots do
      texture, itemCount, locked, quality, readable, lootable, itemLink = GetContainerItemInfo(bag, slot);
      if(quality == 0) then
        itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(itemLink)
        sellValue = sellValue + itemSellPrice;
        soldItems = soldItems + 1;
        if (soldItems % 13 == 0) then
          C_Timer.After(1, function()UseContainerItem(bag, slot)end)
        else
          UseContainerItem(bag, slot)
        end
      end
    end
  end
  if (soldItems ~= 0) then
    formattedAmount = GetCoinTextureString(sellValue);
		print("SodaJunkSeller sold: ", soldItems, " items, for:", formattedAmount);
	end
end

-- function sellItemsInBag(bag)
--     numberOfSlots = GetContainerNumSlots(bag);
--     for slot = 1,numberOfSlots do
--       texture, itemCount, locked, quality, readable, lootable, itemLink = GetContainerItemInfo(bag, slot);
--       if(quality == 0) then
--         itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(itemLink)
--         sellValue = sellValue + itemSellPrice;
--         soldItems = soldItems + 1;
--         UseContainerItem(bag, slot)
--         -- if (soldItems ~= 0) then
--         --   C_Timer.After(soldItems/5, function() UseContainerItem(bag, slot) end)
--         -- end
--         if (soldItems ~= 10) then
--           C_Timer.After(soldItems/10, function()  end)
--         end

--       end
--     end
--   end
