#priority 100

import crafttweaker.api.BracketHandlers;
import crafttweaker.api.item.IIngredient;
import crafttweaker.api.item.IItemStack;
import crafttweaker.api.registries.IRecipeManager;

println("BEGIN functions");

function validName(name as string) as string {
    val rl = BracketHandlers.getResourceLocation(name);
    return rl.namespace+"."+rl.path;
}

function removeAndHide(item as IItemStack) as void {
    craftingTable.removeRecipe(item);
    mods.jei.JEI.hideItem(item);
}

function removeFromListAndHide(managerList as IRecipeManager[], item as IItemStack) as void {
    for manager in managerList { manager.removeRecipe(item); }
    mods.jei.JEI.hideItem(item);
}


function SimpleJsonReplaceByName(manager as IRecipeManager, name as string, output as IItemStack, input as IItemStack ) as void {
    val amount = output.amount;
    manager.removeByName(name);
    manager.addJSONRecipe(validName(name), {ingredient:{item:input.registryName},result:output.registryName,count:amount as int});
    return;
}

function replaceByName(name as string, output as IItemStack, recipe as IIngredient[][] ) as void {
    val rl = BracketHandlers.getResourceLocation(name);
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

println("END functions");
