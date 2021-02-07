import crafttweaker.api.item.MCItemDefinition;
import crafttweaker.api.item.IItemStack;
import crafttweaker.api.tag.MCTag;

val air = <item:minecraft:air>;
val stick = <tag:items:forge:rods/wooden>.asIIngredient();
val tool_stone = <tag:items:minecraft:stone_tool_materials>.asIIngredient();
val iron_plate = <tag:items:forge:plates/iron>.asIIngredient();
val steel_plate = <tag:items:forge:plates/steel>.asIIngredient();
val tool_terminite = <item:betterendforge:terminite_ingot>;

// STONE TOOLS

craftingTable.removeRecipe(<item:minecraft:stone_sword>);
craftingTable.addShaped("stone_sword", <item:minecraft:stone_sword>, [
[tool_stone],[tool_stone],[stick]]);

craftingTable.removeRecipe(<item:minecraft:stone_shovel>);
craftingTable.addShaped("stone_shovel", <item:minecraft:stone_shovel>, [
[tool_stone],[stick],[stick]]);

craftingTable.removeRecipe(<item:minecraft:stone_pickaxe>);
craftingTable.addShaped("stone_pickaxe", <item:minecraft:stone_pickaxe>, [
[tool_stone,tool_stone,tool_stone],[air,stick,air],[air,stick,air]]);

craftingTable.removeRecipe(<item:minecraft:stone_axe>);
craftingTable.addShapedMirrored("stone_axe", <item:minecraft:stone_axe>, [
[tool_stone,tool_stone],[tool_stone,stick],[air,stick]]);

craftingTable.removeRecipe(<item:minecraft:stone_hoe>);
craftingTable.addShapedMirrored("stone_hoe", <item:minecraft:stone_hoe>, [
[tool_stone,tool_stone],[tool_stone,stick],[air,stick]]);

// TERMINITE TOOLS

craftingTable.removeRecipe(<item:betterendforge:terminite_sword>);
craftingTable.addShaped("terminite_sword", <item:betterendforge:terminite_sword>, [
[tool_terminite],[tool_terminite],[stick]]);

craftingTable.removeRecipe(<item:betterendforge:terminite_shovel>);
craftingTable.addShaped("terminite_shovel", <item:betterendforge:terminite_shovel>, [
[tool_terminite],[stick],[stick]]);

craftingTable.removeRecipe(<item:betterendforge:terminite_pickaxe>);
craftingTable.addShaped("terminite_pickaxe", <item:betterendforge:terminite_pickaxe>, [
[tool_terminite,tool_terminite,tool_terminite],[air,stick,air],[air,stick,air]]);

craftingTable.removeRecipe(<item:betterendforge:terminite_axe>);
craftingTable.addShapedMirrored("terminite_axe", <item:betterendforge:terminite_axe>, [
[tool_terminite,tool_terminite],[tool_terminite,stick],[air,stick]]);

craftingTable.removeRecipe(<item:betterendforge:terminite_hoe>);
craftingTable.addShapedMirrored("terminite_hoe", <item:betterendforge:terminite_hoe>, [
[tool_terminite,tool_terminite],[tool_terminite,stick],[air,stick]]);

craftingTable.removeRecipe(<item:betterendforge:terminite_hammer>);
craftingTable.addShaped("terminite_hammer", <item:betterendforge:terminite_hammer>, [
[tool_terminite,air,tool_terminite],[tool_terminite,stick,tool_terminite],[air,stick,air]]);

// STEEL PLATES

craftingTable.removeRecipe(<item:immersiveengineering:plate_steel>);
craftingTable.addShaped("steel_plate", <item:immersiveengineering:plate_steel>, [
[<item:immersiveengineering:hammer>.anyDamage().transformDamage()], 
[<item:immersiveengineering:ingot_steel>], 
[<item:immersiveengineering:ingot_steel>]]);

craftingTable.removeRecipe(<item:immersiveengineering:pickaxe_steel>);
craftingTable.addShaped("steel_pickaxe", <item:immersiveengineering:pickaxe_steel>, [
[steel_plate, steel_plate, steel_plate], 
[air, stick, air], 
[air, stick, air]]);

craftingTable.removeRecipe(<item:immersiveengineering:sword_steel>);
craftingTable.addShaped("steel_sword", <item:immersiveengineering:sword_steel>, [
[steel_plate], 
[steel_plate], 
[stick]]);

craftingTable.removeRecipe(<item:immersiveengineering:shovel_steel>);
craftingTable.addShaped("steel_shovel", <item:immersiveengineering:shovel_steel>, [
[steel_plate], 
[stick], 
[stick]]);

craftingTable.removeRecipe(<item:immersiveengineering:axe_steel>);
craftingTable.addShapedMirrored("steel_axe", <item:immersiveengineering:axe_steel>, [
[steel_plate, steel_plate], 
[steel_plate, stick], 
[air, stick]]);

