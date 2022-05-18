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
//<tag:items:forge:saws>.add(<tag:items:notreepunching:saws>);
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
//craftingTable.removeByName("notreepunching:oak_planks_with_flint_axe");
//craftingTable.removeByName("minecraft:oak_planks");


removeAndHide(<item:terraincognita:apple_planks>);
removeAndHide(<item:terraincognita:hazel_planks>);
removeAndHide(<item:betterdefaultbiomes:palm_planks>);
removeAndHide(<item:betterdefaultbiomes:swamp_willow_planks>);

craftingTable.addShaped("terraincognita.apple_planks_axe", <item:terraincognita:apple_planks>*2,
    [ [all_axes.anyDamage().transformDamage()], [<item:terraincognita:apple_log>] ], ifAxe);
craftingTable.addShaped("terraincognita.apple_planks_saw", <item:terraincognita:apple_planks>*4,
    [ [saws.asIIngredient().anyDamage().transformDamage()], [<item:terraincognita:apple_log>] ]);
	
craftingTable.addShaped("terraincognita.hazel_planks_axe", <item:terraincognita:hazel_planks>*2,
    [ [all_axes.anyDamage().transformDamage()], [<item:terraincognita:hazel_log>] ], ifAxe);
craftingTable.addShaped("terraincognita.hazel_planks_saw", <item:terraincognita:hazel_planks>*4,
    [ [saws.asIIngredient().anyDamage().transformDamage()], [<item:terraincognita:hazel_log>] ]);
	
craftingTable.addShaped("betterdefaultbiomes.palm_planks_axe", <item:betterdefaultbiomes:palm_planks>*2,
    [ [all_axes.anyDamage().transformDamage()], [<item:betterdefaultbiomes:palm_log>] ], ifAxe);
craftingTable.addShaped("betterdefaultbiomes.palm_planks_saw", <item:betterdefaultbiomes:palm_planks>*4,
    [ [saws.asIIngredient().anyDamage().transformDamage()], [<item:betterdefaultbiomes:palm_log>] ]);
	
craftingTable.addShaped("betterdefaultbiomes.swamp_willow_planks_axe", <item:betterdefaultbiomes:swamp_willow_planks>*2,
    [ [all_axes.anyDamage().transformDamage()], [<item:betterdefaultbiomes:swamp_willow_log>] ], ifAxe);
craftingTable.addShaped("betterdefaultbiomes.swamp_willow_planks_saw", <item:betterdefaultbiomes:swamp_willow_planks>*4,
    [ [saws.asIIngredient().anyDamage().transformDamage()], [<item:betterdefaultbiomes:swamp_willow_log>] ]);

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

println("END planks.zs");