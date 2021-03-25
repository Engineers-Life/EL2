#priority 100

import crafttweaker.api.BracketHandlers;
import crafttweaker.api.data.IData;
import crafttweaker.api.data.INumberData;
import crafttweaker.api.item.IIngredient;
import crafttweaker.api.item.IItemStack;
import crafttweaker.api.recipes.WrapperRecipe;
import crafttweaker.api.registries.IRecipeManager;
import stdlib.List;

println("BEGIN functions");

function validName(name as string) as string {
    val rl = BracketHandlers.getResourceLocation(name);
    return rl.namespace+"."+rl.path;
}

function removeAllTagsAndHide(item as IItemStack) as void {
    for tag in <tagManager:items>.getAllTagsFor(item) {
        tag.remove(item);
    }
    mods.jei.JEI.hideItem(item);
}

function removeAndHide(item as IItemStack) as void {
    craftingTable.removeRecipe(item);
    removeAllTagsAndHide(item);
}

function removeFromList(managerList as IRecipeManager[], item as IItemStack) as void {
    for manager in managerList { manager.removeRecipe(item); }
}

function removeFromListAndHide(managerList as IRecipeManager[], item as IItemStack) as void {
    removeFromList(managerList,item);
    removeAllTagsAndHide(item);
}

function replaceJsonByName(manager as IRecipeManager, name as string, data as IData) as void {
    manager.removeByName(name);
    manager.addJSONRecipe(validName(name), data);
    return;
}

function SimpleJsonReplace(manager as IRecipeManager, output as IItemStack, input as IItemStack ) as void {
    val amount = output.amount;
    manager.removeRecipe(output);
    manager.addJSONRecipe(validName(output.registryName), {ingredient:{item:input.registryName},result:output.registryName,count:amount as int});
    return;
}

function SimpleJsonReplaceByName(manager as IRecipeManager, name as string, output as IItemStack, input as IItemStack ) as void {
    val amount = output.amount;
    manager.removeByName(name);
    manager.addJSONRecipe(validName(name), {ingredient:{item:input.registryName},result:output.registryName,count:amount as int});
    return;
}

function replaceByName(name as string, output as IItemStack, recipe as IIngredient[][] ) as void {
    craftingTable.removeByName(name);
    craftingTable.addShaped(validName(name),output,recipe,null);
    return;
}

function replaceByNameMirrored(name as string, output as IItemStack, recipe as IIngredient[][]) as void {
    craftingTable.removeByName(name);
    craftingTable.addShapedMirrored(validName(name),output,recipe,null);
    return;
}

function replaceByNameShapeless(name as string, output as IItemStack, recipe as IIngredient[] ) as void {
    craftingTable.removeByName(name);
    craftingTable.addShapeless(validName(name),output,recipe);
    return;
}

function moveTagsFromTo(source as IItemStack, dest as IItemStack) as void {
    for tag in <tagManager:items>.getAllTagsFor(source) {
        if !tag.contains(dest) {
            tag.add(dest);
        }
    }
    return;
}

function blendTags(item1 as IItemStack, item2 as IItemStack) as void {
    moveTagsFromTo(item1,item2);
    moveTagsFromTo(item2,item1);
    return;
}

function recipeWidth(wrapper as WrapperRecipe) as int {
    val maxCraftingSize = 9;
    if (!(wrapper.canFit(maxCraftingSize,maxCraftingSize))) { return 0; }
    var testWidth = maxCraftingSize;
    while wrapper.canFit(testWidth,maxCraftingSize) { testWidth = testWidth - 1; }
    testWidth = testWidth + 1;
    return testWidth;
}

function recipeHeight(wrapper as WrapperRecipe) as int {
    val maxCraftingSize = 9;
    if (!(wrapper.canFit(maxCraftingSize,maxCraftingSize))) { return 0; }
    var testHeight = maxCraftingSize;
    while wrapper.canFit(maxCraftingSize,testHeight) { testHeight = testHeight - 1; }
    testHeight = testHeight + 1;
    return testHeight;
}

