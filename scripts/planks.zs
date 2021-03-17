
import crafttweaker.api.BracketHandlers;
import crafttweaker.api.data.IData;
import crafttweaker.api.item.IIngredient;
import crafttweaker.api.item.IItemStack;
import crafttweaker.api.item.MCIngredientConditioned;
import crafttweaker.api.item.MCItemDefinition;
import crafttweaker.api.tag.MCTag;

println("BEGIN planks.zs");

<tag:items:forge:modaxe>.add(<item:tetra:modular_double>); //add modular double to custom tag for recipes

val air = <item:minecraft:air>;
val saws = <tag:items:notreepunching:saws> as MCTag<MCItemDefinition>;
val axes = <tag:items:minecraft:axes> as MCTag<MCItemDefinition>;
val mod_axe = <tag:items:forge:modaxe> as MCTag<MCItemDefinition>;
val planks = <tag:items:minecraft:planks>;

var ifAxe as function(usualOut as IItemStack, inputs as IItemStack[][]) as IItemStack = (usualOut, inputs) => {
    for row in inputs {
        for item in row {
            if item.registryName.toString() == "tetra:modular_double" {
                val data = item.tag.asMap();
                if "double/basic_axe_left_material" in data { return usualOut; }
                if "double/basic_axe_right_material" in data { return usualOut; }
                return air;
            }
        }
    }
    return usualOut;
};

for axe in [
        //<item:tetra:modular_double>,
        <item:minecraft:netherite_axe>,
        <item:immersiveengineering:axe_steel>,
        <item:notreepunching:flint_axe>,
        <item:aquaculture:neptunium_axe>,
        <item:betterendforge:terminite_axe>,
        <item:betterendforge:aeternium_axe>,
        <item:vanillafoodpantry:flint_butcher_axe> ] {
    axes.add(axe);
}

// special logs
for log in  [<item:simplefarming:fruit_log>,<item:aquaculture:driftwood>] {
    craftingTable.addShaped("axe."+validName(log.registryName), <item:minecraft:oak_planks>*2,
        [ [axes.asIIngredient().anyDamage().transformDamage()], [log] ], ifAxe);
    mods.jei.JEI.hideRecipe("minecraft:crafting","crafttweaker:axe."+validName(log.registryName));
    craftingTable.addShaped("modaxe."+validName(log.registryName), <item:minecraft:oak_planks>*2,
        [ [mod_axe.asIIngredient().anyDamage().transformDamage()], [log] ], ifAxe);
    mods.jei.JEI.hideRecipe("minecraft:crafting","crafttweaker:modaxe."+validName(log.registryName));
    craftingTable.addShaped("saw."+validName(log.registryName), <item:minecraft:oak_planks>*4,
        [ [saws.asIIngredient().anyDamage().transformDamage()], [log] ]);
}
craftingTable.removeByName("simplefarming:oak_planks"); // REMOVE: craft 1 fruit log into 4 oak planks
craftingTable.removeByName("aquaculture:planks_from_driftwood"); // REMOVE: craft 1 fruit log into 4 oak planks

// every log to plank changed to axe/saw recipes.
for wrapper in craftingTable.getRecipesByOutput(planks) {
    val ingredientsList = wrapper.ingredients;
    if ingredientsList[0].items[0] in <tag:items:minecraft:logs> {
        craftingTable.removeByName(wrapper.id);
        craftingTable.addShaped("axe."+validName(wrapper.id), wrapper.output*2,
            [ [axes.asIIngredient().anyDamage().transformDamage()], ingredientsList ], ifAxe);
        craftingTable.addShaped("modaxe."+validName(wrapper.id), wrapper.output*2,
            [ [mod_axe.asIIngredient().anyDamage().transformDamage()], ingredientsList ], ifAxe);
        mods.jei.JEI.hideRecipe("minecraft:crafting","crafttweaker:modaxe."+validName(wrapper.id));
        craftingTable.addShaped("saw."+validName(wrapper.id), wrapper.output,
            [ [saws.asIIngredient().anyDamage().transformDamage()], ingredientsList ]);
    }
}

//planks to sticks
craftingTable.removeByName("notreepunching:sticks_from_planks_with_flint_axe");
craftingTable.addShaped("sticks_axe", <item:minecraft:stick>, [
    [axes.asIIngredient().anyDamage().transformDamage(), planks] ], ifAxe);
