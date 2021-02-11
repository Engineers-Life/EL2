var air = <item:minecraft:air>;

mods.jei.JEI.hideItem(<item:productivebees:centrifuge>);
craftingTable.removeRecipe(<item:productivebees:centrifuge>);
craftingTable.removeRecipe(<item:productivebees:powered_centrifuge>);
craftingTable.addShaped("powered_centrifuge", <item:productivebees:powered_centrifuge>, [
[<item:minecraft:iron_ingot>, <item:minecraft:iron_ingot>, <item:minecraft:iron_ingot>], 
[<item:minecraft:piston>, <item:minecraft:grindstone>, <item:minecraft:piston>], 
[<item:minecraft:redstone>, <item:minecraft:iron_ingot>, <item:minecraft:redstone>]], null);

craftingTable.removeRecipe(<item:productivebees:advanced_oak_beehive>);
craftingTable.addShaped("advanced_oak_beehive", <item:productivebees:advanced_oak_beehive>, [
[<item:minecraft:oak_planks>, <item:minecraft:oak_planks>, <item:minecraft:oak_planks>], 
[<item:minecraft:honeycomb>, <item:minecraft:beehive>, <item:minecraft:honeycomb>], 
[<item:minecraft:soul_campfire>, <item:minecraft:oak_planks>, <item:minecraft:shears>]], null);





//craftingTable.removeRecipe(<item:farmersdelight:stove>);
//craftingTable.addShaped("stove", <item:farmersdelight:stove>, [
//[<item:minecraft:iron_ingot>, <item:minecraft:iron_ingot>, <item:minecraft:iron_ingot>], 
//[<item:minecraft:bricks>, air, <item:minecraft:bricks>], 
//[<item:minecraft:bricks>, <item:minecraft:furnace>, <item:minecraft:bricks>]], null);

craftingTable.removeRecipe(<item:storagenetwork:master>);
craftingTable.addShaped("storage_master", <item:storagenetwork:master>, [
[<item:minecraft:quartz_block>, <item:storagenetwork:kabel>, <item:minecraft:quartz_block>], 
[<item:storagenetwork:kabel>, <item:minecraft:nether_star>, <item:storagenetwork:kabel>], 
[<item:minecraft:quartz_block>, <item:storagenetwork:kabel>, <item:minecraft:quartz_block>]], null);

craftingTable.removeRecipe(<item:storagenetwork:storage_kabel>);
craftingTable.addShaped("storage_cabel", <item:storagenetwork:storage_kabel>*4, [
[air, <item:storagenetwork:kabel>, air], 
[<item:storagenetwork:kabel>, <item:minecraft:ender_pearl>, <item:storagenetwork:kabel>], 
[air, <item:storagenetwork:kabel>, air]], null);

craftingTable.removeRecipe(<item:transport:rail_workers_bench>);
craftingTable.addShaped("rail_workers_bench", <item:transport:rail_workers_bench>, [
[air, <tag:items:minecraft:rails>, air],
[<item:immersiveengineering:light_engineering>, <item:immersiveengineering:light_engineering>, <item:immersiveengineering:light_engineering>]], null);

craftingTable.removeRecipe(<item:industrialforegoing:machine_frame_pity>);
craftingTable.addShaped("machine_frame_pity", <item:industrialforegoing:machine_frame_pity>, [
[<tag:items:forge:treated_wood>, <item:minecraft:iron_ingot>, <tag:items:forge:treated_wood>],
[<item:minecraft:iron_ingot>, <item:immersiveengineering:rs_engineering>, <item:minecraft:iron_ingot>],
[<tag:items:forge:treated_wood>, <item:minecraft:iron_ingot>, <tag:items:forge:treated_wood>]], null);
