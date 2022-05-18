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


cutter.removeRecipe(air);

println("END stone_cutting.zs");
