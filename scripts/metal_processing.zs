#priority 20

import crafttweaker.api.registries.IRecipeManager;

val scriptName = "metal_processing.zs";
println("BEGIN "+scriptName);

val gateGeolosysOres = true; // if true, geolosys ores won't smelt directly.

// the pick-stuff should be in a mekanism.zs
<tag:items:natural-progression:override_pickaxes>.add(<item:mekanism:meka_tool>);
<tag:items:natural-progression:override_pickaxes>.add(<item:mekanism:atomic_disassembler>);

// COPPER
removeAndHide(<item:geolosys:copper_nugget>);
removeAndHide(<item:mekanism:nugget_copper>);
removeFromListAndHide([craftingTable,blastFurnace],<item:geolosys:copper_ingot>);
removeFromListAndHide([craftingTable,blastFurnace,furnace],<item:mekanism:ingot_copper>);
removeAndHide(<item:mekanism:block_copper>);
if (!gateGeolosysOres) {
    blastFurnace.removeByName("immersiveengineering:crafting/ingot_copper_from_blasting");
    blastFurnace.addRecipe(scriptName+".ingot_copper_from_blasting",<item:immersiveengineering:ingot_copper>,<tag:items:forge:ores/copper>,0.6,5*20);
}
<recipetype:mekanism:crushing>.removeByName("mekanism:processing/copper/dust/from_ingot");
<recipetype:mekanism:enriching>.removeByName("mekanism:processing/copper/dust/from_ore");
<recipetype:mekanism:enriching>.removeByName("mekanism:processing/copper/dust/from_dirty_dust");
<recipetype:mekanism:crushing>.addJSONRecipe(scriptName+".copper/dust/from_ingot", {input:{ingredient:{tag:"forge:ingots/copper"}},output:{item:"immersiveengineering:dust_copper"}});
<recipetype:mekanism:enriching>.addJSONRecipe(scriptName+".copper/dust/from_ore", {input:{ingredient:{tag:"forge:ores/copper"}},output:{item:"immersiveengineering:dust_copper",count:2 as int}});
<recipetype:mekanism:enriching>.addJSONRecipe(scriptName+".copper/dust/from_dirty_dust", {input:{ingredient:{tag:"mekanism:dirty_dusts/copper"}},output:{item:"immersiveengineering:dust_copper"}});
removeAndHide(<item:mekanism:dust_copper>);
<recipetype:mekanism:combining>.addJSONRecipe(scriptName+".copper/ore/from_dust", {mainInput:{amount:8,ingredient:{tag:"forge:dusts/copper"}},extraInput:{ingredient:{tag:"forge:cobblestone"}},output:{item:"immersiveengineering:ore_copper"}});
removeFromListAndHide([<recipetype:mekanism:combining>],<item:mekanism:copper_ore>);

// LEAD
removeAndHide(<item:geolosys:lead_nugget>);
removeAndHide(<item:mekanism:nugget_lead>);
removeFromListAndHide([craftingTable,blastFurnace],<item:geolosys:lead_ingot>);
removeFromListAndHide([craftingTable,blastFurnace,furnace],<item:mekanism:ingot_lead>);
removeAndHide(<item:mekanism:block_lead>);
if (!gateGeolosysOres) {
    blastFurnace.removeByName("immersiveengineering:crafting/ingot_lead_from_blasting");
    blastFurnace.addRecipe(scriptName+".ingot_lead_from_blasting",<item:immersiveengineering:ingot_lead>,<tag:items:forge:ores/lead>,0.6,5*20);
}
<recipetype:mekanism:crushing>.removeByName("mekanism:processing/lead/dust/from_ingot");
<recipetype:mekanism:enriching>.removeByName("mekanism:processing/lead/dust/from_ore");
<recipetype:mekanism:enriching>.removeByName("mekanism:processing/lead/dust/from_dirty_dust");
<recipetype:mekanism:crushing>.addJSONRecipe(scriptName+".lead/dust/from_ingot", {input:{ingredient:{tag:"forge:ingots/lead"}},output:{item:"immersiveengineering:dust_lead"}});
<recipetype:mekanism:enriching>.addJSONRecipe(scriptName+".lead/dust/from_ore", {input:{ingredient:{tag:"forge:ores/lead"}},output:{item:"immersiveengineering:dust_lead",count:2 as int}});
<recipetype:mekanism:enriching>.addJSONRecipe(scriptName+".lead/dust/from_dirty_dust", {input:{ingredient:{tag:"mekanism:dirty_dusts/lead"}},output:{item:"immersiveengineering:dust_lead"}});
removeAndHide(<item:mekanism:dust_lead>);
<recipetype:mekanism:combining>.addJSONRecipe(scriptName+".lead/ore/from_dust", {mainInput:{amount:8,ingredient:{tag:"forge:dusts/lead"}},extraInput:{ingredient:{tag:"forge:cobblestone"}},output:{item:"immersiveengineering:ore_lead"}});
removeFromListAndHide([<recipetype:mekanism:combining>],<item:mekanism:lead_ore>);