craftingTable.addShaped("sticks_modaxe", <item:minecraft:stick>, [
    [mod_axe.asIIngredient().anyDamage().transformDamage(), planks] ], ifAxe);
mods.jei.JEI.hideRecipe("minecraft:crafting","crafttweaker:sticks_modaxe");

craftingTable.removeByName("immersiveengineering:crafting/stick_treated");
craftingTable.addShaped("treated_sticks_axe", <item:immersiveengineering:stick_treated>, [
    [axes.asIIngredient().anyDamage().transformDamage(), <tag:items:forge:treated_wood>] ], ifAxe);
craftingTable.addShaped("treated_sticks_modaxe", <item:immersiveengineering:stick_treated>, [
    [mod_axe.asIIngredient().anyDamage().transformDamage(), <tag:items:forge:treated_wood>] ], ifAxe);
mods.jei.JEI.hideRecipe("minecraft:crafting","crafttweaker:treated_sticks_modaxe");
craftingTable.addShapedMirrored("treated_sticks_saw", <item:immersiveengineering:stick_treated>*2, [
    [saws.asIIngredient().anyDamage().transformDamage(), <tag:items:forge:treated_wood>] ]);

//logs to sticks
craftingTable.addShaped("sticks_log_axe", <item:minecraft:stick>*6, [
[axes.asIIngredient().anyDamage().transformDamage(), <tag:items:minecraft:logs>]], ifAxe);
craftingTable.addShaped("sticks_log_modaxe", <item:minecraft:stick>*6, [
[mod_axe.asIIngredient().anyDamage().transformDamage(), <tag:items:minecraft:logs>]], ifAxe);
mods.jei.JEI.hideRecipe("minecraft:crafting","crafttweaker:sticks_log_modaxe");
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

for log, output in vanilla_needs_axe {
    craftingTable.addShaped("axe_"+output.translationKey, output*2,
        [ [axes.asIIngredient().anyDamage().transformDamage()], [log] ], ifAxe);
    craftingTable.addShaped("modaxe_"+output.translationKey, output*2,
        [ [mod_axe.asIIngredient().anyDamage().transformDamage()], [log] ], ifAxe);
    mods.jei.JEI.hideRecipe("minecraft:crafting","crafttweaker:modaxe_"+output.translationKey);
}
craftingTable.removeByRegex("notreepunching:.*_planks_with_flint_axe");

// hide tetra axe recipes that would not hide
mods.jei.JEI.hideRecipe("minecraft:crafting","crafttweaker:modaxe.minecraft.warped_planks");
mods.jei.JEI.hideRecipe("minecraft:crafting","crafttweaker:modaxe.minecraft.crimson_planks");
mods.jei.JEI.hideRecipe("minecraft:crafting","crafttweaker:modaxe.betterdefaultbiomes.palm_planks");
mods.jei.JEI.hideRecipe("minecraft:crafting","crafttweaker:modaxe.betterdefaultbiomes.swamp_willow_planks");
mods.jei.JEI.hideRecipe("minecraft:crafting","crafttweaker:modaxe.betterendforge.jellyshroom_planks");
mods.jei.JEI.hideRecipe("minecraft:crafting","crafttweaker:modaxe.betterendforge.mossy_glowshroom_planks");
mods.jei.JEI.hideRecipe("minecraft:crafting","crafttweaker:modaxe.betterendforge.umbrella_tree_planks");
mods.jei.JEI.hideRecipe("minecraft:crafting","crafttweaker:modaxe.betterendforge.pythadendron_planks");
mods.jei.JEI.hideRecipe("minecraft:crafting","crafttweaker:modaxe.betterendforge.tenanea_planks");
mods.jei.JEI.hideRecipe("minecraft:crafting","crafttweaker:modaxe.betterendforge.end_lotus_planks");
mods.jei.JEI.hideRecipe("minecraft:crafting","crafttweaker:modaxe.betterendforge.lacugrove_planks");
mods.jei.JEI.hideRecipe("minecraft:crafting","crafttweaker:modaxe.betterendforge.helix_tree_planks");
mods.jei.JEI.hideRecipe("minecraft:crafting","crafttweaker:modaxe.betterendforge.dragon_tree_planks");
mods.jei.JEI.hideRecipe("minecraft:crafting","crafttweaker:modaxe.terraincognita.crafting/apple/planks");

println("END planks.zs");