println("BEGIN MB_steel_ban.zs");

val air = <item:minecraft:air>;
val steel_rod = <item:immersiveengineering:stick_steel>;
val steel_ingot = <item:immersiveengineering:ingot_steel>;
val steel_plate = <item:immersiveengineering:plate_steel>;
val steel_block = <item:immersiveengineering:storage_steel>;
var copper_ingot = <tag:items:forge:ingots/copper>;
var copper_block = <tag:items:forge:storage_blocks/copper>;
var copper_ore = <tag:items:forge:ores/copper>;

for item in [
        <item:mapperbase:flatter_hammer>,
        <item:mapperbase:iron_plate>,
        <item:mapperbase:iron_rod>,
        <item:mapperbase:steel_axe>,
        <item:mapperbase:steel_block>,
        <item:mapperbase:steel_boots>,
        <item:mapperbase:steel_chestplate>,
        <item:mapperbase:steel_fence>,
        <item:mapperbase:steel_helmet>,
        <item:mapperbase:steel_hoe>,
        <item:mapperbase:steel_ingot>,
        <item:mapperbase:steel_leggings>,
        <item:mapperbase:steel_nugget>,
        <item:mapperbase:steel_pickaxe>,
        <item:mapperbase:steel_plate>,
        <item:mapperbase:steel_rod>,
        <item:mapperbase:steel_shovel>,
        <item:mapperbase:steel_sword> ] {
    removeAndHide(item);
}

blastFurnace.removeRecipe(<item:mapperbase:steel_block>);
blastFurnace.removeRecipe(<item:mapperbase:steel_rod>);
blastFurnace.removeRecipe(<item:mapperbase:steel_nugget>);

replaceByNameMirrored("immersiveengineering:crafting/drillhead_steel",<item:immersiveengineering:drillhead_steel>,
    [ [air,air,steel_ingot],[steel_ingot,steel_ingot,air],[steel_block,steel_ingot,air] ]);

replaceByName("immersiveengineering:crafting/steel_scaffolding_standard",<item:immersiveengineering:steel_scaffolding_standard>*6,
    [ [steel_ingot,steel_ingot,steel_ingot],[air,steel_rod,air],[steel_rod,air,steel_rod] ]);

SimpleJsonReplace(<recipetype:transport:rail_workers_bench>,<item:transport:steam_locomotive>,steel_block);

//copper ban
for item in [
	<item:cavesandcliffs:waxed_oxidized_cut_copper_slab>,
	<item:cavesandcliffs:waxed_weathered_cut_copper_slab>,
	<item:cavesandcliffs:waxed_cut_copper_slab>,
	<item:cavesandcliffs:waxed_exposed_cut_copper_slab>,
	<item:cavesandcliffs:waxed_oxidized_cut_copper_stairs>,
	<item:cavesandcliffs:waxed_weathered_cut_copper_stairs>,
	<item:cavesandcliffs:waxed_exposed_cut_copper_stairs>,
	<item:cavesandcliffs:waxed_cut_copper_stairs>,
	<item:cavesandcliffs:waxed_oxidized_cut_copper>,
	<item:cavesandcliffs:raw_copper_block>,
	<item:cavesandcliffs:exposed_copper>,
	<item:cavesandcliffs:weathered_copper>,
	<item:cavesandcliffs:oxidized_copper>,
	<item:cavesandcliffs:cut_copper>,
	<item:cavesandcliffs:exposed_cut_copper>,
	<item:cavesandcliffs:weathered_cut_copper>,
	<item:cavesandcliffs:oxidized_cut_copper>,
	<item:cavesandcliffs:cut_copper_stairs>,
	<item:cavesandcliffs:exposed_cut_copper_vertical_slab>,
	<item:cavesandcliffs:cut_copper_vertical_slab>,
	<item:cavesandcliffs:oxidized_cut_copper_slab>,
	<item:cavesandcliffs:weathered_cut_copper_slab>,
	<item:cavesandcliffs:exposed_cut_copper_slab>,
	<item:cavesandcliffs:cut_copper_slab>,
	<item:cavesandcliffs:oxidized_cut_copper_stairs>,
	<item:cavesandcliffs:weathered_cut_copper_stairs>,
	<item:cavesandcliffs:exposed_cut_copper_stairs>,
	<item:cavesandcliffs:weathered_cut_copper_vertical_slab>,
	<item:cavesandcliffs:oxidized_cut_copper_vertical_slab>,
	<item:cavesandcliffs:waxed_copper_block>,
	<item:cavesandcliffs:waxed_exposed_copper>,
	<item:cavesandcliffs:waxed_weathered_copper>,
	<item:cavesandcliffs:waxed_oxidized_copper>,
	<item:cavesandcliffs:waxed_cut_copper>,
	<item:cavesandcliffs:waxed_exposed_cut_copper>,
	<item:cavesandcliffs:waxed_weathered_cut_copper>,
	<item:cavesandcliffs:waxed_cut_copper_vertical_slab>,
	<item:cavesandcliffs:waxed_exposed_cut_copper_vertical_slab>,
	<item:cavesandcliffs:waxed_weathered_cut_copper_vertical_slab>,
	<item:cavesandcliffs:waxed_oxidized_cut_copper_vertical_slab>
]{
    removeAndHide(item);
}

furnace.removeRecipe(<item:cavesandcliffs:copper_ingot>);
blastFurnace.removeRecipe(<item:cavesandcliffs:copper_ingot>);

//removeAllTagsAndHide(<item:cavesandcliffs:copper_ingot>);
craftingTable.addShapeless("cc_copper_to_ie", <item:immersiveengineering:ingot_copper>, [<item:cavesandcliffs:copper_ingot>]);

removeAllTagsAndHide(<item:cavesandcliffs:copper_ore>);
removeAllTagsAndHide(<item:cavesandcliffs:raw_copper>);
removeAllTagsAndHide(<item:cavesandcliffs:copper_block>);
removeAllTagsAndHide(<item:cavesandcliffs:deepslate_copper_ore>);
craftingTable.removeByName("cavesandcliffs:copper_block");

<recipetype:minecraft:blasting>.addRecipe("cc_copper_ore", <item:immersiveengineering:ingot_copper>, <item:cavesandcliffs:copper_ore>, 0.1, 10*20);
<recipetype:minecraft:blasting>.addRecipe("cc_copper_raw", <item:immersiveengineering:ingot_copper>, <item:cavesandcliffs:raw_copper>, 0.1, 10*20);

//craftingTable.addShapeless("cc_copper_block", <item:immersiveengineering:ingot_copper> * 9, [<item:cavesandcliffs:copper_block>]);
craftingTable.addShaped("cc_copper_plate", <item:immersiveengineering:plate_copper>,[
    [<item:minecraft:air>, <item:immersiveengineering:hammer>.anyDamage().transformDamage(), <item:minecraft:air>],
    [<item:minecraft:air>, <item:cavesandcliffs:copper_ingot>, <item:minecraft:air>],
    [<item:minecraft:air>, <item:cavesandcliffs:copper_ingot>, <item:minecraft:air>]
]);



println("END MB_steel_ban.zs");
