
import crafttweaker.api.item.MCItemDefinition;
import crafttweaker.api.item.IItemStack;
import crafttweaker.api.tag.MCTag;
import crafttweaker.api.BracketHandlers;

var air = <item:minecraft:air>;
var saws = <tag:items:notreepunching:saws> as MCTag<MCItemDefinition>;
var axes = <tag:items:minecraft:axes> as MCTag<MCItemDefinition>;

axes.add(<item:minecraft:netherite_axe>);
axes.add(<item:immersiveengineering:axe_steel>);
axes.add(<item:notreepunching:flint_axe>);
axes.add(<item:aquaculture:neptunium_axe>);
axes.add(<item:betterendforge:terminite_axe>);
axes.add(<item:betterendforge:aeternium_axe>);
axes.add(<item:vanillafoodpantry:flint_butcher_axe>);

// special logs
for log in  [<item:simplefarming:fruit_log>,<item:aquaculture:driftwood>] {
    craftingTable.addShaped("axe."+validName(log.registryName), <item:minecraft:oak_planks>*2,
        [ [axes.asIIngredient().anyDamage().transformDamage()], [log] ]);
    craftingTable.addShaped("saw."+validName(log.registryName), <item:minecraft:oak_planks>*4,
        [ [saws.asIIngredient().anyDamage().transformDamage()], [log] ]);
}
craftingTable.removeByName("simplefarming:oak_planks"); // REMOVE: craft 1 fruit log into 4 oak planks
craftingTable.removeByName("aquaculture:planks_from_driftwood"); // REMOVE: craft 1 fruit log into 4 oak planks

// every log to plank changed to axe/saw recipes.
for wrapper in craftingTable.getRecipesByOutput(<tag:items:minecraft:planks>) {
    val ingredientsList = wrapper.ingredients;
    if ingredientsList[0].items[0] in <tag:items:minecraft:logs> {
        craftingTable.removeByName(wrapper.id);
        craftingTable.addShaped("axe."+validName(wrapper.id), wrapper.output*2,
            [ [axes.asIIngredient().anyDamage().transformDamage()], ingredientsList ]);
        craftingTable.addShaped("saw."+validName(wrapper.id), wrapper.output,
            [ [saws.asIIngredient().anyDamage().transformDamage()], ingredientsList ]);
    }
}

//planks to sticks
craftingTable.addShapedMirrored("sticks_axe", <item:minecraft:stick>, [
[axes.asIIngredient().anyDamage().transformDamage(), <tag:items:minecraft:planks>]]);
craftingTable.removeByName("notreepunching:sticks_from_planks_with_flint_axe");

craftingTable.addShapedMirrored("treated_sticks_axe", <item:immersiveengineering:stick_treated>,
    [[axes.asIIngredient().anyDamage().transformDamage(), <tag:items:forge:treated_wood>]]);
craftingTable.addShapedMirrored("treated_sticks_saw", <item:immersiveengineering:stick_treated>*2,
    [[saws.asIIngredient().anyDamage().transformDamage(), <tag:items:forge:treated_wood>]]);
craftingTable.removeByName("immersiveengineering:crafting/stick_treated");

//logs to sticks
craftingTable.addShapedMirrored("sticks_log_axe", <item:minecraft:stick>*6, [
[axes.asIIngredient().anyDamage().transformDamage(), <tag:items:minecraft:logs>]]);
craftingTable.removeByName("notreepunching:sticks_from_logs_with_flint_axe");

// ADD VANILLA AXE RECIPES TO VANILLA LOGS

val vanilla_needs_axe = {
    <tag:items:minecraft:oak_logs>        : <item:minecraft:oak_planks>,
    <tag:items:minecraft:spruce_logs>     : <item:minecraft:spruce_planks>,
    <tag:items:minecraft:birch_logs>      : <item:minecraft:birch_planks>,
    <tag:items:minecraft:jungle_logs>     : <item:minecraft:jungle_planks>,
    <tag:items:minecraft:acacia_logs>     : <item:minecraft:acacia_planks>,
    <tag:items:minecraft:dark_oak_logs>   : <item:minecraft:dark_oak_planks>
} as IItemStack[MCTag<MCItemDefinition>];

for log, planks in vanilla_needs_axe {
    craftingTable.addShaped("axe_"+planks.translationKey, planks*2,
        [ [axes.asIIngredient().anyDamage().transformDamage()], [log] ]);
}
craftingTable.removeByRegex("notreepunching:.*_planks_with_flint_axe");
