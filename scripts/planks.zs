
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

//Remove Natural Progression hatchet and iron saw and add tag to basic saw
removeAndHide(<item:natural-progression:flint_hatchet>);
craftingTable.removeByRegex('.*axe.stripped_.*');
craftingTable.removeByRegex('.*saw.*stripped_.*');

//Create Saw tag
<tag:items:forge:saws>.add(<tag:items:notreepunching:saws>);
<tag:items:natural-progression:saw>.add(<item:natural-progression:netherite_saw>);
<tag:items:forge:saws>.add(<tag:items:natural-progression:saw>);

val air = <item:minecraft:air>;
val saws = <tag:items:forge:saws> as MCTag<MCItemDefinition>;
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
        <item:betterendforge:thallasium_axe>,
        <item:buddycards:buddysteel_axe>,
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
<tag:items:minecraft:oak_logs>.add(<item:simplefarming:fruit_log>);
<tag:items:minecraft:oak_logs>.add(<item:aquaculture:driftwood>);
/*
val oak_logs =
        <item:simplefarming:fruit_log>
    |   <item:aquaculture:driftwood>
    |   <tag:items:minecraft:oak_logs>.asIIngredient();
*/

craftingTable.addShaped("axe.misc.logs", <item:minecraft:oak_planks>*2,
    [ [all_axes.anyDamage().transformDamage()], [<tag:items:minecraft:oak_logs>] ], ifAxe);
craftingTable.addShaped("saw.misc.logs", <item:minecraft:oak_planks>*4,
    [ [saws.asIIngredient().anyDamage().transformDamage()], [<tag:items:minecraft:oak_logs>] ]);

craftingTable.removeByName("simplefarming:oak_planks");
craftingTable.removeByName("aquaculture:planks_from_driftwood");
craftingTable.removeByName("notreepunching:oak_planks_with_flint_axe");
craftingTable.removeByName("minecraft:oak_planks");

val needs_fixing = {
//  omit oak since it is covered in the miscellaneous logs
    "minecraft:spruce_planks"   :   <tag:items:minecraft:spruce_logs>.asIIngredient(),
    "minecraft:birch_planks"    :   <tag:items:minecraft:birch_logs>.asIIngredient(),
    "minecraft:jungle_planks"   :   <tag:items:minecraft:jungle_logs>.asIIngredient(),
    "minecraft:acacia_planks"   :   <tag:items:minecraft:acacia_logs>.asIIngredient(),
    "minecraft:dark_oak_planks" :   <tag:items:minecraft:dark_oak_logs>.asIIngredient(),
    "minecraft:crimson_planks"  :   <tag:items:minecraft:crimson_stems>.asIIngredient(),
    "minecraft:warped_planks"   :   <tag:items:minecraft:warped_stems>.asIIngredient(),
    "betterendforge:mossy_glowshroom_planks" : <tag:items:betterendforge:mossy_glowshroom_logs>.asIIngredient(),
    "betterendforge:lacugrove_planks"        : <tag:items:betterendforge:lacugrove_logs>.asIIngredient(),
    "betterendforge:end_lotus_planks"        : <tag:items:betterendforge:end_lotus_logs>.asIIngredient(),
    "betterendforge:pythadendron_planks"     : <tag:items:betterendforge:pythadendron_logs>.asIIngredient(),
    "betterendforge:dragon_tree_planks"      : <tag:items:betterendforge:dragon_tree_logs>.asIIngredient(),
    "betterendforge:tenanea_planks"          : <tag:items:betterendforge:tenanea_logs>.asIIngredient(),
    "betterendforge:helix_tree_planks"       : <tag:items:betterendforge:helix_tree_logs>.asIIngredient(),
    "betterendforge:umbrella_tree_planks"    : <tag:items:betterendforge:umbrella_tree_logs>.asIIngredient(),
    "betterendforge:jellyshroom_planks"      : <tag:items:betterendforge:jellyshroom_logs>.asIIngredient(),
    "betterendforge:lucernia_planks"         : <tag:items:betterendforge:lucernia_logs>.asIIngredient()
} as IIngredient[string];

// every log to plank changed to axe/saw recipes.
for wrapper in craftingTable.getRecipesByOutput(planks) {
    val ingredientsList = wrapper.ingredients;
    var ingredients = ingredientsList[0];
    if (    (wrapper.output.amount == 4)
        &&  (ingredients.items[0] in <tag:items:minecraft:logs>)
        &&  (!(ingredients.items[0] in <tag:items:minecraft:oak_logs>)) ) {
        if wrapper.output.registryName.toString() in needs_fixing {
            ingredients = needs_fixing[wrapper.output.registryName.toString()];
        }
        craftingTable.removeByName(wrapper.id);
        val recipeName = validName(wrapper.id);
        craftingTable.addShaped("axe.every."+recipeName, wrapper.output*2,
            [ [all_axes.anyDamage().transformDamage()], [ingredients] ], ifAxe);
        craftingTable.addShaped("saw.every."+recipeName, wrapper.output,
            [ [saws.asIIngredient().anyDamage().transformDamage()], [ingredients] ]);    }
}

//planks to sticks
craftingTable.removeByName("notreepunching:sticks_from_planks_with_flint_axe");
craftingTable.addShaped("sticks_axe", <item:minecraft:stick>, [
    [all_axes.anyDamage().transformDamage(), planks] ], ifAxe);

craftingTable.removeByName("immersiveengineering:crafting/stick_treated");
craftingTable.addShaped("treated_sticks_axe", <item:immersiveengineering:stick_treated>, [
    [all_axes.anyDamage().transformDamage(), <tag:items:forge:treated_wood>] ], ifAxe);
craftingTable.addShaped("treated_sticks_saw", <item:immersiveengineering:stick_treated>*2, [
    [saws.asIIngredient().anyDamage().transformDamage(), <tag:items:forge:treated_wood>] ]);
craftingTable.removeByRegex('notreepunching:sticks.*_saw');
craftingTable.addShaped("sticks_basic_saw", <item:minecraft:stick>*8, [
    [saws.asIIngredient().anyDamage().transformDamage(), <tag:items:minecraft:logs>] ]);

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
