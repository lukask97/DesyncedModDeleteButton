function UIMsg.OnEntitySelected(entities)
	local old_open_frame_view = open_frame_view
	if open_frame_view then
		if #entities == 1 and open_frame_view.entity == entities[1] then
			-- already open
			return
		end
		open_frame_view:RemoveFromParent()
		open_frame_view = nil
	end
	if entities and #entities > 0 then
		open_frame_view = UI.AddLayout("M_Frameview_Delete",entities)
	end
end

function massdeconstruct(ent)
	Action.SendForSelectedEntities("SetPowerDown", { val = true})
	Action.SendForSelectedEntities("delete",{entities  = ent})
end

function EntityAction.delete(entities,arg)
	--local lastTick = Map.GetTick()
	for i=#arg.entities, 1, -1 do
		-- while lastTick == Map.GetTick() do 
		-- 	--nothing
		-- end
		--print("Delete Entity:".. tostring(arg.entities[i]))
		arg.entities[i]:Destroy()
		--lastTick = Map.GetTick()
	end
end

