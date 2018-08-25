local frame = CreateFrame("FRAME", "SodaTestFrame");
--texture, itemCount, locked, quality, readable, lootable, itemLink = GetContainerItemInfo(b, s);
frame:RegisterEvent("PLAYER_ENTERING_WORLD");
frame:RegisterEvent("MERCHANT_SHOW");
frame:RegisterEvent("MERCHANT_UPDATE");
frame:RegisterEvent("MERCHANT_CLOSED");
--numberOfSlots = GetContainerNumSlots(b);

soldItems = 0;

local function eventHandler(self, event, ...)
  if (event == "MERCHANT_SHOW") then
    soldItems = 0;
    sellItems();
  end
  if (event == "MERCHANT_CLOSED") then
    --print("closed")
  end
end

frame:SetScript("OnEvent", eventHandler);

function sellItems(self)
  for bag = 0,4 do
    numberOfSlots = GetContainerNumSlots(bag);
    for slot = 0,numberOfSlots do
      texture, itemCount, locked, quality, readable, lootable, itemLink = GetContainerItemInfo(bag, slot);
      if(quality == 0) then
        UseContainerItem(bag, slot)
        soldItems = soldItems + 1;
        if (soldItems % 10 == 0) and (soldItems ~= 0) then
          C_Timer.After(2,sellItems);
          return;
        end
      end
    end
  end
  if(soldItems == 0) then
    print("no sellable junk found")
  else
    print ("sold: ", soldItems, " items.")
  end
end