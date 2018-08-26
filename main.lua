local frame = CreateFrame("FRAME", "SodaTestFrame");
frame:RegisterEvent("PLAYER_ENTERING_WORLD");
frame:RegisterEvent("MERCHANT_SHOW");
soldItems = 0;
sellValue = 0;
local function eventHandler(self, event, ...)
  if (event == "MERCHANT_SHOW") then
    soldItems = 0;
    sellValue = 0;
    C_Timer.After(1,sellItems);
  end
end

frame:SetScript("OnEvent", eventHandler);

function sellItems(self)
  for bag = 0,4 do
    numberOfSlots = GetContainerNumSlots(bag);
    for slot = 1,numberOfSlots do
      texture, itemCount, locked, quality, readable, lootable, itemLink = GetContainerItemInfo(bag, slot);
      if(quality == 0) then
        itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(itemLink)
        sellValue = sellValue + itemSellPrice;
        soldItems = soldItems + 1;
        --print (soldItems, itemLink);
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
		print("SodaJunkSeller sold:", soldItems, "items, for:", formattedAmount);
	end
end
