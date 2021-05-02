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
var inputTier = new MapData();

for wrapper in cutter.getAllRecipes() {
    validInput.add(wrapper.ingredients[0].items[0].registryName.toString());
    existingOutput.add(wrapper.output.registryName.toString());
}

inputTier.put("minecraft:cobblestone",0 as int);

// attempt to deduce stone tiers
var sizeOfTierList = 0;
var searchingForTier = 0;
while (inputTier.size > sizeOfTierList) {
    sizeOfTierList = inputTier.size;
    searchingForTier += 1;
    for input in validInput {
        if (!inputTier.contains(input)) {
            // scan recipes looking for one made of valid inputs.  If not found, then the item is current tier.  Recipes no longer count as found if they are made of previous tier material.
            var lookingForTier = true;
            for wrapper in craftingTable.getRecipesByOutput(BracketHandlers.getItem(input)) {
                if (lookingForTier) {
                    var couldBeThisRecipe = true;
                    for ingredient in wrapper.ingredients {
                        for item in ingredient.items {
                            if (!item.matches(air)) {
                                val cellItem = item.registryName.toString();
                                if (    (!(cellItem in validInput))
                                    ||  (   (inputTier.contains(cellItem))
                                        &&  (inputTier.getAt(cellItem).asNumber().getInt() != searchingForTier) ) ) {
                                    couldBeThisRecipe = false;
                                }
                            }
                        }
                    }
                    if couldBeThisRecipe { // went through whole recipe without invalidating it, so this may be a tier-defining recipe
                        lookingForTier = false;
                    }
                }
            }
            if lookingForTier { // never found a tier-defining recipe, so insert at this tier.
                inputTier.put(input,searchingForTier);
                //println("Placing "+input+" at tier "+searchingForTier);
            }
        }
    }
}

for input in validInput {
    if (!inputTier.contains(input)) {
        inputTier.put(input,searchingForTier);
        //println("Forcing "+input+" into tier "+searchingForTier);
    }
}

// attempt to find items made of stone that aren't already represented
for wrapper in craftingTable.getAllRecipes() {
    val output = wrapper.output.registryName.toString();
//    var amount = wrapper.amount;
    if (!(output in existingOutput)) { // look for an all-stone recipe
        var couldBeAllStone = true;
        var cost = 0.0 as double;
        var useThisInput = "minecraft:cobblestone";
        var atThisTier = 0;
        for ingredient in wrapper.ingredients {
            if couldBeAllStone {
                cost += 1.0 as double;
                for item in ingredient.items {
                    if (item.matches(air)) {
                        cost -= 1.0 as double;
                    } else {
                        val cellItem2 = item.registryName.toString();
                        if (cellItem2 in validInput) {
                            val cellTier = inputTier.getAt(cellItem2).asNumber().getInt();
                            if (cellTier > atThisTier) {
                                useThisInput = cellItem2;
                                atThisTier = cellTier;
                            } else if ( (cellTier == atThisTier) && (useThisInput != cellItem2) ) {
                                //println("Abandoning "+wrapper.id.toString()+" recipe for "+output+" due to mixed ingredients");
                                couldBeAllStone = false;
                            }
                        } else {
                            couldBeAllStone = false;
                        }
                    }
                }
            }
        }

        if couldBeAllStone { // went through whole recipe without invalidating it
            existingOutput.add(output); // may not pass cost test, but either way we need to stop looking at it
            if (cost>0.0) { // suspicious stew will have a cost of 0.0 due to 0 ingredients
                cost /= wrapper.output.amount;
                var amount = 1;
                if cost <= 1.5 {
                    while (cost < 1.0) {
                        cost /= amount;
                        amount += 1;
                        cost *= amount;
                    }
                    val recipe_name = validName(output)+".from."+validName(useThisInput);
                    cutter.addJSONRecipe(recipe_name, {ingredient:{item:useThisInput},result:output,count:amount as int});
                }
            }
        }
    }
}

cutter.removeRecipe(air);

println("END stone_cutting.zs");
