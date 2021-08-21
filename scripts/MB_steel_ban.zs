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

println("END MB_steel_ban.zs");
