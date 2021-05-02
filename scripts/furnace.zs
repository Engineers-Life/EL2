
import crafttweaker.api.BracketHandlers;
import crafttweaker.api.item.IIngredient;
import crafttweaker.api.mods.Mods;
import stdlib.List;

println("BEGIN furnace.zs");

val bricksAreBetter = true; // transfer all missing recipes into modded block

val REMOVE_FOOD_FROM_FURNACE = false;
val REMOVE_ALL_INGOTS_FROM_FURNACE = false;

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
blastFurnace.removeRecipe(<item:mapperbase:steel_ingot>);
blastFurnace.removeRecipe(<item:mapperbase:steel_plate>);
blastFurnace.removeRecipe(<item:bigreactors:yellorium_ingot>);
blastFurnace.removeRecipe(<item:bigreactors:graphite_ingot>);
furnace.removeRecipe(<item:minecraft:charcoal>);
furnace.removeRecipe(<item:industrialforegoing:plastic>);
furnace.removeRecipe(<item:bigreactors:yellorium_ingot>);
furnace.removeRecipe(<item:bigreactors:cyanite_ingot>);
furnace.removeRecipe(<item:bigreactors:graphite_ingot>);

mods.jei.JEI.hideItem(<item:veggie_way:fried_egg>);
furnace.removeRecipe(<item:veggie_way:fried_egg>);
smoker.removeRecipe(<item:veggie_way:fried_egg>);
mods.jei.JEI.hideItem(<item:simplefarming:cooked_egg>);
furnace.removeRecipe(<item:simplefarming:cooked_egg>);
campfire.removeRecipe(<item:simplefarming:cooked_egg>);
smoker.removeRecipe(<item:simplefarming:cooked_egg>);
<recipetype:charm:firing>.removeByName("charm:kilns/brick");

println("BEGIN furnace.metal_processing");

// remove making dust from ores in crafting table
var removeList = new List<string>();
for wrapper in craftingTable.getRecipesByOutput(<tag:items:forge:dusts>) {
    if (wrapper.ingredients[0].items[0] in <tag:items:forge:ores>) {
        removeList.add(wrapper.id);
    }
}
for recipeName in removeList {
    craftingTable.removeByName(recipeName);
}

// remove processing ores in furnace
for wrapper in furnace.getAllRecipes() {
    if (wrapper.ingredients[0].items[0] in <tag:items:forge:ores>.getElements()) {
        if (REMOVE_ALL_INGOTS_FROM_FURNACE) { furnace.removeRecipe(wrapper.output); }
        else { furnace.removeByName(wrapper.id); }
    }
}

// move melting items into nuggets from furnace into blast furnace
// only adds recipe to blast furnace if recipe doesn't already exist there
// iterates every furnace recipe, checks if the output is a nugget
// if it is a nugget, iterates through all the items that can produce that nugget
// for each of those, iterates through all the blast furnace recipes that also produce that nugget
// if any of the blast furnace recipes use the same input as the item being checked, it won't add the recipe
// because the recipe already exists.  If none of the blast furnace recipes use that item
// then the item is a quark trowel, because that's the only thing this whole section manages to find
// but let's keep it, in case mods change, cause this code will catch that.
for furnaceWrapper in furnace.getAllRecipes() {
    if (furnaceWrapper.output in <tag:items:forge:nuggets>.getElements()) {
        val nugget = furnaceWrapper.output;
        val blastRecipes = blastFurnace.getRecipesByOutput(nugget);
        // println("Evaluating furnace recipe that outputs: "+nugget.displayName);
        for furnaceIngredient in furnaceWrapper.ingredients {
            for furnaceItem in furnaceIngredient.items {
                // println("Evaluating furnace recipe that converts "+furnaceItem.displayName+" into "+nugget.displayName);
                var foundInBlastFurnace = false;
                for blastWrapper in blastRecipes {
                    for blastIngredient in blastWrapper.ingredients {
                        for blastItem in blastIngredient.items {
                            foundInBlastFurnace = foundInBlastFurnace || (blastItem.matches(furnaceItem));
                        }
                    }
                }
                if (!foundInBlastFurnace) {
                    //println("Couldn\'t find blast furnace recipe that converts "+furnaceItem.displayName+" into "+nugget.displayName+", adding it.");
                    blastFurnace.addRecipe("melt."+furnaceItem.translationKey,nugget,furnaceItem,0.1,5*20);
                }
            }
        }
    }
}
// this is part of the above, but pulled out of the loop in case more than one recipe makes the same nugget.
for furnaceWrapper in furnace.getAllRecipes() {
    if (furnaceWrapper.output in <tag:items:forge:nuggets>.getElements()) {
        furnace.removeRecipe(furnaceWrapper.output);
    }
}

