
import crafttweaker.api.BracketHandlers;
import crafttweaker.api.data.IData;
import crafttweaker.api.item.IIngredient;
import crafttweaker.api.item.IItemStack;
import crafttweaker.api.item.IngredientList;
import crafttweaker.api.item.MCIngredientConditioned;
import crafttweaker.api.item.MCItemDefinition;
import crafttweaker.api.tag.MCTag;
import stdlib.List;
import mods.jei.JEI;

println("BEGIN planks.zs");

<tag:items:forge:modaxe>.add(<item:tetra:modular_double>); //add modular double to custom tag for recipes

//Remove Natural Progression hatchet and iron saw
removeAndHide(<item:natural-progression:flint_hatchet>);
removeAndHide(<item:natural-progression:improved_saw>);
craftingTable.removeByRegex('.*axe.stripped_.*');
craftingTable.removeByRegex('.*saw.stripped_.*');

val air = <item:minecraft:air>;
val saws = <tag:items:notreepunching:saws> as MCTag<MCItemDefinition>;
val axes = <tag:items:minecraft:axes> as MCTag<MCItemDefinition>;
val mod_axe = <tag:items:forge:modaxe> as MCTag<MCItemDefinition>;
val planks = <tag:items:minecraft:planks>;

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

val all_axes =
        <item:tetra:modular_double>.withTag({
            "double/handle":                    "double/basic_handle" as string,
            "double/head_left":                 "double/adze_left" as string,
            "double/head_right":                "double/basic_axe_right" as string,
            "double/basic_handle_material":     "basic_handle/treated_wood" as string,
            "double/adze_left_material":        "adze/stone" as string,
            "double/basic_axe_right_material":  "basic_axe/iron" as string })
        .setDisplayName("Tetra Axe and/or Adze")
    |   <item:tetra:modular_double>
    |   (axes.asIIngredient());

var ifAxe as function(usualOut as IItemStack, inputs as IItemStack[][]) as IItemStack = (usualOut, inputs) => {
    for row in inputs {
        for item in row {
            if item.registryName.toString() == "tetra:modular_double" {
                val data = item.tag.asMap();
                if "double/basic_axe_left_material" in data { return usualOut; }
                if "double/basic_axe_right_material" in data { return usualOut; }
                if "double/adze_left_material" in data { return usualOut; }
                if "double/adze_right_material" in data { return usualOut; }
                return air;
            }
        }
    }
    return usualOut;
};

// special logs make oak
val oak_logs =
        <item:simplefarming:fruit_log>
    |   <item:aquaculture:driftwood>
    |   <tag:items:minecraft:oak_logs>.asIIngredient();

craftingTable.addShaped("axe.misc.logs", <item:minecraft:oak_planks>*2,
    [ [all_axes.anyDamage().transformDamage()], [oak_logs] ], ifAxe);
craftingTable.addShaped("saw.misc.logs", <item:minecraft:oak_planks>*4,
    [ [saws.asIIngredient().anyDamage().transformDamage()], [oak_logs] ]);

craftingTable.removeByName("simplefarming:oak_planks");
craftingTable.removeByName("aquaculture:planks_from_driftwood");
craftingTable.removeByName("notreepunching:oak_planks_with_flint_axe");
craftingTable.removeByName("minecraft:oak_planks");

// every log to plank changed to axe/saw recipes.
for wrapper in craftingTable.getRecipesByOutput(planks) {
    val ingredientsList = wrapper.ingredients;
    if (    (wrapper.output.amount == 4)
        &&  (ingredientsList[0].items[0] in <tag:items:minecraft:logs>)
        &&  (!(ingredientsList[0].items[0] in <tag:items:minecraft:oak_logs>)) ) {
        craftingTable.removeByName(wrapper.id);
        val recipeName = validName(wrapper.id);
        craftingTable.addShaped("axe.every."+recipeName, wrapper.output*2,
            [ [all_axes.anyDamage().transformDamage()], [ingredientsList[0]] ], ifAxe);
        craftingTable.addShaped("saw.every."+recipeName, wrapper.output,
            [ [saws.asIIngredient().anyDamage().transformDamage()], [ingredientsList[0]] ]);    }
}

//planks to sticks
craftingTable.removeByName("notreepunching:sticks_from_planks_with_flint_axe");
craftingTable.addShaped("sticks_axe", <item:minecraft:stick>, [
    [all_axes.anyDamage().transformDamage(), planks] ], ifAxe);

craftingTable.removeByName("immersiveengineering:crafting/stick_treated");
craftingTable.addShaped("treated_sticks_axe", <item:immersiveengineering:stick_treated>, [
    [all_axes.anyDamage().transformDamage(), <tag:items:forge:treated_wood>] ], ifAxe);
craftingTable.addShapedMirrored("treated_sticks_saw", <item:immersiveengineering:stick_treated>*2, [
    [saws.asIIngredient().anyDamage().transformDamage(), <tag:items:forge:treated_wood>] ]);

//logs to sticks
craftingTable.removeByName("notreepunching:sticks_from_logs_with_flint_axe");
craftingTable.addShaped("sticks_log_axe", <item:minecraft:stick>*6, [
[all_axes.anyDamage().transformDamage(), <tag:items:minecraft:logs>]], ifAxe);

// ADD VANILLA AXE RECIPES TO VANILLA LOGS

/*
val vanilla_needs_axe = {
//  omit oak since it is covered in the miscellaneous logs
//    <tag:items:minecraft:oak_logs>        : <item:minecraft:oak_planks>,
    <tag:items:minecraft:spruce_logs>     : <item:minecraft:spruce_planks>,
    <tag:items:minecraft:birch_logs>      : <item:minecraft:birch_planks>,
    <tag:items:minecraft:jungle_logs>     : <item:minecraft:jungle_planks>,
    <tag:items:minecraft:acacia_logs>     : <item:minecraft:acacia_planks>,
    <tag:items:minecraft:dark_oak_logs>   : <item:minecraft:dark_oak_planks>
} as IItemStack[MCTag<MCItemDefinition>];

for log, output in vanilla_needs_axe {
    craftingTable.addShaped("axe_"+output.translationKey, output*2,
        [ [all_axes.anyDamage().transformDamage()], [log] ], ifAxe);
}
*/
craftingTable.removeByRegex("notreepunching:.*_planks_with_flint_axe");
craftingTable.removeByRegex("notreepunching:.*_planks_with_saw");

println("END planks.zs");