// STEEL
removeAndHide(<item:mekanism:nugget_steel>);
removeFromListAndHide([craftingTable,blastFurnace,furnace],<item:mekanism:ingot_steel>);
removeAndHide(<item:mekanism:block_steel>);
<recipetype:mekanism:crushing>.removeByName("mekanism:processing/steel/ingot_to_dust");
<recipetype:mekanism:metallurgic_infusing>.removeByName("mekanism:processing/steel/enriched_iron_to_dust");
<recipetype:mekanism:crushing>.addJSONRecipe(scriptName+".steel/ingot_to_dust", {input:{ingredient:{tag:"forge:ingots/steel"}},output:{item:"immersiveengineering:dust_steel"}});
<recipetype:mekanism:metallurgic_infusing>.addJSONRecipe(scriptName+".steel/enriched_iron_to_dust",{itemInput:{ingredient:{item:"mekanism:enriched_iron"}},infusionInput:{amount:10,tag:"mekanism:carbon"},output:{item:"immersiveengineering:dust_steel"}});
removeAndHide(<item:mekanism:dust_steel>);

// URANIUM
removeAndHide(<item:mekanism:nugget_uranium>);
removeFromListAndHide([craftingTable,blastFurnace,furnace],<item:mekanism:ingot_uranium>);
removeAndHide(<item:mekanism:block_uranium>);
if (!gateGeolosysOres) {
    blastFurnace.removeByName("immersiveengineering:crafting/ingot_uranium_from_blasting");
    blastFurnace.addRecipe(scriptName+".ingot_uranium_from_blasting",<item:immersiveengineering:ingot_uranium>,<tag:items:forge:ores/uranium>,0.6,5*20);
}
<recipetype:mekanism:crushing>.removeByName("mekanism:processing/uranium/dust/from_ingot");
<recipetype:mekanism:enriching>.removeByName("mekanism:processing/uranium/dust/from_ore");
<recipetype:mekanism:enriching>.removeByName("mekanism:processing/uranium/dust/from_dirty_dust");
<recipetype:mekanism:crushing>.addJSONRecipe(scriptName+".uranium/dust/from_ingot", {input:{ingredient:{tag:"forge:ingots/uranium"}},output:{item:"immersiveengineering:dust_uranium"}});
<recipetype:mekanism:enriching>.addJSONRecipe(scriptName+".uranium/dust/from_ore", {input:{ingredient:{tag:"forge:ores/uranium"}},output:{item:"immersiveengineering:dust_uranium",count:2 as int}});
<recipetype:mekanism:enriching>.addJSONRecipe(scriptName+".uranium/dust/from_dirty_dust", {input:{ingredient:{tag:"mekanism:dirty_dusts/uranium"}},output:{item:"immersiveengineering:dust_uranium"}});
removeAndHide(<item:mekanism:dust_uranium>);
<recipetype:mekanism:combining>.addJSONRecipe(scriptName+".uranium/ore/from_dust", {mainInput:{amount:8,ingredient:{tag:"forge:dusts/uranium"}},extraInput:{ingredient:{tag:"forge:cobblestone"}},output:{item:"immersiveengineering:ore_uranium"}});
removeFromListAndHide([<recipetype:mekanism:combining>],<item:mekanism:uranium_ore>);


println("END "+scriptName);
