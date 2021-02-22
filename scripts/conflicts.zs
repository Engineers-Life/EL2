
import crafttweaker.api.BracketHandlers;
import crafttweaker.api.item.IIngredient;
import crafttweaker.api.item.IItemStack;
import crafttweaker.api.registries.IRecipeManager;

val air = <item:minecraft:air>;
val stick = <tag:items:forge:rods/wooden>;
val log = <tag:items:minecraft:logs>;
val planks = <tag:items:minecraft:planks>;
val wooden_slab = <tag:items:minecraft:wooden_slabs>;
val bar = <item:engineersdecor:metal_bar>;
val impCable = <item:storagenetwork:import_kabel>;
val fruitLog = <item:simplefarming:fruit_log>;
val ironIngot = <tag:items:forge:ingots/iron>;
val ironBucket = <item:minecraft:bucket>;
val dirt = <item:minecraft:dirt>;

function removeAndHide(item as IItemStack) as void {
    craftingTable.removeRecipe(item);
    mods.jei.JEI.hideItem(item);
}

function removeFromListAndHide(managerList as IRecipeManager[], item as IItemStack) as void {
    for manager in managerList { manager.removeRecipe(item); }
    mods.jei.JEI.hideItem(item);
}

function SimpleJsonReplaceByName(manager as IRecipeManager, name as string, output as IItemStack, input as IItemStack ) as void {
    val amount = output.amount;
    manager.removeByName(name);
    manager.addJSONRecipe(name, {ingredient:{item:input.registryName},result:output.registryName,count:amount as int});
    return;
}

function replaceByName(name as string, output as IItemStack, recipe as IIngredient[][] ) as void {
    craftingTable.removeByName(name);
    craftingTable.addShaped(name,output,recipe,null);
    return;
}

function replaceByNameMirrored(name as string, output as IItemStack, recipe as IIngredient[][]) as void {
    craftingTable.removeByName(name);
    craftingTable.addShapedMirrored(name,output,recipe,null);
    return;
}

function replaceByNameShapeless(name as string, output as IItemStack, recipe as IIngredient[] ) as void {
    craftingTable.removeByName(name);
    craftingTable.addShapeless(name,output,recipe);
    return;
}

replaceByName("buildersaddition:vertical_slab/reverse/reverse_polished_granite_slab",<item:minecraft:polished_granite>,[[<item:minecraft:polished_granite_slab>,<item:minecraft:polished_granite_slab>]]);
replaceByName("buildersaddition:vertical_slab/reverse/reverse_polished_andesite_slab",<item:minecraft:polished_andesite>,[[<item:minecraft:polished_andesite_slab>,<item:minecraft:polished_andesite_slab>]]);
replaceByName("buildersaddition:vertical_slab/reverse/reverse_polished_diorite_slab",<item:minecraft:polished_diorite>,[[<item:minecraft:polished_diorite_slab>,<item:minecraft:polished_diorite_slab>]]);
replaceByName("buildersaddition:vertical_slab/reverse/reverse_stone_brick_slab",<item:minecraft:stone_bricks>,[[<item:minecraft:stone_brick_slab>,<item:minecraft:stone_brick_slab>]]);
replaceByName("buildersaddition:vertical_slab/reverse/reverse_nether_brick_slab",<item:minecraft:nether_brick>,[[<item:minecraft:nether_brick_slab>,<item:minecraft:nether_brick_slab>]]);
replaceByName("buildersaddition:vertical_slab/reverse/reverse_purpur_slab",<item:minecraft:purpur_block>,[[<item:minecraft:purpur_slab>,<item:minecraft:purpur_slab>]]);
replaceByName("buildersaddition:vertical_slab/reverse/reverse_polished_blackstone_slab",<item:minecraft:polished_blackstone>,[[<item:minecraft:polished_blackstone_slab>,<item:minecraft:polished_blackstone_slab>]]);
replaceByName("buildersaddition:vertical_slab/reverse/reverse_quartz_slab",<item:minecraft:quartz_block>,[[<item:minecraft:quartz_slab>,<item:minecraft:quartz_slab>]]);
replaceByName("buildersaddition:vertical_slab/reverse/reverse_sandstone_slab",<item:minecraft:sandstone>,[[<item:minecraft:sandstone_slab>,<item:minecraft:sandstone_slab>]]);

