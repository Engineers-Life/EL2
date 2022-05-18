import crafttweaker.api.BracketHandlers;

println("BEGIN spare_parts");

// BEGIN CONFIG:
val hide_unused_spareparts = false;
val used_spareparts = ["coins/wooden_coin","coins/stone_coin","coins/copper_coin","coins/iron_coin","coins/golden_coin","coins/diamond_coin","coins/monster_coin","coins/ancient_coin", "plates/raw_clay","plates/fired_clay"];
// END CONFIG

craftingTable.addShapeless("raw_clay_plate", <item:spareparts:plates/raw_clay>, [<item:pamhc2foodcore:rolleritem>, <item:notreepunching:clay_brick>]);

val kilnOptions = {
    "charm"         : "charm:firing",
    "brickfurnace"  : "brickfurnace:smelting" };

var foundKiln = false;
for modid, recipeType in kilnOptions {
    if (loadedMods.isModLoaded(modid)) {
        foundKiln = true;
        BracketHandlers.getRecipeManager(recipeType).addJSONRecipe("fired_clay_plate", {ingredient:{item:"spareparts:plates/raw_clay"},result:"spareparts:plates/fired_clay",experience:0.2 as float, cookingtime:5*20});
    }
}
if (!foundKiln) {
    furnace.addRecipe("fired_clay_plate",<item:spareparts:plates/fired_clay>,<item:spareparts:plates/raw_clay>,0.2,5*20);
}

craftingTable.addJSONRecipe("experience_journal", {
  "type": "immersiveengineering:turn_and_copy",
  "pattern": [ " x ", "ewe", " x " ],
  "key": {
    "x": { "item": "minecraft:experience_bottle" },
    "e": { "item": "minecraft:ender_eye" },
    "w": { "item": "minecraft:writable_book" }
  },
  "result": {
    "item": "spareparts:experience_journal",
    "count": 1
  },
  "quarter_turn": true } );

if (hide_unused_spareparts) { mods.jei.JEI.hideMod("spareparts", (name as string) => { return (name in used_spareparts); }); }

println("END spare_parts");
