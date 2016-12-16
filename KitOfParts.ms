global pospy
global pospx
global posyv

global currentMesh
global currentIdx = 1
global posX = 1
global gridSize = 3

try(closeRolloutFloater NgridRolloutFloater) catch()

rollout Ngrid "Ngrid" width:401 height:550
(
	fn epfilt obj = classof obj == Editable_Poly
	groupBox 'grp7' "Choose Mesh" pos:[12,82] width:170 height:124 align:#left
	groupBox 'grp8' "Place Mesh Along Grid" pos:[189,8] width:198 height:527 align:#left
	groupBox 'grp9' "Modify Grid" pos:[13,220] width:170 height:316 align:#left
	pickButton 'pickMesh' "Pick Mesh" pos:[21,109] width:150 height:30 filter: epfilt align:#left
	spinner 'spnX' "Grid X axis" pos:[24,317] width:95 height:16 range:[-1000,1000,100] align:#left
	spinner 'spnY' "Grid Y axis" pos:[24,351] width:95 height:16 range:[-1000,1000,100] align:#left
	spinner 'spnZ' "Grid Z axis" pos:[24,385] width:95 height:16 range:[-1000,1000,100] align:#left
	colorPicker 'cp2' "Grid Color" pos:[24,419] width:143 height:50 align:#left
	button 'btn24' "Import Mesh" pos:[21,158] width:150 height:30 align:#left
	button 'btn25' "Create Grid" pos:[21,487] width:150 height:30 align:#left
	groupBox 'grp11' "Edge Mode" pos:[199,162] width:178 height:132 align:#left
	slider 'sld2' "Percent" pos:[213,231] width:152 height:44 align:#left
	pickButton 'pickWall2' "Pick Wall" pos:[208,340] width:156 height:31 filter: epfilt align:#left
	button 'btn33' "Place Mesh" pos:[206,450] width:163 height:30 align:#left
	button 'btn34' "Place Grid " pos:[206,490] width:163 height:30 align:#left
	--??? 'cust1' "???" pos:[15,11] width:162 height:45 align:#left
	dropDownList 'ddl1' "Layout" pos:[27,257] width:139 height:40 align:#left
	button 'ppbtn' "Prev" pos:[290,383] width:75 height:29 align:#left
	button 'pnbtn' "Next" pos:[208,383] width:75 height:29 align:#left
	groupBox 'grp13' "Polygon Mode" pos:[199,307] width:178 height:126 align:#left
	groupBox 'grp14' "Vertex Mode" pos:[201,27] width:178 height:126 align:#left
	pickButton 'pickWall' "Pick Wall" pos:[209,59] width:156 height:31 filter: epfilt align:#left
	button 'vpbtn' "Prev" pos:[291,102] width:75 height:29 align:#left
	button 'vnbtn' "Next" pos:[209,102] width:75 height:29 align:#left
	pickButton 'pickEdge' "Pick Edge" pos:[209,191] width:156 height:31 filter: epfilt align:#left
	
	on pickMesh picked node do
	(
	currentMesh = node
	print currentMesh.name
	)

	local asp = #()
	
	on pickPlane picked obj do if isValidNode obj do
	(
		if classOf obj.scale.track != ScaleXYZ do
			obj.scale.track = ScaleXYZ()
		local asc = getXYZControllers obj.scale.track
		for i = 1 to 3 do asp[i].controller = asc[i]
	)
	on RolloutTemplateG open do (asp = #(spnX, spnY, spnZ))
	
	on vnbtn pressed do	
		(
		currentIdx = currentIdx + 1
		currentIdx = mod currentIdx gridSize
		setPos()
	)
)

--creating the grid
porigin = Point pos:[0,0,0] isSelected:on
ngrid = Box name:"Ngrid" lengthsegs:3 widthsegs:3 heightsegs:3 length:200 width:200 height:200 pos [0,0,0] 

NgridRolloutFloater = newrolloutfloater "Ngrid" 400 570
addrollout Ngrid NgridRolloutFloater
--RolloutFloaterTemplate = newrolloutfloater "Kit Of Parts"  200 600
--addrollout RolloutTemplateP RolloutFloaterTemplate
--addrollout RolloutTemplateG RolloutFloaterTemplate
--addrollout RolloutTemplateS RolloutFloaterTemplate
--addrollout RolloutTemplateF RolloutFloaterTemplate

--py = ngrid
v_coords = for vID = 1 to ngrid.GetNumVertices() collect polyOp.getVert ngrid vID

fn setPos = (
print v_coords[currentIdx]
currentMesh.pos = v_coords[currentIdx]
)
