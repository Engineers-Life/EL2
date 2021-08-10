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

println("BEGIN stone_cutting.zs");

val cutter = <recipetype:minecraft:stonecutting>;
val air = <item:minecraft:air>;

// remove WOOD cutting recipes from STONE cutter
for wrapper in stoneCutter.getAllRecipes() {
    if (wrapper.ingredients[0].items[0] in <tag:items:minecraft:planks>.getElements()) {
        cutter.removeRecipe(wrapper.output);
    }
}

var validInput = new List<string>();
var existingOutput = new List<string>();
var inputTierParent = new MapData();
var inputTierLevel = new MapData();
var inputTierCost = new MapData();
var tierRecipe = new MapData();

for wrapper in cutter.getAllRecipes() {
    validInput.add(wrapper.ingredients[0].items[0].registryName.toString());
    existingOutput.add(wrapper.output.registryName.toString());
}

// override base tiers for better performance
for baseName in [
        "embellishcraft:smooth_basalt",
        "embellishcraft:smooth_gneiss",
        "embellishcraft:smooth_jade",
        "embellishcraft:smooth_larvikite",
        "embellishcraft:smooth_marble",
        "embellishcraft:smooth_slate",
        "engineersdecor:clinker_brick_block",
        "minecraft:cobblestone",
        "minecraft:smooth_red_sandstone",
        "minecraft:smooth_sandstone",
        "quark:duskbound_block",
        "quark:elder_prismarine",
        "quark:midori_block",
        "quark:sandy_bricks" ] {
    inputTierParent.put(baseName,"");
    inputTierLevel.put(baseName,1);
    inputTierCost.put(baseName,1.0 as double);
}

val canMix = ["minecraft:cobblestone","minecraft:sandstone"];
println("Deduce stone tiers");

// attempt to deduce stone tiers
var sizeOfTierList = 0;
while (inputTierLevel.size > sizeOfTierList) {
    sizeOfTierList = inputTierLevel.size;
    for input in validInput {
        if (!inputTierLevel.contains(input)) {
            // scan recipes looking for one made of valid inputs.  If not found, then the item is current tier.  Recipes no longer count as found if they are made of previous tier material.
            var lookingForTier = true;
            for wrapper in craftingTable.getRecipesByOutput(BracketHandlers.getItem(input)) {
                if (    lookingForTier
                    &&  (   !tierRecipe.contains(input)
                        ||  (tierRecipe.getAt(input).getString() == wrapper.id.toString())
                        )
                    ) {
                    var couldBeThisRecipe = true;
                    if (!tierRecipe.contains(input)) {
                        for ingredient in wrapper.ingredients {
                            for item in ingredient.items {
                                if (!item.matches(air)) {
                                    val itemInCell = item.registryName.toString();
                                    if (!(itemInCell in validInput)) {
                                        couldBeThisRecipe = false;
                                    }
                                }
                            }
                        }
                    }
                    if couldBeThisRecipe { // went through whole recipe without invalidating it, so this may be a tier-defining recipe
                        tierRecipe.remove(input); // work around for a bug in crafttweaker 1.16.5-7.1.0.280
                        tierRecipe.put(input,wrapper.id.toString());
                        lookingForTier = false;
                        var foundTier = "";
                        var foundLevel = 1;
                        var foundCap = 255; // arbirary high number
                        var allItemsHaveATier = true;
                        var recipeCost = 0.0 as double;
                        for ingredient in wrapper.ingredients {
                            if allItemsHaveATier {
                                var cellCost = 1.0 as double;
                                for item in ingredient.items {
                                    if allItemsHaveATier {
                                        if (item.matches(air)) {
                                            cellCost = 0.0 as double;
                                        } else {
                                            val itemString = item.registryName.toString();
                                            if inputTierLevel.contains(itemString) {
                                                cellCost = inputTierCost.getAt(itemString).asNumber().getDouble();
                                                if (foundTier == "") {
                                                    foundTier = itemString;
                                                    foundLevel = inputTierLevel.getAt(itemString).asNumber().getInt();
                                                } else if ( (itemString != foundTier) && (!(itemString in canMix)) ) {
                                                    val itemLevel = inputTierLevel.getAt(itemString).asNumber().getInt();
                                                    var topString = "";
                                                    var lowString = "";
                                                    var levelDiff = 0;
                                                    if itemLevel > foundLevel {
                                                        topString = itemString;
                                                        lowString = foundTier;
                                                        levelDiff = itemLevel-foundLevel;
                                                        foundTier = itemString;
                                                        foundLevel = itemLevel;
                                                    } else {
                                                        topString = foundTier;
                                                        lowString = itemString;
                                                        levelDiff = foundLevel-itemLevel;
                                                    }
                                                    var trackingLevel = foundLevel-levelDiff;
                                                    while (levelDiff>0) {
                                                        levelDiff -= 1;
                                                        topString = inputTierParent.getAt(topString).getString();
                                                    }
                                                    if  (   (topString != lowString) // not in the same branch, but they could have a common ancestor
                                                        ||  (trackingLevel > foundCap) ) {
                                                        while ( (topString != lowString) || (trackingLevel > foundCap) ) {
                                                            trackingLevel -= 1;
                                                            topString = inputTierParent.getAt(topString).getString();
                                                            lowString = inputTierParent.getAt(lowString).getString();
                                                        }
                                                        if (topString == "") {
                                                            allItemsHaveATier = false; // abort search since two seperate base stone types means it has to be it's own.
                                                            lookingForTier = true; // will cause it to get set as a base tier.
                                                        } else {
                                                            foundTier = topString;
                                                            foundLevel = inputTierLevel.getAt(topString).asNumber().getInt();
                                                            foundCap = foundLevel;
                                                        }
                                                    }
                                                }
                                            } else {
                                                allItemsHaveATier = false;
                                            }
                                        }
                                    }
                                }
                                recipeCost += cellCost;
                            }
                        }
                        if allItemsHaveATier {
                            inputTierParent.put(input,foundTier);
                            inputTierLevel.put(input,foundLevel+1);
                            inputTierCost.put(input,recipeCost/wrapper.output.amount);
                            //println(input+" tier "+(foundLevel+1)+" from "+foundTier);
                        }
                    }
                }
            }
            if lookingForTier { // never found a tier-defining recipe, so insert at base.
                //println(input+" is a base tier");
                inputTierParent.put(input,"");
                inputTierLevel.put(input,1);
                inputTierCost.put(input,1.0 as double);
            }
        }
    }
}

