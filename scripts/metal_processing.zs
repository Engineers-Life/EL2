#priority 20

import crafttweaker.api.registries.IRecipeManager;

val scriptName = "metal_processing.zs";
println("BEGIN "+scriptName);

val gateGeolosysOres = true; // if true, geolosys ores won't smelt directly.

// the pick-stuff should be in a mekanism.zs
<tag:items:natural-progression:override_pickaxes>.add(<item:mekanism:meka_tool>);
<tag:items:natural-progression:override_pickaxes>.add(<item:mekanism:atomic_disassembler>);

// MEK RECIPES TO REPLACE:
//
// Crusher: forge:ingots/copper to dust
// Enrichment Chamber: forge:ores/copper to 2 immersiveengineering:dust_copper
// Enrichment Chamber: mekanism:dirty_dust/copper to immersiveengineering:dust_copper


// COPPER
removeAndHide(<item:geolosys:copper_nugget>);
removeAndHide(<item:mekanism:nugget_copper>);
removeFromListAndHide([craftingTable,blastFurnace],<item:geolosys:copper_ingot>);
removeFromListAndHide([craftingTable,blastFurnace,furnace],<item:mekanism:ingot_copper>);
removeAndHide(<item:mekanism:block_copper>);
if (!gateGeolosysOres) {
    blastFurnace.removeRecipe(<item:immersiveengineering:ingot_copper>);
    blastFurnace.addRecipe(scriptName+".ingot_copper_from_blasting",<item:immersiveengineering:ingot_copper>,<tag:items:forge:ores/copper>,0.6,5*20);
}

<recipetype:mekanism:crushing>.removeByName("mekanism:processing/copper/dust/from_ingot");
<recipetype:mekanism:enriching>.removeByName("mekanism:processing/copper/dust/from_ore");
<recipetype:mekanism:enriching>.removeByName("mekanism:processing/copper/dust/from_dirty_dust");
<recipetype:mekanism:crushing>.addJSONRecipe(scriptName+".copper/dust/from_ingot", {input:{ingredient:{tag:"forge:ingots/copper"}},output:{item:"immersiveengineering:dust_copper"}});
<recipetype:mekanism:enriching>.addJSONRecipe(scriptName+".copper/dust/from_ore", {input:{ingredient:{tag:"forge:ores/copper"}},output:{item:"immersiveengineering:dust_copper",count:2 as int}});
<recipetype:mekanism:enriching>.addJSONRecipe(scriptName+".copper/dust/from_dirty_dust", {input:{ingredient:{tag:"mekanism:dirty_dusts/copper"}},output:{item:"immersiveengineering:dust_copper"}});
removeAndHide(<item:mekanism:dust_copper>);

println("END "+scriptName);
