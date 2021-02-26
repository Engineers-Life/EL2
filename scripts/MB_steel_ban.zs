
println("BEGIN MB_steel_ban.zs");

val air = <item:minecraft:air>;
val steel_rod = <item:immersiveengineering:stick_steel>;
val steel_ingot = <item:immersiveengineering:ingot_steel>;
val steel_plate = <item:immersiveengineering:plate_steel>;
val steel_block = <item:immersiveengineering:storage_steel>;

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
    craftingTable.removeRecipe(item);
    mods.jei.JEI.hideItem(item);
}

<tag:items:forge:storage_blocks>.remove(<item:mapperbase:steel_block>);
<tag:items:forge:storage_blocks/steel>.remove(<item:mapperbase:steel_block>);
blastFurnace.removeRecipe(<item:mapperbase:steel_block>);

craftingTable.removeByName("immersiveengineering:crafting/drillhead_steel");
craftingTable.addShaped("drillhead_steel", <item:immersiveengineering:drillhead_steel>,
    [ [air,air,steel_ingot],[steel_ingot,steel_ingot,air],[steel_block,steel_ingot,air] ]);

<tag:items:forge:rods/steel>.remove(<item:mapperbase:steel_rod>);
<tag:items:forge:rods/all_metal>.remove(<item:mapperbase:steel_rod>);
blastFurnace.removeRecipe(<item:mapperbase:steel_rod>);

craftingTable.removeByName("immersiveengineering:crafting/steel_scaffolding_standard");
craftingTable.addShaped("steel_scaffolding_standard", <item:immersiveengineering:steel_scaffolding_standard>*6,
    [ [steel_ingot,steel_ingot,steel_ingot],[air,steel_rod,air],[steel_rod,air,steel_rod] ]);

<tag:items:forge:plates>.remove(<item:mapperbase:steel_plate>);
<tag:items:forge:plates/steel>.remove(<item:mapperbase:steel_plate>);

blastFurnace.removeRecipe(<item:mapperbase:steel_nugget>);

<tag:items:forge:rods/all_metal>.remove(<item:mapperbase:iron_rod>);
<tag:items:forge:rods/iron>.remove(<item:mapperbase:iron_rod>);

<recipetype:transport:rail_workers_bench>.removeRecipe(<item:transport:steam_locomotive>);
<recipetype:transport:rail_workers_bench>.addJSONRecipe("steam_loco", {ingredient:{item:<item:immersiveengineering:storage_steel>.registryName},result:<item:transport:steam_locomotive>.registryName});

println("END MB_steel_ban.zs");
