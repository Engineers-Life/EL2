
import crafttweaker.api.BracketHandlers;
import crafttweaker.api.item.IIngredient;
import crafttweaker.api.mods.Mods;

val bricksAreBetter = true; // transfer all missing recipes into modded block

// Data reminders:
// Recipe Manager	Bracket Handler	                    Global Variable
// Blasting	        <recipetype:minecraft:blasting>	    blastFurnace
// Campfire Cooking	<recipetype:minecraft:campfire_cooking>	campfire
// Crafting	        <recipetype:minecraft:crafting>	    craftingTable
// Smelting	        <recipetype:minecraft:smelting>	    furnace
// Smithing	        <recipetype:minecraft:smithing>	    smithing
// Smoking	        <recipetype:minecraft:smoking>	    smoker
// Stone Cutting	<recipetype:minecraft:stonecutting>	stoneCutter

// Remove recipes here is to prevent them from being moved into an alternative
<recipetype:blasting>.removeRecipe(<item:mapperbase:steel_ingot>);
<recipetype:blasting>.removeRecipe(<item:mapperbase:steel_plate>);
<recipetype:blasting>.removeRecipe(<item:bigreactors:yellorium_ingot>);
<recipetype:blasting>.removeRecipe(<item:bigreactors:graphite_ingot>);
furnace.removeRecipe(<item:minecraft:charcoal>);
furnace.removeRecipe(<item:industrialforegoing:plastic>);
furnace.removeRecipe(<item:bigreactors:yellorium_ingot>);
furnace.removeRecipe(<item:bigreactors:cyanite_ingot>);
furnace.removeRecipe(<item:bigreactors:graphite_ingot>);

// only use ingredients from mods that you know are in the pack
val air = <item:minecraft:air>;
var log = <tag:items:minecraft:logs>;
val cobble = <tag:items:forge:cobblestone>;
val smooth_stone = <item:minecraft:smooth_stone>;
val brick = <item:minecraft:brick>;
val brick_block = <item:minecraft:bricks>;
val clay_plate = <item:spareparts:plates/fired_clay>;
val terracotta = <item:minecraft:terracotta>;
val smoker_block = <item:minecraft:smoker>;
val furnace_block = <item:minecraft:furnace>;
val blast_furnace_block = <item:minecraft:blast_furnace>;

// may include mods not in the pack.  Will check if mod is loaded before processing
val recipeGroups = {
    "Smelting" : {
        minecraft : "minecraft:smelting",
        charm : "minecraft:firing",
        brickfurnace : "brickfurnace:smelting"
    },
    "Blasting" : {
        minecraft : "minecraft:blasting",
        brickfurnace : "brickfurnace:blasting"
    },
    "Smoking" : {
        minecraft : "minecraft:smoking",
        brickfurnace : "brickfurnace:smoking"
    } } as string[string][string];
val defaultValues = {
    "Smelting" : { xp : 0.1, cookTime : 10*20 },
    "Blasting" : { xp : 0.2, cookTime :  5*20 },
    "Smoking"  : { xp : 0.2, cookTime :  5*20 }
};

val blockRecipes = {
        minecraft : {
            "minecraft:furnace" : [[cobble,cobble,cobble],[cobble,air,cobble],[cobble,cobble,cobble]],
            "minecraft:blast_furnace" : [[clay_plate,clay_plate,clay_plate],[clay_plate,furnace_block,clay_plate],[smooth_stone,smooth_stone,smooth_stone]],
            "minecraft:smoker" : [[air,log,air],[log,furnace_block,log],[air,log,air]]
        },
        charm : {
            "charm:kiln" : [[air,brick_block,air],[brick_block,furnace_block,brick_block],[air,brick_block,air]]
        },
        brickfurnace : {
            "brickfurnace:brick_furnace" : [[brick,brick,brick],[brick,furnace_block,brick],[terracotta,terracotta,terracotta]],
            "brickfurnace:brick_blast_furnace" : [[clay_plate,clay_plate,clay_plate],[clay_plate,blast_furnace_block,clay_plate],[terracotta,terracotta,terracotta]],
            "brickfurnace:brick_smoker" : [[brick,brick,brick],[brick,smoker_block,brick],[brick,brick,brick]]
        } } as IIngredient[][][string][string];

