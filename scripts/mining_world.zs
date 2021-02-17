import crafttweaker.api.item.IItemStack;
import crafttweaker.api.util.text.MCTextComponent;
import stdlib.List;

var uniqueIngredients as function(usualOut as IItemStack, inputs as IItemStack[][]) as IItemStack = (usualOut, inputs) => {
    var oreList = new List<IItemStack>();
    for group in inputs {
        for item in group {
            if (item in oreList) {
                return <item:minecraft:air>;
            }
            oreList.add(item);
        }
    }
    return usualOut;
};

val any_ore = <tag:items:forge:ores>;

val teleporter = <item:mining_dimension:teleporter> as IItemStack;

craftingTable.removeRecipe(teleporter);
craftingTable.addShaped("mining_dimension", teleporter, [
    [any_ore,any_ore,any_ore],
    [any_ore, <item:betterportals:portal_fluid_bucket>, any_ore],
    [any_ore,any_ore,any_ore] ], uniqueIngredients);
teleporter.addShiftTooltip(
    "Crafted with 8 ores around a bucket of dimensional plasma.  You may not use more than one of each type of ore in the crafting." as MCTextComponent,
    "Requires unique ores! [press shift]" as MCTextComponent );
