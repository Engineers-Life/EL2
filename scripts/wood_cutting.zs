#priority 0

import crafttweaker.api.BracketHandlers;
import crafttweaker.api.data.IData;
import crafttweaker.api.data.INumberData;
import crafttweaker.api.data.IntData;
import crafttweaker.api.data.MapData;
import crafttweaker.api.item.IIngredient;
import crafttweaker.api.item.IItemStack;
import crafttweaker.api.item.MCItemDefinition;
import crafttweaker.api.registries.IRecipeManager;
import crafttweaker.api.tag.MCTag;
import crafttweaker.api.tag.TagManager;
import stdlib.List;

println("BEGIN wood_cutting.zs");

<tag:blocks:natural-progression:ignored_stone_blocks>.add(<block:charm:woodcutter>);

// will divide recipe total cost by this amount and still be craftable.
// For example, a chest is made from the equivalent of two logs worth of wood, but at discount level 2, it will allow it to be crafted for 1 log.
// Will only discount cost if needed to be craftable.  A discount level of 8 won't turn it into a chest costing 1 plank since it will only reduce the cost to be 1 wood.
// Items that can't discount down to 1 plank but cost less than a log will round up to costing 1 log.
val discountLevel = 2.0;

// extra discount will be automatically applied to everything from that mod id (except for planks).  Not just if needed to be craftable.
val extraDiscountByPrefix = {
        "mcwfences" : 2.0
        };

val cutter = <recipetype:charm:woodcutting>;
val air = <item:minecraft:air>;
val treated_stick = <item:immersiveengineering:stick_treated>;

// interchangable slabs
craftingTable.addShapeless("slabs/treated_wood_vertical_from_horizontal",   <item:immersiveengineering:slab_treated_wood_vertical>,  [<item:immersiveengineering:slab_treated_wood_horizontal>]);
craftingTable.addShapeless("slabs/treated_wood_packaged_from_vertical",     <item:immersiveengineering:slab_treated_wood_packaged>,  [<item:immersiveengineering:slab_treated_wood_vertical>]);
craftingTable.addShapeless("slabs/treated_wood_horizontal_from_packaged",   <item:immersiveengineering:slab_treated_wood_horizontal>,[<item:immersiveengineering:slab_treated_wood_packaged>]);
craftingTable.addShaped("treated_wood_ladder_from_sticks",   <item:engineersdecor:treated_wood_ladder>,[
    [treated_stick,air,treated_stick],
    [treated_stick,treated_stick,treated_stick],
    [treated_stick,air,treated_stick] ]);

cutter.removeAll();
val stick = <item:minecraft:stick>;
//cutter.addJSONRecipe("sticks.from.planks", {ingredient:{tag:"minecraft:planks"},result:stick.registryName,count:2 as int});

//var costOfWood = new List<int[IItemStack]>();
//var costOfWood = new List<int[IItemStack]>();
//new MapData(map as IData[string]) as MapData
var costOfWood = new MapData();
var typeOfWood = new MapData();

var specialTypes = ["any","treated","UNKNOWN"];

// these may be needed since they don't follow normal recipes (due to axe-based recipes).
costOfWood.put("minecraft:stick",1.0 as double);
typeOfWood.put("minecraft:stick","any");
costOfWood.put("immersiveengineering:stick_treated",1.0 as double);
typeOfWood.put("immersiveengineering:stick_treated","treated");
costOfWood.put("immersiveengineering:treated_wood_horizontal",2.0 as double);
typeOfWood.put("immersiveengineering:treated_wood_horizontal","treated");
costOfWood.put("tetra:modular_double",256.0 as double); // priced out of range
typeOfWood.put("tetra:modular_double","minecraft:spruce_planks");
for special_plank in [
        "quark:white_stained_planks",
        "quark:orange_stained_planks",
        "quark:magenta_stained_planks",
        "quark:light_blue_stained_planks",
        "quark:yellow_stained_planks",
        "quark:lime_stained_planks",
        "quark:pink_stained_planks",
        "quark:gray_stained_planks",
        "quark:light_gray_stained_planks",
        "quark:cyan_stained_planks",
        "quark:purple_stained_planks",
        "quark:blue_stained_planks",
        "quark:brown_stained_planks",
        "quark:green_stained_planks",
        "quark:red_stained_planks",
        "quark:black_stained_planks"
    ] {
    costOfWood.put(special_plank,2.0 as double);
    typeOfWood.put(special_plank,special_plank);
}

