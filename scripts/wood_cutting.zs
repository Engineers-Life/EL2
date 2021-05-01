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

println("BEGIN wood_cutting");

// will divide recipe total cost by this amount and still be craftable.
// For example, a chest is made from the equivalent of two logs worth of wood, but at discount level 2, it will allow it to be crafted for 1 log.
// Will only discount cost if needed to be craftable.  A discount level of 8 won't turn it into a chest costing 1 plank since it will only reduce the cost to be 1 wood.
// Items that can't discount down to 1 plank but cost less than a log will round up to costing 1 log.
val discountLevel = 2.0;

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
                    println("TAG SEARCH: start "+wrapper.id.toString());
                    for possibleTag in <tagManager:items>.getAllTagsFor(ingredient.items[0]) {
                        println("TAG SEARCH: "+possibleTag.getElements().length+","+ingredient.items.length);

                        if (possibleTag.getElements().length == ingredient.items.length) { // leap of faith
                            foundTag = true;
                            //println("TAG SEARCH: Found a tag.  Assuming "+possibleTag.id.toString()+" is the tag for "+outputKey);
                            logTypes.put(outputKey,possibleTag.id.toString());
                            logTypeByTag.put(outputKey,"true");
                        }
                    }
                    if !foundTag {
                        println("TAG SEARCH: Couldn't find the tag for "+outputKey);
                        //println("TAG SEARCH: Using "+ingredient.commandString);
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

// stick/plank/slab/stairs/vert slab/fence/fence gate

while foundNewWood {
    foundNewWood = false;
    generation = generation + 1;
    for wrapper in craftingTable.getAllRecipes() {
        val output = wrapper.output.registryName.toString();
        if ( (!costOfWood.contains(output)) && (wrapper.ingredients.length > 0) ) { // firework star seems to have a zero item crafting recipe.
            var outputAmt = wrapper.output.amount as int;
            var outputCostTally = 0.0 as double;
            var outputType = "UNKNOWN";
            var mightBeTreated = true;
            var isWood = true;
            for cell in wrapper.ingredients {
                if (isWood && !cell.matches(air)) {
                    isWood = false;
                    var cellCost = 256.0 as double; // arbitrary high number
                    var cellType = "UNKNOWN";
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
                    if (!(cellType in specialTypes)) {
                        if (outputType == "UNKNOWN") {
                            outputType = cellType;
                        } else if (outputType != cellType) {
                            //println("Found multiple types for "+output+" ("+outputType+" and "+cellType+")");
                            outputType = "any";
                        }
                    }
                }
            }
            if (outputAmt != 0) { // some recipes output air, go figure ?
                if (isWood) {
                    costOfWood.put(output,outputCostTally/outputAmt);
                    if (outputType == "UNKNOWN") {
                        outputType = mightBeTreated ? "treated" : "any";
                    }
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
    println("Final tally: "+howManyFound);
}

function addItemToWoodcutter(
            outputString as string,
            outputCost as double,
            inputType as string,
            discountLevel as double,
            cutter as IRecipeManager,
            isLogType as bool,
            inputIngredient as string,
            isTag as string

            ) as void {
    //println(outputString);
    //println(inputType);
    val recipe_name = validName(outputString)+".from."+validName(inputType);
    println(recipe_name);
    var outputAmount = 1 as int;
    if (outputString == inputType) { // planks make planks
        outputCost *= 4;
        outputAmount *= 4;
    }
    //println(recipe_name+" with a cost of "+outputCost);
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
        //    println("adding treated");
            cutter.addJSONRecipe(recipe_name, {ingredient:{tag:"forge:treated_wood"},result:outputString,count:outputAmount as int});
        }
    } else {
        //println("non-treated");
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
                    if isLogType {
                        if (isTag == "true") {
                            cutter.addJSONRecipe(recipe_name, {ingredient:{tag:inputIngredient},result:outputString,count:outputAmount as int});
                        } else {
                            cutter.addJSONRecipe(recipe_name, {ingredient:{item:inputIngredient},result:outputString,count:outputAmount as int});
                        }
                    } else {
                        println("LOG TYPE ERROR: Can't find "+inputType);
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

val tagsByPriority = [
        <tag:items:forge:rods>,
        <tag:items:minecraft:planks>,
        <tag:items:minecraft:slabs>,
        <tag:items:minecraft:stairs>,
        <tag:items:quark:vertical_slab>,
        <tag:items:minecraft:fences>,
        <tag:items:minecraft:fence_gates> ];
var listOfAllWood = new List<string>();

for priorityTag in tagsByPriority {
    for taggedItem in priorityTag.getElements() {
        val tiString = taggedItem.defaultInstance.registryName.toString();
        if ( costOfWood.contains(tiString) && !(tiString in listOfAllWood) ) {
            listOfAllWood.add(tiString);
            val inputType1 = typeOfWood.getAt(tiString).getString();
            val isLogType1 = logTypes.contains(inputType1);
            var inputIngredient1 = "";
            var isTag1 = "";
            if isLogType1 {
                inputIngredient1 = logTypes.getAt(inputType1).getString();
                //println("iI1 = "+inputIngredient1);
                isTag1 = logTypeByTag.getAt(inputType1).getString();
            }
            addItemToWoodcutter(
                    tiString,
                    costOfWood.getAt(tiString).asNumber().getDouble(),
                    inputType1,
                    discountLevel,
                    cutter,
                    isLogType1,
                    inputIngredient1,
                    isTag1
                );
        }
    }
}
for outputString in costOfWood.keySet {
    if (!(outputString in listOfAllWood)) {
        listOfAllWood.add(outputString);
        val inputType2 = typeOfWood.getAt(outputString).getString();
        val isLogType2 = logTypes.contains(inputType2);
        var inputIngredient2 = "";
        var isTag2 = "";
        if isLogType2 {
            inputIngredient2 = logTypes.getAt(inputType2).getString();
            isTag2 = logTypeByTag.getAt(inputType2).getString();
        }

        addItemToWoodcutter(
                    outputString,
                    costOfWood.getAt(outputString).asNumber().getDouble(),
                    inputType2,
                    discountLevel,
                    cutter,
                    isLogType2,
                    inputIngredient2,
                    isTag2
                );
    }
}


/*
        val input = <item:minecraft:oak_planks>;
        val amt = wrapper.output.amount;
        val recipe_name = validName(wrapper.output.registryName)+".from."+validName(input.registryName);
        println("Add woodcutting recipe: "+recipe_name);
        cutter.addJSONRecipe(recipe_name, {ingredient:{item:input.registryName},result:wrapper.output.registryName,count:amt as int});

        if (wrapper.ingredients[0].items[0] in <tag:items:minecraft:planks>.getElements()) {
            stoneCutter.removeRecipe(wrapper.output);
        }
*/


/*
val cutting_recipes = {
    <item:betterdefaultbiomes:swamp_willow_button>              : [ <item:betterdefaultbiomes:swamp_willow_planks> ],
    <item:betterdefaultbiomes:swamp_willow_door>                : [ <item:betterdefaultbiomes:swamp_willow_planks> ],
    <item:betterdefaultbiomes:swamp_willow_fence>               : [ <item:betterdefaultbiomes:swamp_willow_planks> ],
    <item:betterdefaultbiomes:swamp_willow_fence_gate>          : [ <item:betterdefaultbiomes:swamp_willow_planks> ],
    <item:betterdefaultbiomes:swamp_willow_log_stripped>        : [ <item:betterdefaultbiomes:swamp_willow_log> ],
    <item:betterdefaultbiomes:swamp_willow_planks>*4            : [ <item:betterdefaultbiomes:swamp_willow_log>, <item:betterdefaultbiomes:swamp_willow_wood> ],
    <item:betterdefaultbiomes:swamp_willow_log>                 : [ <item:betterdefaultbiomes:swamp_willow_wood> ],
    <item:betterdefaultbiomes:swamp_willow_pressure_plate>      : [ <item:betterdefaultbiomes:swamp_willow_planks> ],
    <item:betterdefaultbiomes:swamp_willow_slab>*2              : [ <item:betterdefaultbiomes:swamp_willow_planks> ],
    <item:betterdefaultbiomes:swamp_willow_stairs>              : [ <item:betterdefaultbiomes:swamp_willow_planks> ],
    <item:betterdefaultbiomes:swamp_willow_trapdoor>            : [ <item:betterdefaultbiomes:swamp_willow_planks> ],
    <item:betterdefaultbiomes:swamp_willow_wood_stripped>       : [ <item:betterdefaultbiomes:swamp_willow_wood> ],

    <item:betterdefaultbiomes:palm_button>                      : [ <item:betterdefaultbiomes:palm_planks> ],
    <item:betterdefaultbiomes:palm_door>                        : [ <item:betterdefaultbiomes:palm_planks> ],
    <item:betterdefaultbiomes:palm_fence>                       : [ <item:betterdefaultbiomes:palm_planks> ],
    <item:betterdefaultbiomes:palm_fence_gate>                  : [ <item:betterdefaultbiomes:palm_planks> ],
    <item:betterdefaultbiomes:palm_log_stripped>                : [ <item:betterdefaultbiomes:palm_log> ],
    <item:betterdefaultbiomes:palm_planks>*4                    : [ <item:betterdefaultbiomes:palm_log>, <item:betterdefaultbiomes:palm_wood> ],
    <item:betterdefaultbiomes:palm_log>                         : [ <item:betterdefaultbiomes:palm_wood> ],
    <item:betterdefaultbiomes:palm_pressure_plate>              : [ <item:betterdefaultbiomes:palm_planks> ],
    <item:betterdefaultbiomes:palm_slab>*2                      : [ <item:betterdefaultbiomes:palm_planks> ],
    <item:betterdefaultbiomes:palm_stairs>                      : [ <item:betterdefaultbiomes:palm_planks> ],
    <item:betterdefaultbiomes:palm_trapdoor>                    : [ <item:betterdefaultbiomes:palm_planks> ],
    <item:betterdefaultbiomes:palm_wood_stripped>               : [ <item:betterdefaultbiomes:palm_wood> ],

    <item:terraincognita:apple_button>                          : [ <item:terraincognita:apple_planks> ],
    <item:terraincognita:apple_door>                            : [ <item:terraincognita:apple_planks> ],
    <item:terraincognita:apple_fence>                           : [ <item:terraincognita:apple_planks> ],
    <item:terraincognita:apple_fence_gate>                      : [ <item:terraincognita:apple_planks> ],
    <item:terraincognita:stripped_apple_log>                    : [ <item:terraincognita:apple_log> ],
    <item:terraincognita:apple_planks>*4                        : [ <item:terraincognita:apple_log>, <item:terraincognita:apple_wood> ],
    <item:terraincognita:apple_log>                             : [ <item:terraincognita:apple_wood> ],
    <item:terraincognita:apple_pressure_plate>                  : [ <item:terraincognita:apple_planks> ],
    <item:terraincognita:apple_slab>*2                          : [ <item:terraincognita:apple_planks> ],
    <item:terraincognita:apple_stairs>                          : [ <item:terraincognita:apple_planks> ],
    <item:terraincognita:apple_trapdoor>                        : [ <item:terraincognita:apple_planks> ],
    <item:terraincognita:stripped_apple_wood>                   : [ <item:terraincognita:apple_wood> ],
    <item:terraincognita:apple_boat>                            : [ <item:terraincognita:apple_planks> ],

    <item:terraincognita:hazel_button>                          : [ <item:terraincognita:hazel_planks> ],
    <item:terraincognita:hazel_door>                            : [ <item:terraincognita:hazel_planks> ],
    <item:terraincognita:hazel_fence>                           : [ <item:terraincognita:hazel_planks> ],
    <item:terraincognita:hazel_fence_gate>                      : [ <item:terraincognita:hazel_planks> ],
    <item:terraincognita:stripped_hazel_log>                    : [ <item:terraincognita:hazel_log> ],
    <item:terraincognita:hazel_planks>*4                        : [ <item:terraincognita:hazel_log>, <item:terraincognita:hazel_wood> ],
    <item:terraincognita:hazel_log>                             : [ <item:terraincognita:hazel_wood> ],
    <item:terraincognita:hazel_pressure_plate>                  : [ <item:terraincognita:hazel_planks> ],
    <item:terraincognita:hazel_slab>*2                          : [ <item:terraincognita:hazel_planks> ],
    <item:terraincognita:hazel_stairs>                          : [ <item:terraincognita:hazel_planks> ],
    <item:terraincognita:hazel_trapdoor>                        : [ <item:terraincognita:hazel_planks> ],
    <item:terraincognita:stripped_hazel_wood>                   : [ <item:terraincognita:hazel_wood> ],
    <item:terraincognita:hazel_boat>                            : [ <item:terraincognita:hazel_planks> ],

    <item:betterendforge:mossy_glowshroom_button>               : [ <item:betterendforge:mossy_glowshroom_planks> ],
    <item:betterendforge:mossy_glowshroom_door>                 : [ <item:betterendforge:mossy_glowshroom_planks> ],
    <item:betterendforge:mossy_glowshroom_fence>                : [ <item:betterendforge:mossy_glowshroom_planks> ],

    <item:betterendforge:mossy_glowshroom_stripped_log>         : [ <item:betterendforge:mossy_glowshroom_log> ],
    <item:betterendforge:mossy_glowshroom_planks>*4             : [ <item:betterendforge:mossy_glowshroom_log>, <item:betterendforge:mossy_glowshroom_bark> ],
    <item:betterendforge:mossy_glowshroom_log>                  : [ <item:betterendforge:mossy_glowshroom_bark> ],
    <item:betterendforge:mossy_glowshroom_pressure_plate>       : [ <item:betterendforge:mossy_glowshroom_planks> ],
    <item:betterendforge:mossy_glowshroom_slab>*2               : [ <item:betterendforge:mossy_glowshroom_planks> ],
    <item:betterendforge:mossy_glowshroom_stairs>               : [ <item:betterendforge:mossy_glowshroom_planks> ],
    <item:betterendforge:mossy_glowshroom_trapdoor>             : [ <item:betterendforge:mossy_glowshroom_planks> ],
    <item:betterendforge:mossy_glowshroom_stripped_bark>        : [ <item:betterendforge:mossy_glowshroom_bark> ],

    <item:betterendforge:lacugrove_button>                      : [ <item:betterendforge:lacugrove_planks> ],
    <item:betterendforge:lacugrove_door>                        : [ <item:betterendforge:lacugrove_planks> ],
    <item:betterendforge:lacugrove_fence>                       : [ <item:betterendforge:lacugrove_planks> ],

    <item:betterendforge:lacugrove_stripped_log>                : [ <item:betterendforge:lacugrove_log> ],
    <item:betterendforge:lacugrove_planks>*4                    : [ <item:betterendforge:lacugrove_log>, <item:betterendforge:lacugrove_bark> ],
    <item:betterendforge:lacugrove_log>                         : [ <item:betterendforge:lacugrove_bark> ],
    <item:betterendforge:lacugrove_pressure_plate>              : [ <item:betterendforge:lacugrove_planks> ],
    <item:betterendforge:lacugrove_slab>*2                      : [ <item:betterendforge:lacugrove_planks> ],
    <item:betterendforge:lacugrove_stairs>                      : [ <item:betterendforge:lacugrove_planks> ],
    <item:betterendforge:lacugrove_trapdoor>                    : [ <item:betterendforge:lacugrove_planks> ],
    <item:betterendforge:lacugrove_stripped_bark>               : [ <item:betterendforge:lacugrove_bark> ],

    <item:betterendforge:end_lotus_button>                      : [ <item:betterendforge:end_lotus_planks> ],
    <item:betterendforge:end_lotus_door>                        : [ <item:betterendforge:end_lotus_planks> ],
    <item:betterendforge:end_lotus_fence>                       : [ <item:betterendforge:end_lotus_planks> ],

    <item:betterendforge:end_lotus_stripped_log>                : [ <item:betterendforge:end_lotus_log> ],
    <item:betterendforge:end_lotus_planks>*4                    : [ <item:betterendforge:end_lotus_log>, <item:betterendforge:end_lotus_bark> ],
    <item:betterendforge:end_lotus_log>                         : [ <item:betterendforge:end_lotus_bark> ],
    <item:betterendforge:end_lotus_pressure_plate>              : [ <item:betterendforge:end_lotus_planks> ],
    <item:betterendforge:end_lotus_slab>*2                      : [ <item:betterendforge:end_lotus_planks> ],
    <item:betterendforge:end_lotus_stairs>                      : [ <item:betterendforge:end_lotus_planks> ],
    <item:betterendforge:end_lotus_trapdoor>                    : [ <item:betterendforge:end_lotus_planks> ],
    <item:betterendforge:end_lotus_stripped_bark>               : [ <item:betterendforge:end_lotus_bark> ],

    <item:betterendforge:pythadendron_button>                   : [ <item:betterendforge:pythadendron_planks> ],
    <item:betterendforge:pythadendron_door>                     : [ <item:betterendforge:pythadendron_planks> ],
    <item:betterendforge:pythadendron_fence>                    : [ <item:betterendforge:pythadendron_planks> ],

    <item:betterendforge:pythadendron_stripped_log>             : [ <item:betterendforge:pythadendron_log> ],
    <item:betterendforge:pythadendron_planks>*4                 : [ <item:betterendforge:pythadendron_log>, <item:betterendforge:pythadendron_bark> ],
    <item:betterendforge:pythadendron_log>                      : [ <item:betterendforge:pythadendron_bark> ],
    <item:betterendforge:pythadendron_pressure_plate>           : [ <item:betterendforge:pythadendron_planks> ],
    <item:betterendforge:pythadendron_slab>*2                   : [ <item:betterendforge:pythadendron_planks> ],
    <item:betterendforge:pythadendron_stairs>                   : [ <item:betterendforge:pythadendron_planks> ],
    <item:betterendforge:pythadendron_trapdoor>                 : [ <item:betterendforge:pythadendron_planks> ],
    <item:betterendforge:pythadendron_stripped_bark>            : [ <item:betterendforge:pythadendron_bark> ],

    <item:betterendforge:dragon_tree_button>                    : [ <item:betterendforge:dragon_tree_planks> ],
    <item:betterendforge:dragon_tree_door>                      : [ <item:betterendforge:dragon_tree_planks> ],
    <item:betterendforge:dragon_tree_fence>                     : [ <item:betterendforge:dragon_tree_planks> ],

    <item:betterendforge:dragon_tree_stripped_log>              : [ <item:betterendforge:dragon_tree_log> ],
    <item:betterendforge:dragon_tree_planks>*4                  : [ <item:betterendforge:dragon_tree_log>, <item:betterendforge:dragon_tree_bark> ],
    <item:betterendforge:dragon_tree_log>                       : [ <item:betterendforge:dragon_tree_bark> ],
    <item:betterendforge:dragon_tree_pressure_plate>            : [ <item:betterendforge:dragon_tree_planks> ],
    <item:betterendforge:dragon_tree_slab>*2                    : [ <item:betterendforge:dragon_tree_planks> ],
    <item:betterendforge:dragon_tree_stairs>                    : [ <item:betterendforge:dragon_tree_planks> ],
    <item:betterendforge:dragon_tree_trapdoor>                  : [ <item:betterendforge:dragon_tree_planks> ],
    <item:betterendforge:dragon_tree_stripped_bark>             : [ <item:betterendforge:dragon_tree_bark> ],

    <item:betterendforge:tenanea_button>                        : [ <item:betterendforge:tenanea_planks> ],
    <item:betterendforge:tenanea_door>                          : [ <item:betterendforge:tenanea_planks> ],
    <item:betterendforge:tenanea_fence>                         : [ <item:betterendforge:tenanea_planks> ],

    <item:betterendforge:tenanea_stripped_log>                  : [ <item:betterendforge:tenanea_log> ],
    <item:betterendforge:tenanea_planks>*4                      : [ <item:betterendforge:tenanea_log>, <item:betterendforge:tenanea_bark> ],
    <item:betterendforge:tenanea_log>                           : [ <item:betterendforge:tenanea_bark> ],
    <item:betterendforge:tenanea_pressure_plate>                : [ <item:betterendforge:tenanea_planks> ],
    <item:betterendforge:tenanea_slab>*2                        : [ <item:betterendforge:tenanea_planks> ],
    <item:betterendforge:tenanea_stairs>                        : [ <item:betterendforge:tenanea_planks> ],
    <item:betterendforge:tenanea_trapdoor>                      : [ <item:betterendforge:tenanea_planks> ],
    <item:betterendforge:tenanea_stripped_bark>                 : [ <item:betterendforge:tenanea_bark> ],

    <item:betterendforge:helix_tree_button>                     : [ <item:betterendforge:helix_tree_planks> ],
    <item:betterendforge:helix_tree_door>                       : [ <item:betterendforge:helix_tree_planks> ],
    <item:betterendforge:helix_tree_fence>                      : [ <item:betterendforge:helix_tree_planks> ],

    <item:betterendforge:helix_tree_stripped_log>               : [ <item:betterendforge:helix_tree_log> ],
    <item:betterendforge:helix_tree_planks>*4                   : [ <item:betterendforge:helix_tree_log>, <item:betterendforge:helix_tree_bark> ],
    <item:betterendforge:helix_tree_log>                        : [ <item:betterendforge:helix_tree_bark> ],
    <item:betterendforge:helix_tree_pressure_plate>             : [ <item:betterendforge:helix_tree_planks> ],
    <item:betterendforge:helix_tree_slab>*2                     : [ <item:betterendforge:helix_tree_planks> ],
    <item:betterendforge:helix_tree_stairs>                     : [ <item:betterendforge:helix_tree_planks> ],
    <item:betterendforge:helix_tree_trapdoor>                   : [ <item:betterendforge:helix_tree_planks> ],
    <item:betterendforge:helix_tree_stripped_bark>              : [ <item:betterendforge:helix_tree_bark> ],

    <item:betterendforge:umbrella_tree_button>                  : [ <item:betterendforge:umbrella_tree_planks> ],
    <item:betterendforge:umbrella_tree_door>                    : [ <item:betterendforge:umbrella_tree_planks> ],
    <item:betterendforge:umbrella_tree_fence>                   : [ <item:betterendforge:umbrella_tree_planks> ],

    <item:betterendforge:umbrella_tree_stripped_log>            : [ <item:betterendforge:umbrella_tree_log> ],
    <item:betterendforge:umbrella_tree_planks>*4                : [ <item:betterendforge:umbrella_tree_log>, <item:betterendforge:umbrella_tree_bark> ],
    <item:betterendforge:umbrella_tree_log>                     : [ <item:betterendforge:umbrella_tree_bark> ],
    <item:betterendforge:umbrella_tree_pressure_plate>          : [ <item:betterendforge:umbrella_tree_planks> ],
    <item:betterendforge:umbrella_tree_slab>*2                  : [ <item:betterendforge:umbrella_tree_planks> ],
    <item:betterendforge:umbrella_tree_stairs>                  : [ <item:betterendforge:umbrella_tree_planks> ],
    <item:betterendforge:umbrella_tree_trapdoor>                : [ <item:betterendforge:umbrella_tree_planks> ],
    <item:betterendforge:umbrella_tree_stripped_bark>           : [ <item:betterendforge:umbrella_tree_bark> ],

    <item:betterendforge:jellyshroom_button>                    : [ <item:betterendforge:jellyshroom_planks> ],
    <item:betterendforge:jellyshroom_door>                      : [ <item:betterendforge:jellyshroom_planks> ],
    <item:betterendforge:jellyshroom_fence>                     : [ <item:betterendforge:jellyshroom_planks> ],

    <item:betterendforge:jellyshroom_stripped_log>              : [ <item:betterendforge:jellyshroom_log> ],
    <item:betterendforge:jellyshroom_planks>*4                  : [ <item:betterendforge:jellyshroom_log>, <item:betterendforge:jellyshroom_bark> ],
    <item:betterendforge:jellyshroom_log>                       : [ <item:betterendforge:jellyshroom_bark> ],
    <item:betterendforge:jellyshroom_pressure_plate>            : [ <item:betterendforge:jellyshroom_planks> ],
    <item:betterendforge:jellyshroom_slab>*2                    : [ <item:betterendforge:jellyshroom_planks> ],
    <item:betterendforge:jellyshroom_stairs>                    : [ <item:betterendforge:jellyshroom_planks> ],
    <item:betterendforge:jellyshroom_trapdoor>                  : [ <item:betterendforge:jellyshroom_planks> ],
    <item:betterendforge:jellyshroom_stripped_bark>             : [ <item:betterendforge:jellyshroom_bark> ],

    <item:buddycards:acacia_card_display>                       : [ <item:minecraft:acacia_planks> ],
    <item:buddycards:birch_card_display>                        : [ <item:minecraft:birch_planks> ],
    <item:buddycards:crimson_card_display>                      : [ <item:minecraft:crimson_planks> ],
    <item:buddycards:dark_oak_card_display>                     : [ <item:minecraft:dark_oak_planks> ],
    <item:buddycards:jungle_card_display>                       : [ <item:minecraft:jungle_planks> ],
    <item:buddycards:oak_card_display>                          : [ <item:minecraft:oak_planks> ],
    <item:buddycards:spruce_card_display>                       : [ <item:minecraft:spruce_planks> ],
    <item:buddycards:warped_card_display>                       : [ <item:minecraft:warped_planks> ],
    <item:buildersaddition:bedside_table_acacia>                : [ <item:minecraft:acacia_log> ],
    <item:buildersaddition:bedside_table_birch>                 : [ <item:minecraft:birch_log> ],
    <item:buildersaddition:bedside_table_crimson>               : [ <item:minecraft:crimson_stem> ],
    <item:buildersaddition:bedside_table_dark_oak>              : [ <item:minecraft:dark_oak_log> ],
    <item:buildersaddition:bedside_table_jungle>                : [ <item:minecraft:jungle_log> ],
    <item:buildersaddition:bedside_table_oak>                   : [ <item:minecraft:oak_log> ],
    <item:buildersaddition:bedside_table_spruce>                : [ <item:minecraft:spruce_log> ],
    <item:buildersaddition:bedside_table_warped>                : [ <item:minecraft:warped_stem> ],
    <item:buildersaddition:bench_acacia>                        : [ <item:minecraft:acacia_planks> ],
    <item:buildersaddition:bench_birch>                         : [ <item:minecraft:birch_planks> ],
    <item:buildersaddition:bench_crimson>                       : [ <item:minecraft:crimson_planks> ],
    <item:buildersaddition:bench_dark_oak>                      : [ <item:minecraft:dark_oak_planks> ],
    <item:buildersaddition:bench_jungle>                        : [ <item:minecraft:jungle_planks> ],
    <item:buildersaddition:bench_oak>                           : [ <item:minecraft:oak_planks> ],
    <item:buildersaddition:bench_spruce>                        : [ <item:minecraft:spruce_planks> ],
    <item:buildersaddition:bench_warped>                        : [ <item:minecraft:warped_planks> ],
    <item:buildersaddition:bookshelf_acacia>                    : [ <item:minecraft:acacia_planks> ],
    <item:buildersaddition:bookshelf_birch>                     : [ <item:minecraft:birch_planks> ],
    <item:buildersaddition:bookshelf_crimson>                   : [ <item:minecraft:crimson_planks> ],
    <item:buildersaddition:bookshelf_dark_oak>                  : [ <item:minecraft:dark_oak_planks> ],
    <item:buildersaddition:bookshelf_jungle>                    : [ <item:minecraft:jungle_planks> ],
    <item:buildersaddition:bookshelf_oak>                       : [ <item:minecraft:oak_planks> ],
    <item:buildersaddition:bookshelf_spruce>                    : [ <item:minecraft:spruce_planks> ],
    <item:buildersaddition:bookshelf_warped>                    : [ <item:minecraft:warped_planks> ],
    <item:buildersaddition:cabinet_acacia>                      : [ <item:minecraft:acacia_planks> ],
    <item:buildersaddition:cabinet_birch>                       : [ <item:minecraft:birch_planks> ],
    <item:buildersaddition:cabinet_crimson>                     : [ <item:minecraft:crimson_planks> ],
    <item:buildersaddition:cabinet_dark_oak>                    : [ <item:minecraft:dark_oak_planks> ],
    <item:buildersaddition:cabinet_jungle>                      : [ <item:minecraft:jungle_planks> ],
    <item:buildersaddition:cabinet_oak>                         : [ <item:minecraft:oak_planks> ],
    <item:buildersaddition:cabinet_spruce>                      : [ <item:minecraft:spruce_planks> ],
    <item:buildersaddition:cabinet_warped>                      : [ <item:minecraft:warped_planks> ],
    <item:buildersaddition:cupboard_acacia>                     : [ <item:minecraft:acacia_log> ],
    <item:buildersaddition:cupboard_birch>                      : [ <item:minecraft:birch_log> ],
    <item:buildersaddition:cupboard_crimson>                    : [ <item:minecraft:crimson_stem> ],
    <item:buildersaddition:cupboard_dark_oak>                   : [ <item:minecraft:dark_oak_log> ],
    <item:buildersaddition:cupboard_jungle>                     : [ <item:minecraft:jungle_log> ],
    <item:buildersaddition:cupboard_oak>                        : [ <item:minecraft:oak_log> ],
    <item:buildersaddition:cupboard_spruce>                     : [ <item:minecraft:spruce_log> ],
    <item:buildersaddition:cupboard_warped>                     : [ <item:minecraft:warped_stem> ],
    <item:buildersaddition:shelf_acacia>                        : [ <item:minecraft:acacia_planks> ],
    <item:buildersaddition:shelf_birch>                         : [ <item:minecraft:birch_planks> ],
    <item:buildersaddition:shelf_crimson>                       : [ <item:minecraft:crimson_planks> ],
    <item:buildersaddition:shelf_dark_oak>                      : [ <item:minecraft:dark_oak_planks> ],
    <item:buildersaddition:shelf_jungle>                        : [ <item:minecraft:jungle_planks> ],
    <item:buildersaddition:shelf_oak>                           : [ <item:minecraft:oak_planks> ],
    <item:buildersaddition:shelf_spruce>                        : [ <item:minecraft:spruce_planks> ],
    <item:buildersaddition:shelf_warped>                        : [ <item:minecraft:warped_planks> ],
    <item:buildersaddition:stool_acacia>                        : [ <item:minecraft:acacia_planks> ],
    <item:buildersaddition:stool_birch>                         : [ <item:minecraft:birch_planks> ],
    <item:buildersaddition:stool_crimson>                       : [ <item:minecraft:crimson_planks> ],
    <item:buildersaddition:stool_dark_oak>                      : [ <item:minecraft:dark_oak_planks> ],
    <item:buildersaddition:stool_jungle>                        : [ <item:minecraft:jungle_planks> ],
    <item:buildersaddition:stool_oak>                           : [ <item:minecraft:oak_planks> ],
    <item:buildersaddition:stool_spruce>                        : [ <item:minecraft:spruce_planks> ],
    <item:buildersaddition:stool_warped>                        : [ <item:minecraft:warped_planks> ],
    <item:buildersaddition:support_bracket_acacia>*2            : [ <item:minecraft:acacia_planks> ],
    <item:buildersaddition:support_bracket_birch>*2             : [ <item:minecraft:birch_planks> ],
    <item:buildersaddition:support_bracket_crimson>*2           : [ <item:minecraft:crimson_planks> ],
    <item:buildersaddition:support_bracket_dark_oak>*2          : [ <item:minecraft:dark_oak_planks> ],
    <item:buildersaddition:support_bracket_jungle>*2            : [ <item:minecraft:jungle_planks> ],
    <item:buildersaddition:support_bracket_oak>*2               : [ <item:minecraft:oak_planks> ],
    <item:buildersaddition:support_bracket_spruce>*2            : [ <item:minecraft:spruce_planks> ],
    <item:buildersaddition:support_bracket_warped>*2            : [ <item:minecraft:warped_planks> ],
    <item:buildersaddition:table_acacia>                        : [ <item:minecraft:acacia_planks> ],
    <item:buildersaddition:table_birch>                         : [ <item:minecraft:birch_planks> ],
    <item:buildersaddition:table_crimson>                       : [ <item:minecraft:crimson_planks> ],
    <item:buildersaddition:table_dark_oak>                      : [ <item:minecraft:dark_oak_planks> ],
    <item:buildersaddition:table_jungle>                        : [ <item:minecraft:jungle_planks> ],
    <item:buildersaddition:table_oak>                           : [ <item:minecraft:oak_planks> ],
    <item:buildersaddition:table_spruce>                        : [ <item:minecraft:spruce_planks> ],
    <item:buildersaddition:table_warped>                        : [ <item:minecraft:warped_planks> ],
    <item:charm:acacia_barrel>                                  : [ <item:minecraft:acacia_log> ],
    <item:charm:birch_barrel>                                   : [ <item:minecraft:birch_log> ],
    <item:charm:crimson_barrel>                                 : [ <item:minecraft:crimson_stem> ],
    <item:charm:dark_oak_barrel>                                : [ <item:minecraft:dark_oak_log> ],
    <item:charm:jungle_barrel>                                  : [ <item:minecraft:jungle_log> ],
    <item:charm:oak_barrel>                                     : [ <item:minecraft:oak_log> ],
    <item:charm:spruce_barrel>                                  : [ <item:minecraft:spruce_log> ],
    <item:charm:warped_barrel>                                  : [ <item:minecraft:warped_stem> ],
    <item:decorative_blocks:acacia_beam>                        : [ <item:minecraft:acacia_log>, <item:minecraft:stripped_acacia_log> ],
    <item:decorative_blocks:acacia_palisade>                    : [ <item:minecraft:acacia_planks> ],
    <item:decorative_blocks:acacia_seat>*2                      : [ <item:minecraft:acacia_planks> ],
    <item:decorative_blocks:acacia_support>                     : [ <item:minecraft:acacia_planks> ],
    <item:decorative_blocks:birch_beam>                         : [ <item:minecraft:birch_log>, <item:minecraft:stripped_birch_log> ],
    <item:decorative_blocks:birch_palisade>                     : [ <item:minecraft:birch_planks> ],
    <item:decorative_blocks:birch_seat>*2                       : [ <item:minecraft:birch_planks> ],
    <item:decorative_blocks:birch_support>                      : [ <item:minecraft:birch_planks> ],
    <item:decorative_blocks:crimson_beam>                       : [ <item:minecraft:crimson_stem>, <item:minecraft:stripped_crimson_stem> ],
    <item:decorative_blocks:crimson_palisade>                   : [ <item:minecraft:crimson_planks> ],
    <item:decorative_blocks:crimson_seat>*2                     : [ <item:minecraft:crimson_planks> ],
    <item:decorative_blocks:crimson_support>                    : [ <item:minecraft:crimson_planks> ],
    <item:decorative_blocks:dark_oak_beam>                      : [ <item:minecraft:dark_oak_log>, <item:minecraft:stripped_dark_oak_log> ],
    <item:decorative_blocks:dark_oak_palisade>                  : [ <item:minecraft:dark_oak_planks> ],
    <item:decorative_blocks:dark_oak_seat>*2                    : [ <item:minecraft:dark_oak_planks> ],
    <item:decorative_blocks:dark_oak_support>                   : [ <item:minecraft:dark_oak_planks> ],
    <item:decorative_blocks:jungle_beam>                        : [ <item:minecraft:jungle_log>, <item:minecraft:stripped_jungle_log> ],
    <item:decorative_blocks:jungle_palisade>                    : [ <item:minecraft:jungle_planks> ],
    <item:decorative_blocks:jungle_seat>*2                      : [ <item:minecraft:jungle_planks> ],
    <item:decorative_blocks:jungle_support>                     : [ <item:minecraft:jungle_planks> ],
    <item:decorative_blocks:oak_beam>                           : [ <item:minecraft:oak_log>, <item:minecraft:stripped_oak_log> ],
    <item:decorative_blocks:oak_palisade>                       : [ <item:minecraft:oak_planks> ],
    <item:decorative_blocks:oak_seat>*2                         : [ <item:minecraft:oak_planks> ],
    <item:decorative_blocks:oak_support>                        : [ <item:minecraft:oak_planks> ],
    <item:decorative_blocks:spruce_beam>                        : [ <item:minecraft:spruce_log>, <item:minecraft:stripped_spruce_log> ],
    <item:decorative_blocks:spruce_palisade>                    : [ <item:minecraft:spruce_planks> ],
    <item:decorative_blocks:spruce_seat>*2                      : [ <item:minecraft:spruce_planks> ],
    <item:decorative_blocks:spruce_support>                     : [ <item:minecraft:spruce_planks> ],
    <item:decorative_blocks:warped_beam>                        : [ <item:minecraft:stripped_warped_stem>, <item:minecraft:warped_stem> ],
    <item:decorative_blocks:warped_palisade>                    : [ <item:minecraft:warped_planks> ],
    <item:decorative_blocks:warped_seat>*2                      : [ <item:minecraft:warped_planks> ],
    <item:decorative_blocks:warped_support>                     : [ <item:minecraft:warped_planks> ],
    <item:embellishcraft:acacia_chair>                          : [ <item:minecraft:acacia_planks> ],
    <item:embellishcraft:acacia_fancy_chest>                    : [ <item:minecraft:acacia_log> ],
    <item:embellishcraft:acacia_fancy_door>                     : [ <item:minecraft:acacia_planks> ],
    <item:embellishcraft:acacia_fancy_table>                    : [ <item:minecraft:acacia_log> ],
    <item:embellishcraft:acacia_plain_door>                     : [ <item:minecraft:acacia_planks> ],
    <item:embellishcraft:acacia_suspended_stairs>*2             : [ <item:minecraft:acacia_planks> ],
    <item:embellishcraft:acacia_table>                          : [ <item:minecraft:acacia_planks> ],
    <item:embellishcraft:acacia_terrace_chair>                  : [ <item:minecraft:acacia_planks> ],
    <item:embellishcraft:acacia_terrace_table>                  : [ <item:minecraft:acacia_planks> ],
    <item:embellishcraft:birch_chair>                           : [ <item:minecraft:birch_planks> ],
    <item:embellishcraft:birch_fancy_chest>                     : [ <item:minecraft:birch_log> ],
    <item:embellishcraft:birch_fancy_door>                      : [ <item:minecraft:birch_planks> ],
    <item:embellishcraft:birch_fancy_table>                     : [ <item:minecraft:birch_log> ],
    <item:embellishcraft:birch_plain_door>                      : [ <item:minecraft:birch_planks> ],
    <item:embellishcraft:birch_suspended_stairs>*2              : [ <item:minecraft:birch_planks> ],
    <item:embellishcraft:birch_table>                           : [ <item:minecraft:birch_planks> ],
    <item:embellishcraft:birch_terrace_chair>                   : [ <item:minecraft:birch_planks> ],
    <item:embellishcraft:birch_terrace_table>                   : [ <item:minecraft:birch_planks> ],
    <item:embellishcraft:crimson_chair>                         : [ <item:minecraft:crimson_planks> ],
    <item:embellishcraft:crimson_fancy_chest>                   : [ <item:minecraft:crimson_stem> ],
    <item:embellishcraft:crimson_fancy_door>                    : [ <item:minecraft:crimson_planks> ],
    <item:embellishcraft:crimson_fancy_table>                   : [ <item:minecraft:crimson_stem> ],
    <item:embellishcraft:crimson_plain_door>                    : [ <item:minecraft:crimson_planks> ],
    <item:embellishcraft:crimson_suspended_stairs>*2            : [ <item:minecraft:crimson_planks> ],
    <item:embellishcraft:crimson_table>                         : [ <item:minecraft:crimson_planks> ],
    <item:embellishcraft:crimson_terrace_chair>                 : [ <item:minecraft:crimson_planks> ],
    <item:embellishcraft:crimson_terrace_table>                 : [ <item:minecraft:crimson_planks> ],
    <item:embellishcraft:dark_oak_chair>                        : [ <item:minecraft:dark_oak_planks> ],
    <item:embellishcraft:dark_oak_fancy_chest>                  : [ <item:minecraft:dark_oak_log> ],
    <item:embellishcraft:dark_oak_fancy_door>                   : [ <item:minecraft:dark_oak_planks> ],
    <item:embellishcraft:dark_oak_fancy_table>                  : [ <item:minecraft:dark_oak_log> ],
    <item:embellishcraft:dark_oak_plain_door>                   : [ <item:minecraft:dark_oak_planks> ],
    <item:embellishcraft:dark_oak_suspended_stairs>*2           : [ <item:minecraft:dark_oak_planks> ],
    <item:embellishcraft:dark_oak_table>                        : [ <item:minecraft:dark_oak_planks> ],
    <item:embellishcraft:dark_oak_terrace_chair>                : [ <item:minecraft:dark_oak_planks> ],
    <item:embellishcraft:dark_oak_terrace_table>                : [ <item:minecraft:dark_oak_planks> ],
    <item:embellishcraft:jungle_chair>                          : [ <item:minecraft:jungle_planks> ],
    <item:embellishcraft:jungle_fancy_chest>                    : [ <item:minecraft:jungle_log> ],
    <item:embellishcraft:jungle_fancy_door>                     : [ <item:minecraft:jungle_planks> ],
    <item:embellishcraft:jungle_fancy_table>                    : [ <item:minecraft:jungle_log> ],
    <item:embellishcraft:jungle_plain_door>                     : [ <item:minecraft:jungle_planks> ],
    <item:embellishcraft:jungle_suspended_stairs>*2             : [ <item:minecraft:jungle_planks> ],
    <item:embellishcraft:jungle_table>                          : [ <item:minecraft:jungle_planks> ],
    <item:embellishcraft:jungle_terrace_chair>                  : [ <item:minecraft:jungle_planks> ],
    <item:embellishcraft:jungle_terrace_table>                  : [ <item:minecraft:jungle_planks> ],
    <item:embellishcraft:oak_chair>                             : [ <item:minecraft:oak_planks> ],
    <item:embellishcraft:oak_fancy_chest>                       : [ <item:minecraft:oak_log> ],
    <item:embellishcraft:oak_fancy_door>                        : [ <item:minecraft:oak_planks> ],
    <item:embellishcraft:oak_fancy_table>                       : [ <item:minecraft:oak_log> ],
    <item:embellishcraft:oak_plain_door>                        : [ <item:minecraft:oak_planks> ],
    <item:embellishcraft:oak_suspended_stairs>*2                : [ <item:minecraft:oak_planks> ],
    <item:embellishcraft:oak_table>                             : [ <item:minecraft:oak_planks> ],
    <item:embellishcraft:oak_terrace_chair>                     : [ <item:minecraft:oak_planks> ],
    <item:embellishcraft:oak_terrace_table>                     : [ <item:minecraft:oak_planks> ],
    <item:embellishcraft:spruce_chair>                          : [ <item:minecraft:spruce_planks> ],
    <item:embellishcraft:spruce_fancy_chest>                    : [ <item:minecraft:spruce_log> ],
    <item:embellishcraft:spruce_fancy_door>                     : [ <item:minecraft:spruce_planks> ],
    <item:embellishcraft:spruce_fancy_table>                    : [ <item:minecraft:spruce_log> ],
    <item:embellishcraft:spruce_plain_door>                     : [ <item:minecraft:spruce_planks> ],
    <item:embellishcraft:spruce_suspended_stairs>*2             : [ <item:minecraft:spruce_planks> ],
    <item:embellishcraft:spruce_table>                          : [ <item:minecraft:spruce_planks> ],
    <item:embellishcraft:spruce_terrace_chair>                  : [ <item:minecraft:spruce_planks> ],
    <item:embellishcraft:spruce_terrace_table>                  : [ <item:minecraft:spruce_planks> ],
    <item:embellishcraft:warped_chair>                          : [ <item:minecraft:warped_planks> ],
    <item:embellishcraft:warped_fancy_chest>                    : [ <item:minecraft:warped_stem> ],
    <item:embellishcraft:warped_fancy_door>                     : [ <item:minecraft:warped_planks> ],
    <item:embellishcraft:warped_fancy_table>                    : [ <item:minecraft:warped_stem> ],
    <item:embellishcraft:warped_plain_door>                     : [ <item:minecraft:warped_planks> ],
    <item:embellishcraft:warped_suspended_stairs>*2             : [ <item:minecraft:warped_planks> ],
    <item:embellishcraft:warped_table>                          : [ <item:minecraft:warped_planks> ],
    <item:embellishcraft:warped_terrace_chair>                  : [ <item:minecraft:warped_planks> ],
    <item:embellishcraft:warped_terrace_table>                  : [ <item:minecraft:warped_planks> ],
    <item:engineersdecor:halfslab_treated_wood>*4               : [ <item:immersiveengineering:slab_treated_wood_horizontal> ],
    <item:engineersdecor:old_industrial_wood_door>              : [ <item:engineersdecor:old_industrial_wood_planks> ],
    <item:engineersdecor:old_industrial_wood_slab>*2            : [ <item:engineersdecor:old_industrial_wood_planks> ],
    <item:engineersdecor:old_industrial_wood_slabslice>*4       : [ <item:engineersdecor:old_industrial_wood_slab> ],
    <item:engineersdecor:old_industrial_wood_stairs>            : [ <item:engineersdecor:old_industrial_wood_planks> ],
    <item:engineersdecor:treated_wood_broad_windowsill>         : [ <item:immersiveengineering:treated_wood_horizontal> ],
    <item:engineersdecor:treated_wood_pole>*3                   : [ <item:immersiveengineering:treated_wood_horizontal> ],
    <item:engineersdecor:treated_wood_side_table>               : [ <item:immersiveengineering:treated_wood_horizontal> ],
    <item:engineersdecor:treated_wood_stool>                    : [ <item:immersiveengineering:treated_wood_horizontal> ],
    <item:engineersdecor:treated_wood_windowsill>               : [ <item:immersiveengineering:slab_treated_wood_horizontal> ],
    <item:immersiveengineering:slab_treated_wood_horizontal>*2  : [ <item:immersiveengineering:treated_wood_horizontal> ],
    <item:immersiveengineering:slab_treated_wood_packaged>*2    : [ <item:immersiveengineering:treated_wood_packaged> ],
    <item:immersiveengineering:slab_treated_wood_vertical>*2    : [ <item:immersiveengineering:treated_wood_vertical> ],
    <item:immersiveengineering:stairs_treated_wood_horizontal>  : [ <item:immersiveengineering:treated_wood_horizontal> ],
    <item:immersiveengineering:stairs_treated_wood_packaged>    : [ <item:immersiveengineering:treated_wood_packaged> ],
    <item:immersiveengineering:stairs_treated_wood_vertical>    : [ <item:immersiveengineering:treated_wood_vertical> ],
    <item:immersiveengineering:stick_treated>*2                 : [ <item:immersiveengineering:treated_wood_horizontal>, <item:immersiveengineering:treated_wood_packaged>, <item:immersiveengineering:treated_wood_vertical> ],
    <item:immersiveengineering:treated_fence>                   : [ <item:immersiveengineering:treated_wood_horizontal>, <item:immersiveengineering:treated_wood_packaged>, <item:immersiveengineering:treated_wood_vertical> ],
    <item:immersiveengineering:treated_scaffold>*2              : [ <item:immersiveengineering:treated_wood_horizontal>, <item:immersiveengineering:treated_wood_packaged>, <item:immersiveengineering:treated_wood_vertical> ],
    <item:immersiveengineering:treated_wood_horizontal>         : [ <item:immersiveengineering:treated_wood_packaged> ],
    <item:immersiveengineering:treated_wood_packaged>           : [ <item:immersiveengineering:treated_wood_vertical> ],
    <item:immersiveengineering:treated_wood_vertical>           : [ <item:immersiveengineering:treated_wood_horizontal> ],
    <item:mcwbridges:acacia_log_bridge_middle>                  : [ <item:minecraft:acacia_planks> ],
    <item:mcwbridges:acacia_rail_bridge>                        : [ <item:minecraft:acacia_planks> ],
    <item:mcwbridges:birch_log_bridge_middle>                   : [ <item:minecraft:birch_planks> ],
    <item:mcwbridges:birch_rail_bridge>                         : [ <item:minecraft:birch_planks> ],
    <item:mcwbridges:crimson_log_bridge_middle>                 : [ <item:minecraft:crimson_planks> ],
    <item:mcwbridges:crimson_rail_bridge>                       : [ <item:minecraft:crimson_planks> ],
    <item:mcwbridges:dark_oak_log_bridge_middle>                : [ <item:minecraft:dark_oak_planks> ],
    <item:mcwbridges:dark_oak_rail_bridge>                      : [ <item:minecraft:dark_oak_planks> ],
    <item:mcwbridges:jungle_log_bridge_middle>                  : [ <item:minecraft:jungle_planks> ],
    <item:mcwbridges:jungle_rail_bridge>                        : [ <item:minecraft:jungle_planks> ],
    <item:mcwbridges:oak_log_bridge_middle>                     : [ <item:minecraft:oak_planks> ],
    <item:mcwbridges:oak_rail_bridge>                           : [ <item:minecraft:oak_planks> ],
    <item:mcwbridges:spruce_log_bridge_middle>                  : [ <item:minecraft:spruce_planks> ],
    <item:mcwbridges:spruce_rail_bridge>                        : [ <item:minecraft:spruce_planks> ],
    <item:mcwbridges:warped_log_bridge_middle>                  : [ <item:minecraft:warped_planks> ],
    <item:mcwbridges:warped_rail_bridge>                        : [ <item:minecraft:warped_planks> ],
    <item:mcwdoors:acacia_barn_door>                            : [ <item:minecraft:acacia_planks> ],
    <item:mcwdoors:acacia_beach_door>                           : [ <item:minecraft:acacia_planks> ],
    <item:mcwdoors:acacia_classic_door>                         : [ <item:minecraft:acacia_planks> ],
    <item:mcwdoors:acacia_cottage_door>                         : [ <item:minecraft:acacia_planks> ],
    <item:mcwdoors:acacia_four_panel_door>                      : [ <item:minecraft:acacia_planks> ],
    <item:mcwdoors:acacia_mystic_door>                          : [ <item:minecraft:acacia_planks> ],
    <item:mcwdoors:acacia_nether_door>                          : [ <item:minecraft:acacia_planks> ],
    <item:mcwdoors:acacia_paper_door>                           : [ <item:minecraft:acacia_planks> ],
    <item:mcwdoors:acacia_western_door>                         : [ <item:minecraft:acacia_planks> ],
    <item:mcwdoors:birch_barn_door>                             : [ <item:minecraft:birch_planks> ],
    <item:mcwdoors:birch_beach_door>                            : [ <item:minecraft:birch_planks> ],
    <item:mcwdoors:birch_classic_door>                          : [ <item:minecraft:birch_planks> ],
    <item:mcwdoors:birch_cottage_door>                          : [ <item:minecraft:birch_planks> ],
    <item:mcwdoors:birch_four_panel_door>                       : [ <item:minecraft:birch_planks> ],
    <item:mcwdoors:birch_mystic_door>                           : [ <item:minecraft:birch_planks> ],
    <item:mcwdoors:birch_nether_door>                           : [ <item:minecraft:birch_planks> ],
    <item:mcwdoors:birch_tropical_door>                         : [ <item:minecraft:birch_planks> ],
    <item:mcwdoors:birch_western_door>                          : [ <item:minecraft:birch_planks> ],
    <item:mcwdoors:crimson_barn_door>                           : [ <item:minecraft:crimson_planks> ],
    <item:mcwdoors:crimson_beach_door>                          : [ <item:minecraft:crimson_planks> ],
    <item:mcwdoors:crimson_classic_door>                        : [ <item:minecraft:crimson_planks> ],
    <item:mcwdoors:crimson_cottage_door>                        : [ <item:minecraft:crimson_planks> ],
    <item:mcwdoors:crimson_four_panel_door>                     : [ <item:minecraft:crimson_planks> ],
    <item:mcwdoors:crimson_mystic_door>                         : [ <item:minecraft:crimson_planks> ],
    <item:mcwdoors:crimson_paper_door>                          : [ <item:minecraft:crimson_planks> ],
    <item:mcwdoors:crimson_tropical_door>                       : [ <item:minecraft:crimson_planks> ],
    <item:mcwdoors:crimson_western_door>                        : [ <item:minecraft:crimson_planks> ],
    <item:mcwdoors:dark_oak_barn_door>                          : [ <item:minecraft:dark_oak_planks> ],
    <item:mcwdoors:dark_oak_beach_door>                         : [ <item:minecraft:dark_oak_planks> ],
    <item:mcwdoors:dark_oak_classic_door>                       : [ <item:minecraft:dark_oak_planks> ],
    <item:mcwdoors:dark_oak_cottage_door>                       : [ <item:minecraft:dark_oak_planks> ],
    <item:mcwdoors:dark_oak_mystic_door>                        : [ <item:minecraft:dark_oak_planks> ],
    <item:mcwdoors:dark_oak_nether_door>                        : [ <item:minecraft:dark_oak_planks> ],
    <item:mcwdoors:dark_oak_paper_door>                         : [ <item:minecraft:dark_oak_planks> ],
    <item:mcwdoors:dark_oak_tropical_door>                      : [ <item:minecraft:dark_oak_planks> ],
    <item:mcwdoors:dark_oak_western_door>                       : [ <item:minecraft:dark_oak_planks> ],
    <item:mcwdoors:jungle_barn_door>                            : [ <item:minecraft:jungle_planks> ],
    <item:mcwdoors:jungle_classic_door>                         : [ <item:minecraft:jungle_planks> ],
    <item:mcwdoors:jungle_cottage_door>                         : [ <item:minecraft:jungle_planks> ],
    <item:mcwdoors:jungle_four_panel_door>                      : [ <item:minecraft:jungle_planks> ],
    <item:mcwdoors:jungle_mystic_door>                          : [ <item:minecraft:jungle_planks> ],
    <item:mcwdoors:jungle_nether_door>                          : [ <item:minecraft:jungle_planks> ],
    <item:mcwdoors:jungle_paper_door>                           : [ <item:minecraft:jungle_planks> ],
    <item:mcwdoors:jungle_tropical_door>                        : [ <item:minecraft:jungle_planks> ],
    <item:mcwdoors:jungle_western_door>                         : [ <item:minecraft:jungle_planks> ],
    <item:mcwdoors:oak_barn_door>                               : [ <item:minecraft:oak_planks> ],
    <item:mcwdoors:oak_beach_door>                              : [ <item:minecraft:oak_planks> ],
    <item:mcwdoors:oak_cottage_door>                            : [ <item:minecraft:oak_planks> ],
    <item:mcwdoors:oak_four_panel_door>                         : [ <item:minecraft:oak_planks> ],
    <item:mcwdoors:oak_mystic_door>                             : [ <item:minecraft:oak_planks> ],
    <item:mcwdoors:oak_nether_door>                             : [ <item:minecraft:oak_planks> ],
    <item:mcwdoors:oak_paper_door>                              : [ <item:minecraft:oak_planks> ],
    <item:mcwdoors:oak_tropical_door>                           : [ <item:minecraft:oak_planks> ],
    <item:mcwdoors:oak_western_door>                            : [ <item:minecraft:oak_planks> ],
    <item:mcwdoors:spruce_barn_door>                            : [ <item:minecraft:spruce_planks> ],
    <item:mcwdoors:spruce_beach_door>                           : [ <item:minecraft:spruce_planks> ],
    <item:mcwdoors:spruce_classic_door>                         : [ <item:minecraft:spruce_planks> ],
    <item:mcwdoors:spruce_four_panel_door>                      : [ <item:minecraft:spruce_planks> ],
    <item:mcwdoors:spruce_mystic_door>                          : [ <item:minecraft:spruce_planks> ],
    <item:mcwdoors:spruce_nether_door>                          : [ <item:minecraft:spruce_planks> ],
    <item:mcwdoors:spruce_paper_door>                           : [ <item:minecraft:spruce_planks> ],
    <item:mcwdoors:spruce_tropical_door>                        : [ <item:minecraft:spruce_planks> ],
    <item:mcwdoors:spruce_western_door>                         : [ <item:minecraft:spruce_planks> ],
    <item:mcwdoors:warped_barn_door>                            : [ <item:minecraft:warped_planks> ],
    <item:mcwdoors:warped_beach_door>                           : [ <item:minecraft:warped_planks> ],
    <item:mcwdoors:warped_classic_door>                         : [ <item:minecraft:warped_planks> ],
    <item:mcwdoors:warped_cottage_door>                         : [ <item:minecraft:warped_planks> ],
    <item:mcwdoors:warped_four_panel_door>                      : [ <item:minecraft:warped_planks> ],
    <item:mcwdoors:warped_nether_door>                          : [ <item:minecraft:warped_planks> ],
    <item:mcwdoors:warped_paper_door>                           : [ <item:minecraft:warped_planks> ],
    <item:mcwdoors:warped_tropical_door>                        : [ <item:minecraft:warped_planks> ],
    <item:mcwdoors:warped_western_door>                         : [ <item:minecraft:warped_planks> ],
    <item:mcwwindows:acacia_blinds>*2                           : [ <item:minecraft:acacia_planks> ],
    <item:mcwwindows:acacia_blinds_tall>                        : [ <item:minecraft:acacia_planks> ],
    <item:mcwwindows:acacia_log_parapet>*4                      : [ <item:minecraft:acacia_log> ],
    <item:mcwwindows:acacia_plank_parapet>*4                    : [ <item:minecraft:acacia_planks> ],
    <item:mcwwindows:birch_blinds>*2                            : [ <item:minecraft:birch_planks> ],
    <item:mcwwindows:birch_blinds_tall>                         : [ <item:minecraft:birch_planks> ],
    <item:mcwwindows:birch_log_parapet>*4                       : [ <item:minecraft:birch_log> ],
    <item:mcwwindows:birch_plank_parapet>*4                     : [ <item:minecraft:birch_planks> ],
    <item:mcwwindows:crimson_blinds>*2                          : [ <item:minecraft:crimson_planks> ],
    <item:mcwwindows:crimson_blinds_tall>                       : [ <item:minecraft:crimson_planks> ],
    <item:mcwwindows:crimson_plank_parapet>*4                   : [ <item:minecraft:crimson_planks> ],
    <item:mcwwindows:crimson_stem_parapet>*4                    : [ <item:minecraft:crimson_stem> ],
    <item:mcwwindows:dark_oak_blinds>*2                         : [ <item:minecraft:dark_oak_planks> ],
    <item:mcwwindows:dark_oak_blinds_tall>                      : [ <item:minecraft:dark_oak_planks> ],
    <item:mcwwindows:dark_oak_log_parapet>*4                    : [ <item:minecraft:dark_oak_log> ],
    <item:mcwwindows:dark_oak_plank_parapet>*4                  : [ <item:minecraft:dark_oak_planks> ],
    <item:mcwwindows:jungle_blinds>*2                           : [ <item:minecraft:jungle_planks> ],
    <item:mcwwindows:jungle_blinds_tall>                        : [ <item:minecraft:jungle_planks> ],
    <item:mcwwindows:jungle_log_parapet>*4                      : [ <item:minecraft:jungle_log> ],
    <item:mcwwindows:jungle_plank_parapet>*4                    : [ <item:minecraft:jungle_planks> ],
    <item:mcwwindows:oak_blinds>*2                              : [ <item:minecraft:oak_planks> ],
    <item:mcwwindows:oak_blinds_tall>                           : [ <item:minecraft:oak_planks> ],
    <item:mcwwindows:oak_log_parapet>*4                         : [ <item:minecraft:oak_log> ],
    <item:mcwwindows:oak_plank_parapet>*4                       : [ <item:minecraft:oak_planks> ],
    <item:mcwwindows:spruce_blinds>*2                           : [ <item:minecraft:spruce_planks> ],
    <item:mcwwindows:spruce_blinds_tall>                        : [ <item:minecraft:spruce_planks> ],
    <item:mcwwindows:spruce_log_parapet>*4                      : [ <item:minecraft:spruce_log> ],
    <item:mcwwindows:spruce_plank_parapet>*4                    : [ <item:minecraft:spruce_planks> ],
    <item:mcwwindows:warped_blinds>*2                           : [ <item:minecraft:warped_planks> ],
    <item:mcwwindows:warped_blinds_tall>                        : [ <item:minecraft:warped_planks> ],
    <item:mcwwindows:warped_plank_parapet>*4                    : [ <item:minecraft:warped_planks> ],
    <item:mcwwindows:warped_stem_parapet>*4                     : [ <item:minecraft:warped_stem> ],
    <item:minecraft:acacia_pressure_plate>                      : [ <item:minecraft:acacia_planks> ],
    <item:minecraft:birch_pressure_plate>                       : [ <item:minecraft:birch_planks> ],
    <item:minecraft:crimson_pressure_plate>                     : [ <item:minecraft:crimson_planks> ],
    <item:minecraft:dark_oak_pressure_plate>                    : [ <item:minecraft:dark_oak_planks> ],
    <item:minecraft:jungle_pressure_plate>                      : [ <item:minecraft:jungle_planks> ],
    <item:minecraft:oak_pressure_plate>                         : [ <item:minecraft:oak_planks> ],
    <item:minecraft:spruce_pressure_plate>                      : [ <item:minecraft:spruce_planks> ],
    <item:minecraft:stripped_acacia_log>                        : [ <item:minecraft:acacia_log> ],
    <item:minecraft:stripped_acacia_wood>                       : [ <item:minecraft:acacia_wood> ],
    <item:minecraft:acacia_log>                                 : [ <item:minecraft:acacia_wood> ],
    <item:minecraft:stripped_birch_log>                         : [ <item:minecraft:birch_log> ],
    <item:minecraft:stripped_birch_wood>                        : [ <item:minecraft:birch_wood> ],
    <item:minecraft:birch_log>                                  : [ <item:minecraft:birch_wood> ],
    <item:minecraft:stripped_crimson_hyphae>                    : [ <item:minecraft:crimson_hyphae> ],
    <item:minecraft:crimson_stem>                               : [ <item:minecraft:crimson_hyphae> ],
    <item:minecraft:stripped_crimson_stem>                      : [ <item:minecraft:crimson_stem> ],
    <item:minecraft:stripped_dark_oak_log>                      : [ <item:minecraft:dark_oak_log> ],
    <item:minecraft:stripped_dark_oak_wood>                     : [ <item:minecraft:dark_oak_wood> ],
    <item:minecraft:dark_oak_log>                               : [ <item:minecraft:dark_oak_wood> ],
    <item:minecraft:stripped_jungle_log>                        : [ <item:minecraft:jungle_log> ],
    <item:minecraft:stripped_jungle_wood>                       : [ <item:minecraft:jungle_wood> ],
    <item:minecraft:jungle_log>                                 : [ <item:minecraft:jungle_wood> ],
    <item:minecraft:stripped_oak_log>                           : [ <item:minecraft:oak_log> ],
    <item:minecraft:stripped_oak_wood>                          : [ <item:minecraft:oak_wood> ],
    <item:minecraft:oak_log>                                    : [ <item:minecraft:oak_wood> ],
    <item:minecraft:stripped_spruce_log>                        : [ <item:minecraft:spruce_log> ],
    <item:minecraft:stripped_spruce_wood>                       : [ <item:minecraft:spruce_wood> ],
    <item:minecraft:spruce_log>                                 : [ <item:minecraft:spruce_wood> ],
    <item:minecraft:stripped_warped_hyphae>                     : [ <item:minecraft:warped_hyphae> ],
    <item:minecraft:warped_stem>                                : [ <item:minecraft:warped_hyphae> ],
    <item:minecraft:stripped_warped_stem>                       : [ <item:minecraft:warped_stem> ],
    <item:minecraft:warped_pressure_plate>                      : [ <item:minecraft:warped_planks> ],
    <item:quark:acacia_post>*3                                  : [ <item:minecraft:acacia_log>, <item:minecraft:acacia_wood> ],
    <item:quark:birch_post>*3                                   : [ <item:minecraft:birch_log>, <item:minecraft:birch_wood> ],
    <item:quark:crimson_post>*3                                 : [ <item:minecraft:crimson_hyphae>, <item:minecraft:crimson_stem> ],
    <item:quark:dark_oak_post>*3                                : [ <item:minecraft:dark_oak_log>, <item:minecraft:dark_oak_wood> ],
    <item:quark:jungle_post>*3                                  : [ <item:minecraft:jungle_log>, <item:minecraft:jungle_wood> ],
    <item:quark:oak_post>*3                                     : [ <item:minecraft:oak_log>, <item:minecraft:oak_wood> ],
    <item:quark:spruce_post>*3                                  : [ <item:minecraft:spruce_log>, <item:minecraft:spruce_wood> ],
    <item:quark:stripped_acacia_post>*3                         : [ <item:minecraft:acacia_log>, <item:minecraft:acacia_wood>, <item:minecraft:stripped_acacia_log>, <item:minecraft:stripped_acacia_wood> ],
    <item:quark:stripped_birch_post>*3                          : [ <item:minecraft:birch_log>, <item:minecraft:birch_wood>, <item:minecraft:stripped_birch_log>, <item:minecraft:stripped_birch_wood> ],
    <item:quark:stripped_crimson_post>*3                        : [ <item:minecraft:crimson_hyphae>, <item:minecraft:crimson_stem>, <item:minecraft:stripped_crimson_hyphae>, <item:minecraft:stripped_crimson_stem> ],
    <item:quark:stripped_dark_oak_post>*3                       : [ <item:minecraft:dark_oak_log>, <item:minecraft:dark_oak_wood>, <item:minecraft:stripped_dark_oak_log>, <item:minecraft:stripped_dark_oak_wood> ],
    <item:quark:stripped_jungle_post>*3                         : [ <item:minecraft:jungle_log>, <item:minecraft:jungle_wood>, <item:minecraft:stripped_jungle_log>, <item:minecraft:stripped_jungle_wood> ],
    <item:quark:stripped_oak_post>*3                            : [ <item:minecraft:oak_log>, <item:minecraft:oak_wood>, <item:minecraft:stripped_oak_log>, <item:minecraft:stripped_oak_wood> ],
    <item:quark:stripped_spruce_post>*3                         : [ <item:minecraft:spruce_log>, <item:minecraft:spruce_wood>, <item:minecraft:stripped_spruce_log>, <item:minecraft:stripped_spruce_wood> ],
    <item:quark:stripped_warped_post>*3                         : [ <item:minecraft:stripped_warped_hyphae>, <item:minecraft:stripped_warped_stem>, <item:minecraft:warped_hyphae>, <item:minecraft:warped_stem> ],
    <item:quark:warped_post>*3                                  : [ <item:minecraft:warped_hyphae>, <item:minecraft:warped_stem> ],
    <item:storagedrawers:acacia_trim>                           : [ <item:minecraft:acacia_planks> ],
    <item:storagedrawers:birch_trim>                            : [ <item:minecraft:birch_planks> ],
    <item:storagedrawers:dark_oak_trim>                         : [ <item:minecraft:dark_oak_planks> ],
    <item:storagedrawers:jungle_trim>                           : [ <item:minecraft:jungle_planks> ],
    <item:storagedrawers:oak_trim>                              : [ <item:minecraft:oak_planks> ],
    <item:storagedrawers:spruce_trim>                           : [ <item:minecraft:spruce_planks> ],
    <item:supplementaries:sign_post_acacia>*2                   : [ <item:minecraft:acacia_planks> ],
    <item:supplementaries:sign_post_birch>*2                    : [ <item:minecraft:birch_planks> ],
    <item:supplementaries:sign_post_crimson>*2                  : [ <item:minecraft:crimson_planks> ],
    <item:supplementaries:sign_post_dark_oak>*2                 : [ <item:minecraft:dark_oak_planks> ],
    <item:supplementaries:sign_post_jungle>*2                   : [ <item:minecraft:jungle_planks> ],
    <item:supplementaries:sign_post_oak>*2                      : [ <item:minecraft:oak_planks> ],
    <item:supplementaries:sign_post_spruce>*2                   : [ <item:minecraft:spruce_planks> ],
    <item:supplementaries:sign_post_warped>*2                   : [ <item:minecraft:warped_planks> ],
    <item:transport:treated_wood_boat>                          : [ <item:immersiveengineering:treated_wood_horizontal>, <item:immersiveengineering:treated_wood_packaged>, <item:immersiveengineering:treated_wood_vertical> ]
        } as IItemStack[][IItemStack];

for outputItem, inputList in cutting_recipes {
    for inputItem in inputList {
        val recipeName = validName(outputItem.registryName)+".from."+validName(inputItem.registryName);
        println("Add woodcutting recipe: "+recipeName);
        cutter.addJSONRecipe(recipeName, {ingredient:{item:inputItem.registryName},result:outputItem.registryName,count:outputItem.amount as int});
    }
}
*/

cutter.removeRecipe(air);

//craftingTable.removeRecipe(<item:woodenutilities:wood_cutter>);
//mods.jei.JEI.hideItem(<item:woodenutilities:wood_cutter>);

// remove WOOD cutting recipes from STONE cutter
for wrapper in stoneCutter.getAllRecipes() {
    if (wrapper.ingredients[0].items[0] in <tag:items:minecraft:planks>.getElements()) {
        stoneCutter.removeRecipe(wrapper.output);
    }
}

println("END wood_cutting");
