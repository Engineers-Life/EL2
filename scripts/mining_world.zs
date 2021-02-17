import crafttweaker.api.item.IItemStack;
import crafttweaker.api.util.text.MCStyle;
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
val highlight = new MCStyle().setColor(<formatting:dark_aqua>);
val shift_tip = ("[press shift]" as MCTextComponent).setStyle(highlight.setItalic(false));
val short_tip = ("Requires unique ores! " as MCTextComponent).setStyle(new MCStyle().setItalic(true)).appendSibling(shift_tip);
val long_tip  = ("Crafted with 8 ores around a bucket of dimensional plasma.  No more than one of each ore when crafting." as MCTextComponent).setStyle(highlight.setItalic(true));

craftingTable.removeRecipe(teleporter);
craftingTable.addShaped("mining_dimension", teleporter, [
    [any_ore,any_ore,any_ore],
    [any_ore, <item:betterportals:portal_fluid_bucket>, any_ore],
    [any_ore,any_ore,any_ore] ], uniqueIngredients);
teleporter.addShiftTooltip(long_tip,short_tip);