println("END furnace.metal_processing");

// FOODS
println("BEGIN furnace.food_processing");
// tofu wasn't a food item, so fixing before moving foods to smoker.
removeAndHide(<item:veggie_way:fresh_tofu>);
removeFromList([blastFurnace,campfire,furnace,smoker],<item:simplefarming:tofu>);
blendTags(<item:veggie_way:soybean>,<item:simplefarming:soybean>);
craftingTable.addShapeless("fresh_tofu",<item:simplefarming:tofu>,[<tag:items:forge:buckets/water>,<tag:items:forge:crops/soybean>]);
furnace.removeRecipe(<item:veggie_way:cooked_tofu>);
campfire.addRecipe("cooked_tofu_campfire",<item:veggie_way:cooked_tofu>,<item:simplefarming:tofu>, 0.2, 5*20);
smoker.addRecipe("cooked_tofu_smoker",<item:veggie_way:cooked_tofu>,<item:simplefarming:tofu>, 0.2, 5*20);
<item:veggie_way:cooked_tofu>.food=<item:simplefarming:tofu>.food;
// remove food from furnace (if REMOVE_FOOD_FROM_FURNACE is true), moving to smoker if not present.
for furnaceWrapper in furnace.getAllRecipes() {
    if (furnaceWrapper.output.food != null) {
        val smokerRecipes = smoker.getRecipesByOutput(furnaceWrapper.output);
        for furnaceIngredient in furnaceWrapper.ingredients {
            for furnaceItem in furnaceIngredient.items {
                var foundInSmoker = false;
                for smokerWrapper in smokerRecipes {
                    for smokerIngredient in smokerWrapper.ingredients {
                        for smokerItem in smokerIngredient.items {
                            foundInSmoker = foundInSmoker || (smokerItem.matches(furnaceItem));
                        }
                    }
                }
                if (!foundInSmoker) {
                    smoker.addRecipe("food."+furnaceItem.translationKey,furnaceWrapper.output,furnaceItem,0.1,5*20);
                }
            }
        }
        if (REMOVE_FOOD_FROM_FURNACE) { furnace.removeByName(furnaceWrapper.id.toString()); }
    }
}
println("END furnace.food_processing");

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
        charm : "charm:firing",
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
    "Smelting" : { xp : 0.1, cookTime :  5*20 },
    "Blasting" : { xp : 0.2, cookTime :2.5*20 },
    "Smoking"  : { xp : 0.2, cookTime :2.5*20 }
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
for group, groupData in recipeGroups {      //println("Iterating "+group+" recipes.");
    for modid, recipe_type in groupData {   //println("* Iterating recipes for "+modid+".");
        if loadedMods.isModLoaded(modid) {  //println("* * "+modid+" is loaded.");
            if (modid != "minecraft" && bricksAreBetter && "minecraft" in groupData) { //println("* * Bricks are Better.");
                val vanillaManager = BracketHandlers.getRecipeManager(groupData["minecraft"]);
                //println("MANAGER: "+recipe_type);
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
                                moddedManager.addJSONRecipe(validName(modid)+"."+validName(vanillaItem.registryName), {ingredient:{item:vanillaItem.registryName},result:output.registryName,experience:xp as float,cookingtime:time as int});
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
            craftingTable.addShaped(validName(block_id), item, recipe);
        }
    }
}

// remove furnace recipes IF there is another option in that recipeGroup
if (bricksAreBetter && recipeGroups["Smelting"].size>1) { // size > 1 only checks if more than minecraft is listed.  It doesn't mean any of the listed mods are present.
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
	//manager.removeByName("notreepunching:smelting/large_vessel");
	//manager.removeByName("notreepunching:smelting/small_vessel");
}

println("END furnace.zs");
