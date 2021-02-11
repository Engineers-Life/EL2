import crafttweaker.api.registries.ICookingRecipeManager;
import crafttweaker.api.registries.IRecipeManager;

//Custom Charm Kiln Recipes
	
	<recipetype:firing>.addJSONRecipe("Clay_Bricks_to_Bricks", {ingredient:{item:<item:notreepunching:clay_brick>.registryName},result:<item:minecraft:brick>.registryName,experience:0.35 as float, cookingtime:100});
	<recipetype:firing>.addJSONRecipe("Clay_Blocks_to_Terracotta", {ingredient:{item:<item:minecraft:clay>.registryName},result:<item:minecraft:terracotta>.registryName,experience:0.35 as float, cookingtime:100});
	<recipetype:firing>.addJSONRecipe("Clay_Large_Vessel_to_Ceramic_Large_Vessel", {ingredient:{item:<item:notreepunching:clay_large_vessel>.registryName},result:<item:notreepunching:ceramic_large_vessel>.registryName,experience:0.35 as float, cookingtime:100});
	<recipetype:firing>.addJSONRecipe("Clay_Small_Vessel_to_Ceramic_Small_Vessel", {ingredient:{item:<item:notreepunching:clay_small_vessel>.registryName},result:<item:notreepunching:ceramic_small_vessel>.registryName,experience:0.35 as float, cookingtime:100});
	<recipetype:firing>.addJSONRecipe("Clay_Bucket_to_Ceramic_Bucket", {ingredient:{item:<item:notreepunching:clay_bucket>.registryName},result:<item:notreepunching:ceramic_bucket>.registryName,experience:0.35 as float, cookingtime:100});
	<recipetype:firing>.addJSONRecipe("Clay_Flower_Pot_to_Flower_pot", {ingredient:{item:<item:notreepunching:clay_flower_pot>.registryName},result:<item:minecraft:flower_pot>.registryName,experience:0.35 as float, cookingtime:100});
	
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
	
//	These 2 aren't working for some reason	
	furnace.removeRecipe(<item:notreepunching:ceramic_large_vessel>, <item:notreepunching:clay_large_vessel>);
	furnace.removeRecipe(<item:notreepunching:ceramic_small_vessel>, <item:notreepunching:clay_small_vessel>);
	

