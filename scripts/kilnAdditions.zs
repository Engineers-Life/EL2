import crafttweaker.api.registries.ICookingRecipeManager;
import crafttweaker.api.registries.IRecipeManager;

//Custom Charm Kiln Recipes
	
	<recipetype:firing>.addJSONRecipe("clay_bricks_to_bricks", {ingredient:{item:<item:notreepunching:clay_brick>.registryName},result:<item:minecraft:brick>.registryName,experience:0.35 as float, cookingtime:100});
	<recipetype:firing>.addJSONRecipe("clay_blocks_to_terracotta", {ingredient:{item:<item:minecraft:clay>.registryName},result:<item:minecraft:terracotta>.registryName,experience:0.35 as float, cookingtime:100});
	<recipetype:firing>.addJSONRecipe("clay_large_vessel_to_ceramic_large_vessel", {ingredient:{item:<item:notreepunching:clay_large_vessel>.registryName},result:<item:notreepunching:ceramic_large_vessel>.registryName,experience:0.35 as float, cookingtime:100});
	<recipetype:firing>.addJSONRecipe("clay_small_vessel_to_ceramic_small_vessel", {ingredient:{item:<item:notreepunching:clay_small_vessel>.registryName},result:<item:notreepunching:ceramic_small_vessel>.registryName,experience:0.35 as float, cookingtime:100});
	<recipetype:firing>.addJSONRecipe("clay_bucket_to_ceramic_bucket", {ingredient:{item:<item:notreepunching:clay_bucket>.registryName},result:<item:notreepunching:ceramic_bucket>.registryName,experience:0.35 as float, cookingtime:100});
	<recipetype:firing>.addJSONRecipe("clay_flower_pot_to_flower_pot", {ingredient:{item:<item:notreepunching:clay_flower_pot>.registryName},result:<item:minecraft:flower_pot>.registryName,experience:0.35 as float, cookingtime:100});
	<recipetype:firing>.addJSONRecipe("gold_ore_to_ingot", {ingredient:{item:<item:minecraft:gold_ore>.registryName},result:<item:minecraft:gold_ingot>.registryName,experience:0.35 as float, cookingtime:100});
	<recipetype:firing>.addJSONRecipe("gold_nether_ore_to_ingot", {ingredient:{item:<item:minecraft:nether_gold_ore>.registryName},result:<item:minecraft:gold_ingot>.registryName,experience:0.35 as float, cookingtime:100});
	<recipetype:firing>.addJSONRecipe("gold_grit_to_ingot", {ingredient:{item:<item:immersiveengineering:dust_gold>.registryName},result:<item:minecraft:gold_ingot>.registryName,experience:0.35 as float, cookingtime:100});
	
//Remove duplicate kiln & furnace recipes from furnace

	furnace.removeRecipe(<item:minecraft:nether_brick>, <item:minecraft:netherrack>);
	furnace.removeRecipe(<item:minecraft:smooth_sandstone>, <item:minecraft:sandstone>);
	furnace.removeRecipe(<item:minecraft:smooth_red_sandstone>, <item:minecraft:red_sandstone>);
	furnace.removeRecipe(<item:minecraft:glass>, <item:minecraft:sand>);
	furnace.removeRecipe(<item:minecraft:glass>, <item:minecraft:red_sand>);
	furnace.removeRecipe(<item:minecraft:terracotta>, <item:minecraft:clay>);
	furnace.removeRecipe(<item:minecraft:sandstone>, <item:minecraft:sand>);
	furnace.removeRecipe(<item:minecraft:red_sandstone>, <item:minecraft:red_sand>);
	furnace.removeRecipe(<item:minecraft:light_gray_glazed_terracotta>, <item:minecraft:light_gray_terracotta>);
	furnace.removeRecipe(<item:minecraft:black_glazed_terracotta>, <item:minecraft:black_terracotta>);
	furnace.removeRecipe(<item:minecraft:magenta_glazed_terracotta>, <item:minecraft:magenta_terracotta>);
	furnace.removeRecipe(<item:minecraft:light_blue_glazed_terracotta>, <item:minecraft:light_blue_terracotta>);
	furnace.removeRecipe(<item:minecraft:purple_glazed_terracotta>, <item:minecraft:purple_terracotta>);
	furnace.removeRecipe(<item:minecraft:pink_glazed_terracotta>, <item:minecraft:pink_terracotta>);
	furnace.removeRecipe(<item:minecraft:brown_glazed_terracotta>, <item:minecraft:brown_terracotta>);
	furnace.removeRecipe(<item:minecraft:red_glazed_terracotta>, <item:minecraft:red_terracotta>);
	furnace.removeRecipe(<item:minecraft:white_glazed_terracotta>, <item:minecraft:white_terracotta>);
	furnace.removeRecipe(<item:minecraft:yellow_glazed_terracotta>, <item:minecraft:yellow_terracotta>);
	furnace.removeRecipe(<item:minecraft:cyan_glazed_terracotta>, <item:minecraft:cyan_terracotta>);
	furnace.removeRecipe(<item:minecraft:green_glazed_terracotta>, <item:minecraft:green_terracotta>);
	furnace.removeRecipe(<item:minecraft:orange_glazed_terracotta>, <item:minecraft:orange_terracotta>);
	furnace.removeRecipe(<item:minecraft:lime_glazed_terracotta>, <item:minecraft:lime_terracotta>);
	furnace.removeRecipe(<item:minecraft:gray_glazed_terracotta>, <item:minecraft:gray_terracotta>);
	furnace.removeRecipe(<item:minecraft:blue_glazed_terracotta>, <item:minecraft:blue_terracotta>);
	furnace.removeRecipe(<item:minecraft:flower_pot>, <item:notreepunching:clay_flower_pot>);
	furnace.removeRecipe(<item:notreepunching:ceramic_bucket>, <item:notreepunching:clay_bucket>);
	
	// remove by recipe name because of item tags messing with remove by output
	furnace.removeByName("notreepunching:smelting/large_vessel");
	furnace.removeByName("notreepunching:smelting/small_vessel");