replaceByName("embellishcraft:granite_paving",<item:embellishcraft:granite_paving>*4,[[<item:quark:granite_bricks>,<item:quark:granite_bricks>],[<item:quark:granite_bricks>,<item:quark:granite_bricks>]]);
replaceByName("embellishcraft:diorite_paving",<item:embellishcraft:diorite_paving>*4,[[<item:quark:diorite_bricks>,<item:quark:diorite_bricks>],[<item:quark:diorite_bricks>,<item:quark:diorite_bricks>]]);
replaceByName("embellishcraft:andesite_paving",<item:embellishcraft:andesite_paving>*4,[[<item:quark:andesite_bricks>,<item:quark:andesite_bricks>],[<item:quark:andesite_bricks>,<item:quark:andesite_bricks>]]);

replaceByName("pamhc2foodcore:tool_roller",<item:pamhc2foodcore:rolleritem>,[[air,air,stick],[air,log,air],[stick,air,air]]);

var rsb = <item:quark:red_sandstone_bricks>;
replaceByName("embllishcraft:red_sandstone_paving_stones",<item:embellishcraft:red_sandstone_paving_stones>*4,[[air,rsb,air],[rsb,air,rsb],[air,rsb,air]]);
removeAndHide(<item:embellishcraft:red_sandstone_bricks>);
replaceByName("embellishcraft:red_sandstone_large_bricks",<item:embellishcraft:red_sandstone_large_bricks>*4,[[rsb,rsb],[rsb,rsb]]);

replaceByName("embellishcraft:granite_large_bricks",<item:quark:granite_bricks>*4,[[<item:embellishcraft:granite_bricks>,<item:embellishcraft:granite_bricks>],[<item:embellishcraft:granite_bricks>,<item:embellishcraft:granite_bricks>]]);
<recipetype:industrialforegoing:stonework_generate>.removeRecipe(<item:embellishcraft:granite_large_bricks>);
replaceByName("embellishcraft:granite_large_bricks_pressure_plate",<item:embellishcraft:granite_large_bricks_pressure_plate>,[[<item:quark:granite_bricks>,<item:quark:granite_bricks>]]);
SimpleJsonReplaceByName(<recipetype:minecraft:stonecutting>,"minecraft:granite_large_bricks_pressure_plate_from_granite_large_bricks_stonecutting",<item:embellishcraft:granite_large_bricks_pressure_plate>*2,<item:quark:granite_bricks>);
removeAndHide(<item:embellishcraft:granite_large_bricks>);
removeFromListAndHide([craftingTable,stoneCutter],<item:embellishcraft:granite_large_bricks_stairs>);
removeFromListAndHide([craftingTable,stoneCutter],<item:embellishcraft:granite_large_bricks_slab>);
removeFromListAndHide([craftingTable,stoneCutter],<item:embellishcraft:granite_large_bricks_wall>);

replaceByName("buildersaddition:vertical_slab/reverse/reverse_red_sandstone_slab",<item:minecraft:red_sandstone>,[[<item:minecraft:red_sandstone_slab>,<item:minecraft:red_sandstone_slab>]]);

replaceByName("minecraft:barrel",<item:minecraft:barrel>,[[wooden_slab,wooden_slab,wooden_slab],[planks,air,planks],[planks,planks,planks]]);
val barrels = <tag:items:forge:barrels/wooden>;
barrels.add(<item:minecraft:barrel>);
for item in <tag:items:charm:barrels>.getElements() {
    barrels.add(item);
}
replaceByName("engineersdecor:independent/fluid_barrel_recipe",<item:engineersdecor:fluid_barrel>,[[bar,bar,bar],[bar,barrels,bar],[bar,bar,bar]]);
replaceByName("storagenetwork:import_filter_kabel",<item:storagenetwork:import_filter_kabel>,[[air,impCable,air],[impCable,barrels,impCable],[air,impCable,air]]);
replaceByName("simplefarming:brewing_barrel",<item:simplefarming:brewing_barrel>,[[fruitLog,ironIngot,fruitLog],[ironIngot,barrels,ironIngot],[fruitLog,ironBucket,fruitLog]]);
replaceByNameShapeless("buildersaddition:planter",<item:buildersaddition:planter>,[dirt,barrels]);