for input in validInput {
    if (!inputTierLevel.contains(input)) {
        println("Unable to resolve tier (usually due to cyclic recipes): Forcing "+input+" into a base tier");
        inputTierParent.put(input,"");
        inputTierLevel.put(input,1);
        inputTierCost.put(input,1.0 as double);
    }
}

println("Done deducing stone tiers.  Find recipes");

for wrapper in cutter.getAllRecipes() {
    val outputString = wrapper.output.registryName.toString();
    if (!inputTierCost.contains(outputString)) {
        val inputString = wrapper.ingredients[0].items[0].registryName.toString();
        inputTierParent.put(outputString,inputString);
        inputTierLevel.put(outputString,inputTierLevel.getAt(inputString).asNumber().getInt()+1);
        inputTierCost.put(outputString,(inputTierCost.getAt(inputString).asNumber().getDouble())/(wrapper.output.amount));
    }
}

// attempt to find items made of stone that aren't already represented
for iteration in [1,2] {
    var addedRecipes = 0;
    for wrapper in craftingTable.getAllRecipes() {
        val output = wrapper.output.registryName.toString();
    //    var amount = wrapper.amount;
        if (!(output in existingOutput)) { // look for an all-stone recipe
            var cost = 0.0 as double;
            var thisCouldBeARecipe = (wrapper.ingredients.length>0); // things like suspicious stew and firework star recipes are weird
            var foundATier = "";
            var foundALevel = 1;
            var foundACap = 255; // arbirary high number
            for ingredient in wrapper.ingredients {
                if thisCouldBeARecipe {
                    var costOfCell = 0.0 as double;
                    for item in ingredient.items {
                        if thisCouldBeARecipe {
                            if (!item.matches(air)) {
                                // val itemString = item.registryName.toString();
                                val cellItem = item.registryName.toString();
                                if inputTierCost.contains(cellItem) {
                                    costOfCell = inputTierCost.getAt(cellItem).asNumber().getDouble();
                                    if (foundATier == "") {
                                        foundATier = cellItem;
                                        foundALevel = inputTierLevel.getAt(cellItem).asNumber().getInt();
                                    } else if ( (cellItem != foundATier) && (!(cellItem in canMix)) ) {
                                        val cellItemLevel = inputTierLevel.getAt(cellItem).asNumber().getInt();
                                        var upString = "";
                                        var downString = "";
                                        var levelDif = 0;
                                        //println("Processing "+cellItem+"("+cellItemLevel+") and "+foundATier+"("+foundALevel+")");
                                        if cellItemLevel > foundALevel {
                                            upString = cellItem;
                                            downString = foundATier;
                                            levelDif = cellItemLevel-foundALevel;
                                            foundATier = cellItem;
                                            foundALevel = cellItemLevel;
                                        } else {
                                            upString = foundATier;
                                            downString = cellItem;
                                            levelDif = foundALevel-cellItemLevel;
                                        }
                                        var levelTracked = foundALevel-levelDif;
                                        while (levelDif>0) {
                                            levelDif -= 1;
                                            upString = inputTierParent.getAt(upString).getString();
                                            //println("Dropped to "+upString);
                                        }
                                        //println("Leveled at "+upString+" and "+downString);
                                        if  (   (upString != downString) // not in the same branch, but they could have a common ancestor
                                            ||  (levelTracked > foundACap) ) {
                                            while ( (upString != downString) || (levelTracked > foundACap) ) {
                                                levelTracked -= 1;
/*
                                                if (!inputTierParent.contains(upString)) {
                                                    println(upString+" is missing it's parent?");
                                                }
                                                if (!inputTierParent.contains(downString)) {
                                                    println(downString+" is missing it's parent?");
                                                }
*/
                                                upString = inputTierParent.getAt(upString).getString();
                                                downString = inputTierParent.getAt(downString).getString();
                                            }
                                            if (upString == "") {
                                                thisCouldBeARecipe = false; // abort search since two seperate base stone types
                                            } else {
                                                foundATier = upString;
                                                foundALevel = inputTierLevel.getAt(upString).asNumber().getInt();
                                                foundACap = foundALevel;
                                            }
                                        }
                                    }
                                } else {
                                    thisCouldBeARecipe = false;
                                }
                            }
                        }
                    }
                    if (costOfCell>0) { // some recipes have items that only list air (<resource:crafttweaker:simplefarming.red_dye> as well as two vfp portion recipes)
                        cost+=costOfCell;
                    } else {
                        thisCouldBeARecipe = false; // can't parse an ingredient, don't add the recipe.
                    }
                }
            }
            if thisCouldBeARecipe { // went through whole recipe without invalidating it, so this may be a new recipe
                val unitCost = cost/wrapper.output.amount;
                if (!inputTierCost.contains(output)) { // never had an output doesn't mean it wasn't an input
                    inputTierParent.put(output,foundATier);
                    inputTierLevel.put(output,foundALevel+1);
                    inputTierCost.put(output,unitCost);
                }
                existingOutput.add(output); // adding it either way so that we don't keep iterating the item's recipes
                if unitCost>0.0 {
                    while (foundALevel>0) {
                        val inputValue = inputTierCost.getAt(foundATier).asNumber().getDouble();
                        if  (unitCost<=1.5*inputValue) { // allow some discount
                            var amountFromInput = 1;
                            while (unitCost*amountFromInput < inputValue) {
                                amountFromInput += 1;
                            }
                            // add recipe
                            if (output != foundATier) {
                                val recipe_name = validName(output)+".from."+validName(foundATier);
                                //println("MADE A RECIPE: "+recipe_name);
                                cutter.addJSONRecipe(recipe_name, {ingredient:{item:foundATier},result:output,count:amountFromInput as int});
                                addedRecipes += 1;
                            }
                        }
                        foundATier = inputTierParent.getAt(foundATier).getString();
                        foundALevel -= 1;
                    }
                }
            }
        }
    }
    println("Added "+addedRecipes+" recipes.");
}

cutter.removeRecipe(air);

println("END stone_cutting.zs");
