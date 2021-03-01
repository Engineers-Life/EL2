#priority 100

import crafttweaker.api.BracketHandlers;
import crafttweaker.api.data.IData;
import crafttweaker.api.item.IIngredient;
import crafttweaker.api.item.IItemStack;
import crafttweaker.api.registries.IRecipeManager;

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

function removeFromListAndHide(managerList as IRecipeManager[], item as IItemStack) as void {
    for manager in managerList { manager.removeRecipe(item); }
    removeAllTagsAndHide(item);
}

function replaceJsonByName(manager as IRecipeManager, name as string, data as IData) as void {
    manager.removeByName(name);
    manager.addJSONRecipe(name, data);
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

println("END functions");