// attempt to deduce what types of logs make what type of plank
// logType should end up with plank keys ("minecraft:oak_planks") and IIngredient values (list of oak log types)
var logTypes = new MapData();
var logTypeByTag = new MapData();
for planks in <tag:items:minecraft:planks>.getElements() {
    for wrapper in craftingTable.getRecipesByOutput(planks.getDefaultInstance()) {
        if (wrapper.output.amount == 4) {
            val ingredientsList = wrapper.ingredients;
            var outputKey = wrapper.output.registryName.toString();
            var ingredient = (ingredientsList.length<2) ? ingredientsList[0] :  ingredientsList[1];
            // var ingredient = ( (ingredientsList[0].items[0] in <tag:items:minecraft:logs>) || (ingredientsList.length<2) || (!(ingredientsList[0].items[0] in <tag:items:notreepunching:saws>)) ) ? ingredientsList[0] : ingredientsList[1];
            if ( ingredient.items[0] in <tag:items:minecraft:logs>) {
                if outputKey == "minecraft:oak_planks" {
                    logTypes.put(outputKey,"minecraft:oak_logs"); // because some weird non-oak logs also make oak planks
                    logTypeByTag.put(outputKey,"true");
                } else {

                    var foundTag = false;
                    //println("TAG SEARCH: start "+wrapper.id.toString());
                    for possibleTag in <tagManager:items>.getAllTagsFor(ingredient.items[0]) {
                        //println("TAG SEARCH: "+possibleTag.getElements().length+","+ingredient.items.length);

                        if (possibleTag.getElements().length == ingredient.items.length) { // leap of faith
                            foundTag = true;
                            //println("TAG SEARCH: Found a tag.  Assuming "+possibleTag.id.toString()+" is the tag for "+outputKey);
                            logTypes.put(outputKey,possibleTag.id.toString());
                            logTypeByTag.put(outputKey,"true");
                        }
                    }
                    if !foundTag {
                        println("TAG SEARCH: Couldn't find the tag for "+outputKey);
                        println("ERROR: Failing tag search will cause script to fail!");
                        // this part is broken, don't fail tag search or fix this part:
                        logTypes.put(outputKey,ingredient.commandString);
                        logTypeByTag.put(outputKey,"false");
                    }
                }

                costOfWood.put(outputKey,2.0 as double);
                typeOfWood.put(outputKey,outputKey);
                for item in ingredient.items {
                    costOfWood.put(item.registryName.toString(),8.0 as double);
                    typeOfWood.put(item.registryName.toString(),outputKey);
                }
            }
        }
    }
}

var foundNewWood = true;
var howManyFound = 0 as int;
var generation = 0 as int;

