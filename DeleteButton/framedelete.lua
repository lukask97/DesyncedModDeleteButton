local m_layout_delete = [[
		<Box padding=4 dock=bottom-right x=-4 y=-340 >
			<VerticalList child_padding=4>
				<Button width=50 height=50 icon=m_icon50_delete id=btn_delete window=Tech on_click={on_delete}/>
			</VerticalList>
		</Box>
]]
local M_Frameview_Delete = {}
UI.Register("M_Frameview_Delete", m_layout_delete, M_Frameview_Delete)

function M_Frameview_Delete:construct()	
end

function M_Frameview_Delete:on_delete()
	local val =View.GetSelectedEntities() -- Get currently selected units/buildings
	massdeconstruct(val)
end