replaceByName("vanillafoodpantry:bits/bit_milk_no_measure",<item:vanillafoodpantry:portion_milk>*4,[[<item:pamhc2foodcore:freshmilkitem>]]);
replaceByName("vanillafoodpantry:bits/bit_water_no_measure",<item:vanillafoodpantry:portion_water>*4,[[<item:pamhc2foodcore:freshwateritem>]]);

removeAndHide(<item:buildersaddition:iron_rod>);

replaceByName("simplefarming:vinegar",<item:simplefarming:vinegar>,[[<tag:items:forge:empty_bottles>,<tag:items:forge:vinegar_ingredients>]]);
replaceByName("simplefarming:jam",<item:simplefarming:jam>,[[<tag:items:forge:fruits>],[<tag:items:forge:empty_bottles>]]);

replaceByName("embellishcraft:sandstone_large_bricks",<item:embellishcraft:sandstone_large_bricks>*4,[[<item:quark:sandstone_bricks>,<item:quark:sandstone_bricks>],[<item:quark:sandstone_bricks>,<item:quark:sandstone_bricks>]]);
replaceByName("embellishcraft:sandstone_bricks_pressure_plate",<item:embellishcraft:sandstone_bricks_pressure_plate>,[[<item:quark:sandstone_bricks>,<item:quark:sandstone_bricks>]]);
replaceByName("embellishcraft:sandstone_paving_stones",<item:embellishcraft:sandstone_paving_stones>*4,[[air,<item:quark:sandstone_bricks>,air],[<item:quark:sandstone_bricks>,air,<item:quark:sandstone_bricks>],[air,<item:quark:sandstone_bricks>,air]]);
SimpleJsonReplaceByName(stoneCutter,"minecraft:sandstone_bricks_pressure_plate_from_sandstone_bricks_stonecutting",<item:embellishcraft:sandstone_bricks_pressure_plate>*2,<item:quark:sandstone_bricks>);
removeAndHide(<item:embellishcraft:sandstone_bricks>);
removeFromListAndHide([craftingTable,stoneCutter],<item:embellishcraft:sandstone_bricks_stairs>);
removeFromListAndHide([craftingTable,stoneCutter],<item:embellishcraft:sandstone_bricks_slab>);
removeFromListAndHide([craftingTable,stoneCutter],<item:embellishcraft:sandstone_bricks_wall>);

replaceByName("immersiveengineering:crafting/metal_ladder_steel",<item:immersiveengineering:metal_ladder_steel>*3,[[<tag:items:immersiveengineering:scaffoldings/steel>],[<item:buildersaddition:iron_ladder_rough>]]);
replaceByName("immersiveengineering:crafting/metal_ladder_alu",<item:immersiveengineering:metal_ladder_alu>*3,[[<tag:items:immersiveengineering:scaffolding/aluminum>],[<item:buildersaddition:iron_ladder>]]);
removeAndHide(<item:immersiveengineering:metal_ladder_none>);
removeAndHide(<item:quark:iron_ladder>); // didn't conflict, just redundant

replaceByName("terraincognita:crafting/compat/quark/apple/vertical_slab",<item:terraincognita:apple_vertical_slab>*3,[[<item:terraincognita:apple_slab>],[<item:terraincognita:apple_slab>],[<item:terraincognita:apple_slab>]]);
replaceByNameMirrored("quark:building/crafting/shinges/shingles",<item:quark:shingles>*2,[[<item:minecraft:terracotta>,air],[air,<item:minecraft:terracotta>]]);
