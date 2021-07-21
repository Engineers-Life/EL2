import crafttweaker.api.item.IIngredient;
import crafttweaker.api.item.IItemStack;
import crafttweaker.api.item.MCItemDefinition;
import crafttweaker.api.util.text.MCStyle;
import crafttweaker.api.util.text.MCTextComponent;
import stdlib.List;

val any_ore = <tag:items:forge:ores>;
val randomite = <item:randomite:randomite_ore>;

for untagged_ore in [
        <item:vanillafoodpantry:rock_salt_ore>,
        <item:vanillafoodpantry:rock_salt_ore_nether>,
        <item:vanillafoodpantry:natron_ore>,
        <item:vanillafoodpantry:trona_ore>,
        <item:bigreactors:yellorite_ore>,
        <item:bigreactors:anglesite_ore>,
        <item:bigreactors:benitoite_ore>,
        randomite ] as IItemStack[] {
    any_ore.add(untagged_ore);
}

var ores0 = any_ore as IIngredient;
var ores1 = any_ore as IIngredient;
var ores2 = any_ore as IIngredient;
var ores3 = any_ore as IIngredient;
var ores4 = any_ore as IIngredient;
var ores5 = any_ore as IIngredient;
var ores6 = any_ore as IIngredient;
var ores7 = any_ore as IIngredient;

ores0 = <item:minecraft:gold_ore> | ores0;
ores1 = <item:minecraft:gold_ore> | <item:minecraft:iron_ore> | ores1;
ores2 = <item:minecraft:gold_ore> | <item:minecraft:iron_ore> | <item:minecraft:coal_ore> | ores2;
ores3 = <item:minecraft:gold_ore> | <item:minecraft:iron_ore> | <item:minecraft:coal_ore> | <item:minecraft:nether_gold_ore> | ores3;
ores4 = <item:minecraft:gold_ore> | <item:minecraft:iron_ore> | <item:minecraft:coal_ore> | <item:minecraft:nether_gold_ore> | <item:minecraft:lapis_ore> | ores4;
ores5 = <item:minecraft:gold_ore> | <item:minecraft:iron_ore> | <item:minecraft:coal_ore> | <item:minecraft:nether_gold_ore> | <item:minecraft:lapis_ore> | <item:minecraft:diamond_ore> | ores5;
ores6 = <item:minecraft:gold_ore> | <item:minecraft:iron_ore> | <item:minecraft:coal_ore> | <item:minecraft:nether_gold_ore> | <item:minecraft:lapis_ore> | <item:minecraft:diamond_ore> | <item:minecraft:redstone_ore> | ores6;
ores7 = <item:minecraft:gold_ore> | <item:minecraft:iron_ore> | <item:minecraft:coal_ore> | <item:minecraft:nether_gold_ore> | <item:minecraft:lapis_ore> | <item:minecraft:diamond_ore> | <item:minecraft:redstone_ore> | <item:minecraft:emerald_ore> | ores7;

var uniqueIngredients as function(usualOut as IItemStack, inputs as IItemStack[][]) as IItemStack = (usualOut, inputs) => {
    var oreList = new List<IItemStack>();
    for group in inputs {
        for item in group {
            if (item in oreList) && (!item.matches(randomite)) {
                return <item:minecraft:air>;
            }
            oreList.add(item);
        }
    }
    return usualOut;
};

val teleporter = <item:mining_dimension:teleporter> as IItemStack;
val highlight = new MCStyle().setColor(<formatting:dark_aqua>);
val shift_tip = ("[press shift]" as MCTextComponent).setStyle(highlight.setItalic(false));
val short_tip = ("Requires unique ores! " as MCTextComponent).setStyle(new MCStyle().setItalic(true)).appendSibling(shift_tip);
val long_tip  = ("Crafted with 8 ores around a bucket of dimensional plasma.  No more than one of each ore may be used when crafting." as MCTextComponent).setStyle(highlight.setItalic(true));

craftingTable.removeRecipe(teleporter);
craftingTable.addShaped("mining_dimension", teleporter, [
    [ores0,ores1,ores2],
    [ores3, <item:betterportals:portal_fluid_bucket>, ores4],
    [ores5,ores6,ores7] ], uniqueIngredients);
teleporter.addShiftTooltip(long_tip,short_tip);

mods.jei.JEI.addInfo(<item:mining_dimension:teleporter>, [long_tip.formattedText]);
val also_used_info = ["Also used in crafting the Mining Dimension Transporter."];
mods.jei.JEI.addInfo(<item:betterportals:portal_fluid_bucket>,also_used_info);
for ore in any_ore.getElements() {
    mods.jei.JEI.addInfo(ore,also_used_info);
}
// mods.jei.JEI.hideRecipe("minecraft:crafting","crafttweaker:mining_dimension");
