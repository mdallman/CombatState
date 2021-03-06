-- First, we create a namespace for our addon by declaring a top-level table that will hold everything else.
CombatState = {}
 
-- This isn't strictly necessary, but we'll use this string later when registering events.
-- Better to define it in a single place rather than retyping the same string.
CombatState.name = "CombatState"
 
-- Next we create a function that will initialize our addon
function CombatState:Initialize()
  self.inCombat = IsUnitInCombat("player")
  EVENT_MANAGER:RegisterForEvent(self.name, EVENT_PLAYER_COMBAT_STATE,self.OnPlayerCombatState)
end
 
-- Function to change combat State
function CombatState.OnPlayerCombatState(event, inCombat)  
  if inCombat ~= CombatState.inCombat then
    -- Updates the state of the player
    CombatState.inCombat = inCombat
    CombatStateIndicator:SetHidden(not inCombat)
    -- annouce the change
  end
end
 
-- Then we create an event handler function which will be called when the "addon loaded" event
-- occurs. We'll use this to initialize our addon after all of its resources are fully loaded.
function CombatState.OnAddOnLoaded(event, addonName)
  -- The event fires each time *any* addon loads - but we only care about when our own addon loads.
  if addonName == CombatState.name then
    CombatState:Initialize()
  end
end
 
-- Finally, we'll register our event handler function to be called when the proper event occurs.
EVENT_MANAGER:RegisterForEvent(CombatState.name, EVENT_ADD_ON_LOADED, CombatState.OnAddOnLoaded)