while foundNewWood {
    foundNewWood = false;
    generation = generation + 1;
    for wrapper in craftingTable.getAllRecipes() {
        val output = wrapper.output.registryName.toString();
        if ( (!costOfWood.contains(output)) && (wrapper.ingredients.length > 0) ) { // firework star seems to have a zero item crafting recipe.
            var outputAmt = wrapper.output.amount as int;
            var outputCostTally = 0.0 as double;
            var outputType = "UNKNOWN";
            var isTreated = false;
            var isWood = true;
            for cell in wrapper.ingredients {
                if (isWood && !cell.matches(air)) {
                    isWood = false;
                    var cellCost = 256.0 as double; // arbitrary high number
                    var cellType = "UNKNOWN";
                    var mightBeTreated = true;
                    for item in cell.items {
                        val itemString = item.registryName.toString();
                        if (costOfWood.contains(itemString)) {
                            cellCost = min(cellCost,costOfWood.getAt(itemString).asNumber().getDouble());
                            isWood = true;
                            val itemType = typeOfWood.getAt(itemString).getString();
                            if (!(itemType == "treated")) {
                                mightBeTreated = false; // only takes one non-treated ingredient to not be treated (otherwise all-stick items like ladders would be treated wood types)
                            }
                            if (!(itemType in specialTypes)) {
                                if (cellType == "UNKNOWN") {
                                    cellType = itemType;
                                } else if (cellType != itemType) {
                                    //println("Found multiple types for cell "+itemString+" in "+output+" ("+cellType+" and "+itemType+")");
                                    cellType = "any";
                                }
                            }
                        }
                    }
                    outputCostTally += cellCost;
                    isTreated = (mightBeTreated || isTreated);
                    if (!(cellType in specialTypes)) {
                        if (outputType == "UNKNOWN") {
                            outputType = cellType;
                        } else if (outputType != cellType) {
                            // println("WOODCUTTER: Found multiple types for "+output+" ("+outputType+" and "+cellType+")");
                            outputCostTally = 256*outputAmt; // priced out of range
                            outputType = "any";
                        }
                    }
                }
            }
            if (outputAmt != 0) { // some recipes output air, go figure ?
                if (isWood) {
                    if (outputType in specialTypes) {
                        outputType = isTreated ? "treated" : "any";
                    } else if (isTreated) {
                        // println("WOODCUTTER: Found mixed treated wood and a specific type of wood.  Rejecting recipe for "+output);
                        outputCostTally = 256*outputAmt; // priced out of range
                    }
                    if (outputCostTally == 0) { outputCostTally = 256; } // vanillafoodpantry:flour_pantry_block, probably a custom recipe, has a cost of zero.
                    costOfWood.put(output,outputCostTally/outputAmt);
                    typeOfWood.put(output,outputType);
                }
            }
        }
    }
    if (costOfWood.size > howManyFound) {
        foundNewWood = true;
        println("Iteration #"+generation+": "+(costOfWood.size-howManyFound)+" new items calculated");
        howManyFound = costOfWood.size;
    }
}
println("Final tally: "+howManyFound);

for outputString in costOfWood.keySet {
    var outputCost = costOfWood.getAt(outputString).asNumber().getDouble();
    val inputType = typeOfWood.getAt(outputString).getString();
    val recipe_name = validName(outputString)+".from."+validName(inputType);
    var outputAmount = 1 as int;
    if (outputString == inputType) { // planks make planks
        outputCost *= 4;
        outputAmount *= 4;
    } else {
        for prefix, extraDiscount in extraDiscountByPrefix {
            if outputString.startsWith(prefix) {
                outputCost /= extraDiscount;
            }
        }
    }
    while (outputCost < 2.0) {
        outputCost = outputCost/outputAmount; // to unit cost
        outputAmount += 1;
        outputCost = outputCost*outputAmount; // to new cost
    }
    if inputType == "treated" {
        //println("treated");
        if (outputCost > 2.0*discountLevel) {
            //println(outputString+" is too expensive for a treated wood plank");
        } else {
            cutter.addJSONRecipe(recipe_name, {ingredient:{tag:"forge:treated_wood"},result:outputString,count:outputAmount as int});
        }
    } else {
        if (outputCost > 2*discountLevel) {
            while (outputCost < 8.0) {
                outputCost = outputCost/outputAmount; // to unit cost
                outputAmount += 1;
                outputCost = outputCost*outputAmount; // to new cost
            }
            if outputCost > 8 * discountLevel {
                //println(outputString+" is too expensive for a single log");
            } else {
                if inputType == "any" {
                    cutter.addJSONRecipe(recipe_name, {ingredient:{tag:"minecraft:logs"},result:outputString,count:outputAmount as int});
                } else {
                    if logTypes.contains(inputType) {
                        val inputIngredient = logTypes.getAt(inputType).getString();
                        if (logTypeByTag.getAt(inputType).getString() == "true") {
                            cutter.addJSONRecipe(recipe_name, {ingredient:{tag:inputIngredient},result:outputString,count:outputAmount as int});
                        } else {
                            cutter.addJSONRecipe(recipe_name, {ingredient:{item:inputIngredient},result:outputString,count:outputAmount as int});
                        }
                    } else {
                        // println("LOG TYPE ERROR: Can't find "+inputType);
                    }
                }
            }

        } else {
            if inputType == "any" {
                cutter.addJSONRecipe(recipe_name, {ingredient:{tag:"minecraft:planks"},result:outputString,count:outputAmount as int});
            } else {
                cutter.addJSONRecipe(recipe_name, {ingredient:{item:inputType},result:outputString,count:outputAmount as int});
            }
        }
    }
}

cutter.removeRecipe(air);

println("END wood_cutting.zs");
