local cm_creative_deconstructor = Comp:RegisterComponent("cm_creative_deconstructor", {
    name = "Creative Deconstructor",
    texture = "Main/textures/icons/components/Component_Deconstructor_01_S.png",
    desc = "Allows disassembly of completed Units and Building refunding 100% of their cost",
    production_recipe = CreateProductionRecipe({ }, { c_fabricator = 1 }),
    power = 0,
    attachment_size = "Internal",
    race = "robot",
    activation = "Always",
    registers = {
        { type = "entity", tip = "Preferred Target", ui_icon = "icon_target", click_action = true },
    },

    range = 500000,
    duration = 2,
})


function cm_creative_deconstructor:action_tooltip() return L("Set %s Target", self.name) end
function cm_creative_deconstructor:action_click(comp, widget)
	CursorChooseEntity("Select the deconstruction target", function (target)
		if not comp.exists then return end -- got destroyed
		local arg = { comp = comp , reg = { entity = target } }
		Action.SendForEntity("SetRegister", comp.owner, arg)
	end)
end

function cm_creative_deconstructor:get_reg_error(comp)

end

function cm_creative_deconstructor:on_update(comp, cause)
	print("Once")
	if not deleteflag then
		local target_entity =  getnextdeconstruction()
		comp:SetRegisterEntity(1,target_entity)
		if not havenextdeconstruction() then return end
	end
	print("Help")
	-- We are starting or finishing work on an entity, make sure its (still) our faction
	print("PLS")
	-- If work was finished, make sure the target entity did not change just now
	if cause & (CC_FINISH_WORK | CC_CHANGED_REGISTER_ENTITY) == CC_FINISH_WORK then
		-- Destroy target then turn off (drop frame definition ingredients along inventory)
		if not IsDroppedItem(target_entity) then
			target_entity:Destroy(true, target_recipe and target_recipe.ingredients, comp.owner)
			deleteflag = true
			comp:SetRegister(1, 0)
		end
	end

	print("Fast")

	if cause & CC_REFRESH == CC_REFRESH then
		-- Just refreshing, continue work
		return comp:SetStateContinueWork()
	end

	-- Start deconstruct work (the passed true indicates we want to be occasionally refreshed to check if work needs to continue)
	return comp:SetStateStartWork(self.duration, true)
end
