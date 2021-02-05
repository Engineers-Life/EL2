import crafttweaker.api.item.IItemStack;
var iron_plate = <item:immersiveengineering:plate_iron>;
var steel_plate = <item:immersiveengineering:plate_steel>;
var air = <item:minecraft:air>;
var stick = <item:minecraft:stick>;

//mods.jei.JEI.hideItem(<item:farmersdelight:flint_knife>);
//craftingTable.removeRecipe(<item:farmersdelight:flint_knife>);
//<item:immersiveengineering:pickaxe_steel>.maxDamage = 1200;
////////////////
craftingTable.removeRecipe(<item:immersiveengineering:plate_steel>);
craftingTable.addShaped("steel_plate", <item:immersiveengineering:plate_steel>, [
[<item:immersiveengineering:hammer>.anyDamage().transformDamage()], 
[<item:immersiveengineering:ingot_steel>], 
[<item:immersiveengineering:ingot_steel>]], null);

craftingTable.removeRecipe(<item:immersiveengineering:pickaxe_steel>);
craftingTable.addShaped("steel_pickaxe", <item:immersiveengineering:pickaxe_steel>, [
[steel_plate, steel_plate, steel_plate], 
[air, stick, air], 
[air, stick, air]], null);

craftingTable.removeRecipe(<item:immersiveengineering:sword_steel>);
craftingTable.addShaped("steel_sword", <item:immersiveengineering:sword_steel>, [
[steel_plate], 
[steel_plate], 
[stick]], null);

craftingTable.removeRecipe(<item:immersiveengineering:shovel_steel>);
craftingTable.addShaped("steel_shovel", <item:immersiveengineering:shovel_steel>, [
[steel_plate], 
[stick], 
[stick]], null);

craftingTable.removeRecipe(<item:immersiveengineering:axe_steel>);
craftingTable.addShapedMirrored("steel_axe", <item:immersiveengineering:axe_steel>, [
[steel_plate, steel_plate], 
[steel_plate, stick], 
[air, stick]], null);

craftingTable.removeRecipe(<item:immersiveengineering:hoe_steel>);
craftingTable.addShapedMirrored("steel_hoe", <item:immersiveengineering:hoe_steel>, [
[steel_plate,  steel_plate], 
[air, stick], 
[air, stick]], null);

//////////////////

craftingTable.removeRecipe(<item:immersiveengineering:plate_iron>);
craftingTable.addShaped("iron_plate", <item:immersiveengineering:plate_iron>, [
[<item:immersiveengineering:hammer>.anyDamage().transformDamage()], 
[<item:minecraft:iron_ingot>], 
[<item:minecraft:iron_ingot>]], null);

craftingTable.removeRecipe(<item:minecraft:iron_pickaxe>);
craftingTable.addShaped("iron_pickaxe", <item:minecraft:iron_pickaxe>, [
[iron_plate, iron_plate, iron_plate], 
[air, stick, air], 
[air, stick, air]], null);

craftingTable.removeRecipe(<item:minecraft:iron_sword>);
craftingTable.addShaped("iron_sword", <item:minecraft:iron_sword>, [
[iron_plate], 
[iron_plate], 
[stick]], null);

craftingTable.removeRecipe(<item:minecraft:iron_shovel>);
craftingTable.addShaped("iron_shovel", <item:minecraft:iron_shovel>, [
[iron_plate], 
[stick], 
[stick]], null);

craftingTable.removeRecipe(<item:minecraft:iron_axe>);
craftingTable.addShapedMirrored("iron_axe", <item:minecraft:iron_axe>, [
[iron_plate, iron_plate], 
[iron_plate, stick], 
[air, stick]], null);

craftingTable.removeRecipe(<item:minecraft:iron_hoe>);
craftingTable.addShapedMirrored("iron_hoe", <item:minecraft:iron_hoe>, [
[iron_plate,  iron_plate], 
[air, stick], 
[air, stick]], null);

craftingTable.removeRecipe(<item:minecraft:iron_helmet>);
craftingTable.addShaped("iron_helmet", <item:minecraft:iron_helmet>, [
[iron_plate,  iron_plate, iron_plate], 
[iron_plate, air, iron_plate]], null);

craftingTable.removeRecipe(<item:minecraft:iron_chestplate>);
craftingTable.addShaped("iron_chestplate", <item:minecraft:iron_chestplate>, [
[iron_plate, air, iron_plate], 
[iron_plate, iron_plate, iron_plate], 
[iron_plate, iron_plate, iron_plate]], null);

craftingTable.removeRecipe(<item:minecraft:iron_leggings>);
craftingTable.addShaped("iron_leggins", <item:minecraft:iron_leggings>, [
[iron_plate, iron_plate, iron_plate], 
[iron_plate, air, iron_plate], 
[iron_plate, air, iron_plate]], null);

craftingTable.removeRecipe(<item:minecraft:iron_boots>);
craftingTable.addShaped("iron_boots", <item:minecraft:iron_boots>, [
[iron_plate, air, iron_plate], 
[iron_plate, air, iron_plate]], null);

craftingTable.removeRecipe(<item:notreepunching:iron_saw>);
craftingTable.addShapedMirrored("iron_saw", <item:notreepunching:iron_saw>, [
[air, air, stick], 
[air, stick, iron_plate], 
[stick, iron_plate, air]], null);

craftingTable.removeRecipe(<item:notreepunching:iron_mattock>);
craftingTable.addShapedMirrored("iron_mattock", <item:notreepunching:iron_mattock>, [
[iron_plate, iron_plate, iron_plate], 
[air, stick, iron_plate], 
[air, stick, air]], null);

craftingTable.removeRecipe(<item:notreepunching:clay_tool>);
craftingTable.addShapedMirrored("clay_tool", <item:notreepunching:clay_tool>, [
[air, air, stick], 
[air, stick, <item:minecraft:iron_ingot>], 
[stick, air, air]], null);

craftingTable.removeRecipe(<item:minecraft:bucket>);
craftingTable.addShaped("iron_bucket", <item:minecraft:bucket>, [
[iron_plate, air, iron_plate], 
[air, iron_plate, air]], null);

craftingTable.removeRecipe(<item:minecraft:hopper>);
craftingTable.addShaped("iron_hopper", <item:minecraft:hopper>, [
[iron_plate, air, iron_plate], 
[iron_plate, <tag:items:forge:chests>, iron_plate], 
[air, iron_plate, air]], null);

//craftingTable.removeRecipe();
//craftingTable.addShaped("", , [
//[air, air, air], 
//[air, air, air], 
//[air, air, air]], null);