function changeIngredient(fromIIng as IIngredient, toIIng as IIngredient) as void {
    // Currently unsupported:
    // Smithing	        <recipetype:minecraft:smithing>	    smithing
    // Stone Cutting	<recipetype:minecraft:stonecutting>	stoneCutter

    val suffix = "_swapped";
    var recipesToRemove = new List<string>();
    var transform as bool;
    // Crafting	        <recipetype:minecraft:crafting>	    craftingTable
    for wrapper in craftingTable.getAllRecipes() {
        //if (!wrapper.id.path.endsWith(suffix)) {
            transform = false;
            for cell in wrapper.ingredients {
                transform = transform || (cell.commandString == fromIIng.commandString);
            }
            if (transform) {
                val width = recipeWidth(wrapper);
                if (wrapper.canFit(width,recipeHeight(wrapper))) { // if can fit, then it is a shaped recipes.
                    var matrixGrid = new List<IIngredient[]>();
                    var matrixRow = new List<IIngredient>();
                    var cellIndex = 0;
                    for cell in wrapper.ingredients { // cell is IIngredient
                        if (cell.commandString == fromIIng.commandString) {
                            matrixRow.add(toIIng);
                        } else {
                            matrixRow.add(cell);
                        }
                        cellIndex = cellIndex+1;
                        if (cellIndex % width == 0) {
                            matrixGrid.add(matrixRow as IIngredient[]);
                            matrixRow = new List<IIngredient>();
                        }
                    }
                    craftingTable.addShapedMirrored(wrapper.id.path+suffix,wrapper.output,matrixGrid as IIngredient[][]);
                } else {
                    var shapeless = new List<IIngredient>();
                    for cell in wrapper.ingredients { // cell is IIngredient
                        if (cell.commandString == fromIIng.commandString) {
                            shapeless.add(toIIng);
                        } else {
                            shapeless.add(cell);
                        }
                    }
                    craftingTable.addShapeless(wrapper.id.path+suffix,wrapper.output,shapeless as IIngredient[]);
                }
                recipesToRemove.add(wrapper.id.toString());
            }
        //}
    }
    for recipeName in recipesToRemove {
        craftingTable.removeByName(recipeName);
    }

    // Blasting	        <recipetype:minecraft:blasting>	    blastFurnace
    // Campfire Cooking	<recipetype:minecraft:campfire_cooking>	campfire
    // Smelting	        <recipetype:minecraft:smelting>	    furnace
    // Smoking	        <recipetype:minecraft:smoking>	    smoker
    val defaultValues = {
        <recipetype:minecraft:blasting>         : { xp : 0.2 as float, cookTime :  5*20 as int },
        <recipetype:minecraft:campfire_cooking> : { xp : 0.1 as float, cookTime : 10*20 as int },
        <recipetype:minecraft:smelting>         : { xp : 0.1 as float, cookTime : 10*20 as int },
        <recipetype:minecraft:smoking>          : { xp : 0.2 as float, cookTime :  5*20 as int } };
    for manager in [<recipetype:minecraft:blasting>, <recipetype:minecraft:campfire_cooking>, <recipetype:minecraft:smelting>, <recipetype:minecraft:smoking>] {
        recipesToRemove = new List<string>();
        for wrapper in manager.getAllRecipes() {
            transform = false;
            for cell in wrapper.ingredients {
                transform = transform || (cell.commandString == fromIIng.commandString);
            }
            if (transform) {
                var ingList = new List<IIngredient>();
                for cell in wrapper.ingredients { // cell is IIngredient
                    if (cell.commandString == fromIIng.commandString) {
                        ingList.add(toIIng);
                    } else {
                        ingList.add(cell);
                    }
                }
                var count = 0 as int;
                for ing in ingList {
                    manager.addRecipe(wrapper.id.path+suffix+"."+count,wrapper.output,ing,defaultValues[manager]["xp"] as float,defaultValues[manager]["cookTime"] as int);
                    count = count + 1;
                }
                recipesToRemove.add(wrapper.id.toString());
            }
        }
        for recipeName in recipesToRemove {
            manager.removeByName(recipeName);
        }
    }
    changeIngredientCookingJSON(<recipetype:charm:firing>,fromIIng,toIIng,2.0,2.0);
}

// xp and cookTime modifiers are beneficial, so xp is multiplied by the modifier and cookTime is divided by it.
function changeIngredientCookingJSON(manager as IRecipeManager, fromIIng as IIngredient, toIIng as IIngredient, xpModifier as float, cookTimeModifier as float) as void {
    var cookingRecipesToRemove = new List<string>();
    val xp = 0.1 * xpModifier;
    val timeData = ( (10*20) / cookTimeModifier ) as IData;
    val time = timeData.asNumber().getInt() as int;
    for wrapper in manager.getAllRecipes() {
        var transformCookingJSON = false;
        for cell in wrapper.ingredients {
            transformCookingJSON = transformCookingJSON || (cell.commandString == fromIIng.commandString);
        }
        if (transformCookingJSON) {
            var ingList = new List<IIngredient>();
            for cell in wrapper.ingredients { // cell is IIngredient
                if (cell.commandString == fromIIng.commandString) {
                    ingList.add(toIIng);
                } else {
                    ingList.add(cell);
                }
            }
            var count = 0 as int;
            for ing in ingList {
                for inputItem in ing.items {
                    manager.addJSONRecipe(wrapper.id.path+".json"+"."+count, {ingredient:{item:inputItem.registryName},result:wrapper.output.registryName,experience:xp as float,cookingtime:time as int});
                    count = count + 1;
                }
            }
            cookingRecipesToRemove.add(wrapper.id.toString());
        }
    }
    for recipeName in cookingRecipesToRemove {
        manager.removeByName(recipeName);
    }
}

function changeIngredientWithConversion(fromItem as IItemStack, toItem as IItemStack) as void {
    changeIngredient(fromItem,toItem);
    val conversionInput = new List<IIngredient>();
    conversionInput.add(fromItem);
    craftingTable.addShapeless("convert_"+validName(fromItem.registryName)+"_to_"+validName(toItem.registryName),toItem,conversionInput as IIngredient[]);
}

println("END functions");