// move recipes
for group, groupData in recipeGroups {      println("Iterating "+group+" recipes.");
    for modid, recipe_type in groupData {   //println("* Iterating recipes for "+modid+".");
        if loadedMods.isModLoaded(modid) {  //println("* * "+modid+" is loaded.");
            if (modid != "minecraft" && bricksAreBetter && "minecraft" in groupData) { println("* * Bricks are Better.");
                val vanillaManager = BracketHandlers.getRecipeManager(groupData["minecraft"]);
                println("MANAGER: "+recipe_type);
                val moddedManager = BracketHandlers.getRecipeManager(recipe_type);
                for wrapper in vanillaManager.getAllRecipes() {
                    val output = wrapper.output;
                    //println("* * Reviewing recipe for "+output.translationKey);
                    val xp = defaultValues[group]["xp"];           // can't figure out how to access this data!
                    val time = defaultValues[group]["cookTime"];    // doesn't seem possible to get
                    val moddedRecipes = moddedManager.getRecipesByOutput(output);
                    for vanillaIngredient in wrapper.ingredients {
                        for vanillaItem in vanillaIngredient.items {
                            var existingRecipe = false;
                            //println("* * Reviewing ingredient "+vanillaItem.translationKey);
                            for moddedWrapper in moddedRecipes {
                                for moddedIngredient in moddedWrapper.ingredients {
                                    for moddedItem in moddedIngredient.items {
                                        existingRecipe = existingRecipe || (moddedItem.matches(vanillaItem));
                                    }
                                }
                            }
                            if (!existingRecipe) {
                                moddedManager.addJSONRecipe(modid+"."+vanillaItem.translationKey, {ingredient:{item:vanillaItem.registryName},result:output.registryName,experience:xp as float,cookingtime:time as int});
                            }
                        }
                    }
                }
            }
        }
    }
}

// change block recipes
for modid, blockData in blockRecipes {
    if loadedMods.isModLoaded(modid) {
        for block_id, recipe in blockData {
            val item = BracketHandlers.getItem(block_id);
            craftingTable.removeRecipe(item);
            craftingTable.addShaped(block_id, item, recipe);
        }
    }
}

// remove furnace recipes IF there is another option in that recipeGroup
if (bricksAreBetter && recipeGroups["Smelting"].size>1) {
    val manager = BracketHandlers.getRecipeManager(recipeGroups["Smelting"]["minecraft"]);
    manager.removeRecipe(<item:minecraft:brick>);
    manager.removeRecipe(<item:notreepunching:ceramic_large_vessel>);
    manager.removeRecipe(<item:notreepunching:ceramic_small_vessel>);
    manager.removeRecipe(<item:notreepunching:ceramic_bucket>);
    manager.removeRecipe(<item:minecraft:flower_pot>);
	manager.removeRecipe(<item:minecraft:nether_brick>);
	manager.removeRecipe(<item:minecraft:smooth_sandstone>);
	manager.removeRecipe(<item:minecraft:smooth_red_sandstone>);
	manager.removeRecipe(<item:minecraft:glass>);
	manager.removeRecipe(<item:minecraft:glass>);
    // manager.removeRecipe(<item:minecraft:terracotta>);
	manager.removeRecipe(<item:minecraft:sandstone>);
	manager.removeRecipe(<item:minecraft:red_sandstone>);
	manager.removeRecipe(<item:minecraft:light_gray_glazed_terracotta>);
	manager.removeRecipe(<item:minecraft:black_glazed_terracotta>);
	manager.removeRecipe(<item:minecraft:magenta_glazed_terracotta>);
	manager.removeRecipe(<item:minecraft:light_blue_glazed_terracotta>);
	manager.removeRecipe(<item:minecraft:purple_glazed_terracotta>);
	manager.removeRecipe(<item:minecraft:pink_glazed_terracotta>);
	manager.removeRecipe(<item:minecraft:brown_glazed_terracotta>);
	manager.removeRecipe(<item:minecraft:red_glazed_terracotta>);
	manager.removeRecipe(<item:minecraft:white_glazed_terracotta>);
	manager.removeRecipe(<item:minecraft:yellow_glazed_terracotta>);
	manager.removeRecipe(<item:minecraft:cyan_glazed_terracotta>);
	manager.removeRecipe(<item:minecraft:green_glazed_terracotta>);
	manager.removeRecipe(<item:minecraft:orange_glazed_terracotta>);
	manager.removeRecipe(<item:minecraft:lime_glazed_terracotta>);
	manager.removeRecipe(<item:minecraft:gray_glazed_terracotta>);
	manager.removeRecipe(<item:minecraft:blue_glazed_terracotta>);
	manager.removeRecipe(<item:minecraft:flower_pot>);
	manager.removeRecipe(<item:notreepunching:ceramic_bucket>);
	manager.removeByName("notreepunching:smelting/large_vessel");
	manager.removeByName("notreepunching:smelting/small_vessel");
}
