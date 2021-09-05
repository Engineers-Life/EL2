#priority 20

import crafttweaker.api.blocks.MCBlock;
import crafttweaker.api.BracketHandlers;
import crafttweaker.api.registries.IRecipeManager;

val scriptName = "metal_processing.zs";
println("BEGIN "+scriptName);

val gateGeolosysOres = true; // if true, geolosys ores won't smelt directly.

// the pick-stuff should be in a mekanism.zs
<tag:items:natural-progression:override_pickaxes>.add(<item:mekanism:meka_tool>);
<tag:items:natural-progression:override_pickaxes>.add(<item:mekanism:atomic_disassembler>);

function removeBasicDust(scriptName as string, material as string) as void {
    <recipetype:mekanism:crushing>.removeByName("mekanism:processing/"+material+"/dust/from_ingot");
    <recipetype:mekanism:enriching>.removeByName("mekanism:processing/"+material+"/dust/from_ore");
    <recipetype:mekanism:enriching>.removeByName("mekanism:processing/"+material+"/dust/from_dirty_dust");
    <recipetype:mekanism:crushing>.addJSONRecipe(scriptName+"."+material+".dust/from_ingot", {input:{ingredient:{tag:"forge:ingots/"+material}},output:{item:"immersiveengineering:dust_"+material}});
    <recipetype:mekanism:enriching>.addJSONRecipe(scriptName+"."+material+".dust/from_ore", {input:{ingredient:{tag:"forge:ores/"+material}},output:{item:"immersiveengineering:dust_"+material,count:2 as int}});
    <recipetype:mekanism:enriching>.addJSONRecipe(scriptName+"."+material+".dust/from_dirty_dust", {input:{ingredient:{tag:"mekanism:dirty_dusts/"+material}},output:{item:"immersiveengineering:dust_"+material}});
    removeAndHide(BracketHandlers.getItem("mekanism:dust_"+material));
}

function removeBlockTags(block as MCBlock) as void {
    for tag in<tagManager:blocks>.getAllTagsFor(block){
        tag.remove(block);
    }
}

function removeGeoMetal(scriptName as string, material as string) as void{
    removeAndHide(BracketHandlers.getItem("geolosys:"+material+"_nugget"));
    removeFromListAndHide([craftingTable,blastFurnace],BracketHandlers.getItem("geolosys:"+material+"_ingot"));
}

function removeCompleteMetal(scriptName as string, material as string, gateGeolosysOres as bool, hasGeoNuggetIngot as bool) as void {
    removeBasicDust(scriptName,material);
    if (hasGeoNuggetIngot) {
        removeGeoMetal(scriptName,material);
    }
    removeAndHide(BracketHandlers.getItem("mekanism:nugget_"+material));
    removeFromListAndHide([craftingTable,blastFurnace,furnace],BracketHandlers.getItem("mekanism:ingot_"+material));
    removeBlockTags(BracketHandlers.getBlock("mekanism:block_"+material));
    removeAndHide(BracketHandlers.getItem("mekanism:block_"+material));
    if (!gateGeolosysOres) {
        blastFurnace.removeByName("immersiveengineering:crafting/ingot_"+material+"_from_blasting");
        blastFurnace.addJSONRecipe(scriptName+".ingot."+material+".from_blasting",{result:"immersiveengineering:ingot_"+material,ingredient:{tag:"forge:ores/"+material},experience:0.6 as float,cookingtime:5*20 as int});
    }
    <recipetype:mekanism:combining>.addJSONRecipe(scriptName+"."+material+".ore/from_dust", {mainInput:{amount:8,ingredient:{tag:"forge:dusts/"+material}},extraInput:{ingredient:{tag:"forge:cobblestone"}},output:{item:"immersiveengineering:ore_"+material}});
    removeFromListAndHide([<recipetype:mekanism:combining>],BracketHandlers.getItem("mekanism:"+material+"_ore"));
}

for material in ["gold","iron"] {
    removeBasicDust(scriptName,material);
}

for material in ["copper","lead"] {
    removeCompleteMetal(scriptName,material,gateGeolosysOres,true);
}

for material in ["uranium"] {
    removeCompleteMetal(scriptName,material,gateGeolosysOres,false);
}

// STEEL
removeAndHide(<item:mekanism:nugget_steel>);
removeFromListAndHide([craftingTable,blastFurnace,furnace],<item:mekanism:ingot_steel>);
removeAndHide(<item:mekanism:block_steel>);
<recipetype:mekanism:crushing>.removeByName("mekanism:processing/steel/ingot_to_dust");
<recipetype:mekanism:metallurgic_infusing>.removeByName("mekanism:processing/steel/enriched_iron_to_dust");
<recipetype:mekanism:crushing>.addJSONRecipe(scriptName+".steel/ingot_to_dust", {input:{ingredient:{tag:"forge:ingots/steel"}},output:{item:"immersiveengineering:dust_steel"}});
<recipetype:mekanism:metallurgic_infusing>.addJSONRecipe(scriptName+".steel/enriched_iron_to_dust",{itemInput:{ingredient:{item:"mekanism:enriched_iron"}},infusionInput:{amount:10,tag:"mekanism:carbon"},output:{item:"immersiveengineering:dust_steel"}});
removeAndHide(<item:mekanism:dust_steel>);

println("END "+scriptName);
