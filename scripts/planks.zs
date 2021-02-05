
import crafttweaker.api.item.MCItemDefinition;
import crafttweaker.api.item.IItemStack;
import crafttweaker.api.tag.MCTag;

var air = <item:minecraft:air>;
var saws = <tag:items:notreepunching:saws> as MCTag<MCItemDefinition>;
var axes = <tag:items:minecraft:axes> as MCTag<MCItemDefinition>;

axes.add(<item:notreepunching:flint_axe>);

// REMOVE PLANKS

// by name to avoid removing all oak_planks (recombining slabs, etc.)
craftingTable.removeByName("simplefarming:oak_planks"); // REMOVE: craft 1 fruit log into 4 oak planks

val planks_to_remove = [
    <item:betterdefaultbiomes:swamp_willow_planks>,
    <item:betterdefaultbiomes:palm_planks>,
    <item:betterendforge:dragon_tree_planks>
    ];


for planks in planks_to_remove {
    craftingTable.removeRecipe(planks);
}

// LOG TO PLANKS:

val log_to_planks = {
    <tag:items:betterdefaultbiomes:swamp_willow_logs>     : <item:betterdefaultbiomes:swamp_willow_planks>,
    <tag:items:betterdefaultbiomes:palm_logs>             : <item:betterdefaultbiomes:palm_planks>,
    <tag:items:betterendforge:dragon_tree_logs>           : <item:betterendforge:dragon_tree_planks>
} as IItemStack[MCTag<MCItemDefinition>];

for log, planks in log_to_planks {
    craftingTable.addShaped("axe_"+planks.translationKey, planks*2,
        [ [axes.asIIngredient().anyDamage().transformDamage()], [log] ]);
    craftingTable.addShaped("saw_"+planks.translationKey, planks*4,
        [ [saws.asIIngredient().anyDamage().transformDamage()], [log] ]);
}

// random note:
// notreepunching:oak_planks_with_flint_axe
craftingTable.removeByName("notreepunching:sticks_from_planks_with_flint_axe");
craftingTable.removeByName("notreepunching:sticks_from_logs_with_flint_axe");
//planks to sticks

craftingTable.addShapedMirrored("sticks_axe", <item:minecraft:stick>, [
[axes.asIIngredient().anyDamage().transformDamage(), <tag:items:minecraft:planks>]]);

//logs to sticks

craftingTable.addShapedMirrored("sticks_log_axe", <item:minecraft:stick>*6, [
[axes.asIIngredient().anyDamage().transformDamage(), <tag:items:minecraft:logs>]]);

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

craftingTable.removeByName("immersiveengineering:crafting/stick_treated");
craftingTable.addShapedMirrored("treated_sticks_axe", <item:immersiveengineering:stick_treated>,
    [[axes.asIIngredient().anyDamage().transformDamage(), <tag:items:forge:treated_wood>]]);