craftingTable.removeRecipe(<item:immersiveengineering:hoe_steel>);
craftingTable.addShapedMirrored("steel_hoe", <item:immersiveengineering:hoe_steel>, [
[steel_plate,  steel_plate], 
[air, stick], 
[air, stick]]);

// IRON PLATES

craftingTable.removeRecipe(<item:immersiveengineering:plate_iron>);
craftingTable.addShaped("iron_plate", <item:immersiveengineering:plate_iron>, [
[<item:immersiveengineering:hammer>.anyDamage().transformDamage()], 
[<item:minecraft:iron_ingot>], 
[<item:minecraft:iron_ingot>]]);

craftingTable.removeRecipe(<item:minecraft:iron_pickaxe>);
craftingTable.addShaped("iron_pickaxe", <item:minecraft:iron_pickaxe>, [
[iron_plate, iron_plate, iron_plate], 
[air, stick, air], 
[air, stick, air]]);

craftingTable.removeRecipe(<item:minecraft:iron_sword>);
craftingTable.addShaped("iron_sword", <item:minecraft:iron_sword>, [
[iron_plate], 
[iron_plate], 
[stick]]);

craftingTable.removeRecipe(<item:minecraft:iron_shovel>);
craftingTable.addShaped("iron_shovel", <item:minecraft:iron_shovel>, [
[iron_plate], 
[stick], 
[stick]]);

craftingTable.removeRecipe(<item:minecraft:iron_axe>);
craftingTable.addShapedMirrored("iron_axe", <item:minecraft:iron_axe>, [
[iron_plate, iron_plate], 
[iron_plate, stick], 
[air, stick]]);

craftingTable.removeRecipe(<item:minecraft:iron_hoe>);
craftingTable.addShapedMirrored("iron_hoe", <item:minecraft:iron_hoe>, [
[iron_plate,  iron_plate], 
[air, stick], 
[air, stick]]);

craftingTable.removeRecipe(<item:minecraft:iron_helmet>);
craftingTable.addShaped("iron_helmet", <item:minecraft:iron_helmet>, [
[iron_plate,  iron_plate, iron_plate], 
[iron_plate, air, iron_plate]]);

craftingTable.removeRecipe(<item:minecraft:iron_chestplate>);
craftingTable.addShaped("iron_chestplate", <item:minecraft:iron_chestplate>, [
[iron_plate, air, iron_plate], 
[iron_plate, iron_plate, iron_plate], 
[iron_plate, iron_plate, iron_plate]]);

craftingTable.removeRecipe(<item:minecraft:iron_leggings>);
craftingTable.addShaped("iron_leggins", <item:minecraft:iron_leggings>, [
[iron_plate, iron_plate, iron_plate], 
[iron_plate, air, iron_plate], 
[iron_plate, air, iron_plate]]);

craftingTable.removeRecipe(<item:minecraft:iron_boots>);
craftingTable.addShaped("iron_boots", <item:minecraft:iron_boots>, [
[iron_plate, air, iron_plate], 
[iron_plate, air, iron_plate]]);

craftingTable.removeRecipe(<item:notreepunching:iron_saw>);
craftingTable.addShapedMirrored("iron_saw", <item:notreepunching:iron_saw>, [
[air, air, stick], 
[air, stick, iron_plate], 
[stick, iron_plate, air]]);

craftingTable.removeRecipe(<item:notreepunching:iron_mattock>);
craftingTable.addShapedMirrored("iron_mattock", <item:notreepunching:iron_mattock>, [
[iron_plate, iron_plate, iron_plate], 
[air, stick, iron_plate], 
[air, stick, air]]);

craftingTable.removeRecipe(<item:minecraft:bucket>);
craftingTable.addShaped("iron_bucket", <item:minecraft:bucket>, [
[iron_plate, air, iron_plate], 
[air, iron_plate, air]]);

craftingTable.removeRecipe(<item:minecraft:hopper>);
craftingTable.addShaped("iron_hopper", <item:minecraft:hopper>, [
[iron_plate, air, iron_plate], 
[iron_plate, <tag:items:forge:chests>, iron_plate], 
[air, iron_plate, air]]);

// OTHER RECIPE CHANGES

craftingTable.removeRecipe(<item:notreepunching:clay_tool>);
craftingTable.addShapedMirrored("clay_tool", <item:notreepunching:clay_tool>, [
[air, air, stick], 
[air, stick, <item:minecraft:iron_ingot>], 
[stick, air, air]]);

// EXAMPLES:

//mods.jei.JEI.hideItem(<item:farmersdelight:flint_knife>);
//<item:immersiveengineering:pickaxe_steel>.maxDamage = 1200;
