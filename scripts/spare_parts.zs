
craftingTable.addShapeless("raw_clay_plate", <item:spareparts:plates/raw_clay>, [<item:pamhc2foodcore:rolleritem>, <item:notreepunching:clay_brick>]);
// furnace.addRecipe("fired_clay_plate",<item:spareparts:plates/fired_clay>,<item:spareparts:plates/raw_clay>,0.2,5*20);
<recipetype:firing>.addJSONRecipe("fired_clay_plate", {ingredient:{item:"spareparts:plates/raw_clay"},result:"spareparts:plates/fired_clay",experience:0.2 as float, cookingtime:5*20});
