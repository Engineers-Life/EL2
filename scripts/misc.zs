import crafttweaker.api.item.IIngredient;

println("BEGIN misc.zs");

var air = <item:minecraft:air>;
var cobblestone = <item:minecraft:cobblestone>;

craftingTable.addShaped("larvikite_cobblestone", <item:embellishcraft:larvikite_cobblestone> * 8, [
    [cobblestone,cobblestone,cobblestone],
    [cobblestone, <item:minecraft:blue_dye>, cobblestone], 
	[cobblestone, cobblestone, cobblestone]]);
	
craftingTable.addShaped("jade_cobblestone", <item:embellishcraft:jade_cobblestone> * 8, [
    [cobblestone,cobblestone,cobblestone],
    [cobblestone, <item:minecraft:green_dye>, cobblestone], 
	[cobblestone, cobblestone, cobblestone]]);
	
craftingTable.addShaped("gneiss_cobblestone", <item:embellishcraft:gneiss_cobblestone> * 8, [
    [cobblestone,cobblestone,cobblestone],
    [cobblestone, <item:minecraft:white_dye>, cobblestone], 
	[cobblestone, cobblestone, cobblestone]]);
	
craftingTable.addShaped("basalt_cobblestone", <item:embellishcraft:basalt_cobblestone> * 8, [
    [cobblestone,cobblestone,cobblestone],
    [cobblestone, <item:minecraft:black_dye>, cobblestone], 
	[cobblestone, cobblestone, cobblestone]]);

removeAndHide(<item:productivebees:centrifuge>);
replaceByName("productivebees:powered_centrifuge/vanilla",<item:productivebees:powered_centrifuge>, [
    [<item:minecraft:iron_ingot>, <item:minecraft:iron_ingot>, <item:minecraft:iron_ingot>],
    [<item:minecraft:piston>, <item:minecraft:grindstone>, <item:minecraft:piston>],
    [<item:minecraft:redstone>, <item:minecraft:iron_ingot>, <item:minecraft:redstone>] ]);

// replace all crafting uses of the campfire with soul_campfire
changeIngredient(<item:minecraft:campfire>,<item:minecraft:soul_campfire>);

//craftingTable.removeRecipe(<item:farmersdelight:stove>);
//craftingTable.addShaped("stove", <item:farmersdelight:stove>, [
//[<item:minecraft:iron_ingot>, <item:minecraft:iron_ingot>, <item:minecraft:iron_ingot>], 
//[<item:minecraft:bricks>, air, <item:minecraft:bricks>], 
//[<item:minecraft:bricks>, <item:minecraft:furnace>, <item:minecraft:bricks>]], null);

replaceByName("storagenetwork:master",<item:storagenetwork:master>, [
    [<item:minecraft:quartz_block>, <item:storagenetwork:kabel>, <item:minecraft:quartz_block>],
    [<item:storagenetwork:kabel>, <item:industrialforegoing:machine_frame_simple>, <item:storagenetwork:kabel>],
    [<item:minecraft:quartz_block>, <item:storagenetwork:kabel>, <item:minecraft:quartz_block>] ]);

replaceByName("storagenetwork:storage_kabel",<item:storagenetwork:storage_kabel>*4, [
    [air, <item:storagenetwork:kabel>, air],
    [<item:storagenetwork:kabel>, <item:minecraft:ender_pearl>, <item:storagenetwork:kabel>],
    [air, <item:storagenetwork:kabel>, air] ]);

replaceByName("transport:rail_workers_bench",<item:transport:rail_workers_bench>, [
    [air, <tag:items:minecraft:rails>, air],
    [<item:immersiveengineering:light_engineering>, <item:immersiveengineering:light_engineering>, <item:immersiveengineering:light_engineering>] ]);

replaceByName("industrialforegoing:machine_frame_pity",<item:industrialforegoing:machine_frame_pity>, [
    [<tag:items:forge:treated_wood>, <item:minecraft:iron_ingot>, <tag:items:forge:treated_wood>],
    [<item:minecraft:iron_ingot>, <item:immersiveengineering:rs_engineering>, <item:minecraft:iron_ingot>],
    [<tag:items:forge:treated_wood>, <item:minecraft:iron_ingot>, <tag:items:forge:treated_wood>] ]);

replaceJsonByName(<recipetype:industrialforegoing:dissolution_chamber>,"industrialforegoing:dissolution_chamber/simple_machine_frame", {
    input: [
        { tag: "forge:plastic" },
        { item: "industrialforegoing:machine_frame_pity" },
        { tag: "forge:plastic" },
        { item: <item:minecraft:nether_brick>.registryName },
        { item: <item:minecraft:nether_brick>.registryName },
        { tag: "forge:ingots/steel" },
        { item: "titanium:gold_gear" },
        { tag: "forge:ingots/steel" } ],
    inputFluid: "{FluidName:\"industrialforegoing:latex\",Amount:250}",
    processingTime: 300,
    output: {
        item: <item:industrialforegoing:machine_frame_simple>.registryName,
        count:1 }
        // removed this so fluid output matches original recipe in jei instead of stating air
        // , outputFluid: "{FluidName:\"minecraft:empty\",Amount:0}"
        } );

// Chainmail Armor
craftingTable.addShaped("chain_helmet", <item:minecraft:chainmail_helmet>, [
    [<item:immersiveengineering:plate_iron>,<item:immersiveengineering:plate_iron>,<item:immersiveengineering:plate_iron>],
    [<item:minecraft:chain>, air, <item:minecraft:chain>] ]);

craftingTable.addShaped("chain_chest", <item:minecraft:chainmail_chestplate>, [
    [<item:minecraft:chain>, air, <item:minecraft:chain>],
    [<item:immersiveengineering:plate_iron>,<item:immersiveengineering:plate_iron>,<item:immersiveengineering:plate_iron>],
    [<item:minecraft:chain>,<item:minecraft:chain>,<item:minecraft:chain>] ]);

craftingTable.addShaped("chain_legs", <item:minecraft:chainmail_leggings>, [
    [<item:immersiveengineering:plate_iron>,<item:immersiveengineering:plate_iron>,<item:immersiveengineering:plate_iron>],
    [<item:minecraft:chain>,air,<item:minecraft:chain>],
    [<item:minecraft:chain>,air,<item:minecraft:chain>] ]);

craftingTable.addShaped("chain_boots", <item:minecraft:chainmail_boots>, [
    [<item:minecraft:chain>,air,<item:minecraft:chain>],
    [<item:immersiveengineering:plate_iron>,air,<item:immersiveengineering:plate_iron>] ]);

// Bottle Switching
craftingTable.removeRecipe(<item:vanillafoodpantry:empty_bottle>);
craftingTable.addShapeless("vanillafoodpantry_empty_bottle", <item:vanillafoodpantry:empty_bottle>, [<item:minecraft:glass_bottle>]);
craftingTable.addShapeless("minecraft_glass_bottle", <item:minecraft:glass_bottle>, [<item:vanillafoodpantry:empty_bottle>]);

// String Mesh conflicted with Tetra Toolbelt (rope)
craftingTable.removeRecipe(<item:waterstrainer:string_mesh>);
craftingTable.addShaped("string_mesh", <item:waterstrainer:string_mesh>, [
    [<item:minecraft:string>,air,<item:minecraft:string>],
    [air,<item:minecraft:string>,air],
    [<item:minecraft:string>,air,<item:minecraft:string>] ]);

// Charm Woodcutter
craftingTable.removeRecipe(<item:charm:woodcutter>);
craftingTable.addShaped("charm_woodcutter", <item:charm:woodcutter>, [
    [air,<item:immersiveengineering:plate_iron>,air],
    [<item:immersiveengineering:plate_iron>,<tag:items:forge:gears/iron>,<item:immersiveengineering:plate_iron>],
    [<tag:items:minecraft:planks>,<tag:items:minecraft:planks>,<tag:items:minecraft:planks>] ]);

// make red flint as usable as vanilla flint
<tag:items:notreepunching:flint_knappable>.add(<item:vanillafoodpantry:red_flint>);
val stick = <tag:items:forge:rods/wooden>.asIIngredient();
val flint = <tag:items:forge:flint>.asIIngredient();
val plank = <tag:items:minecraft:planks>.asIIngredient();
replaceByName("storagedrawers:one_stack_upgrade",<item:storagedrawers:one_stack_upgrade>,
    [ [stick,stick,stick],[flint,<item:storagedrawers:upgrade_template>,flint],[stick,stick,stick] ] );
replaceByName("minecraft:fletching_table",<item:minecraft:fletching_table>,
    [ [flint,flint],[plank,plank],[plank,plank] ] );

// Big Reactors
removeAndHide(<item:bigreactors:reinforced_reactorpowertapfe_passive>);
removeAndHide(<item:bigreactors:reinforced_reactorpowertapfe_active>);
//<tag:blocks:forge:coils/copper>.add(<block:immersiveengineering:coil_lv>);
//<tag:blocks:forge:coils/electrum>.add(<block:immersiveengineering:coil_mv>);
//<tag:blocks:forge:coils/steel>.add(<block:immersiveengineering:coil_hv>);

// Better End Forge
//<tag:blocks:forge:storage_blocks/aeternium>.add(<block:betterendforge:aeternium_block>);
//<tag:blocks:forge:storage_blocks/amber>.add(<block:betterendforge:amber_block>);
//<tag:blocks:forge:storage_blocks/thallasium>.add(<block:betterendforge:thallasium_block>);
//<tag:blocks:forge:storage_blocks/terminite>.add(<block:betterendforge:terminite_block>);

//Chunk Loaders
craftingTable.removeRecipe(<item:chunkloaders:basic_chunk_loader>);
craftingTable.addShaped("basic_chunk_loader",<item:chunkloaders:basic_chunk_loader>,
[ [<item:immersiveengineering:plate_steel>,<item:minecraft:obsidian>,<item:immersiveengineering:plate_steel>],
  [<item:minecraft:obsidian>,<item:betterendforge:ender_block>,<item:minecraft:obsidian>],
  [<item:immersiveengineering:plate_steel>,<item:minecraft:obsidian>,<item:immersiveengineering:plate_steel>]]);
  craftingTable.addShapeless("single_to_basic_chunkloader",<item:chunkloaders:basic_chunk_loader>,[<item:chunkloaders:single_chunk_loader>*9]);
craftingTable.removeRecipe(<item:chunkloaders:advanced_chunk_loader>);
craftingTable.addShaped("advanced_chunk_loader",<item:chunkloaders:advanced_chunk_loader>,
[ [<item:minecraft:blaze_powder>,<item:minecraft:gold_block>,<item:minecraft:blaze_powder>],
  [<item:minecraft:gold_block>,<item:chunkloaders:basic_chunk_loader>,<item:minecraft:gold_block>],
  [<item:minecraft:blaze_powder>,<item:minecraft:gold_block>,<item:minecraft:blaze_powder>]]);
craftingTable.removeRecipe(<item:chunkloaders:ultimate_chunk_loader>);
craftingTable.addShaped("ultimate_chunk_loader",<item:chunkloaders:ultimate_chunk_loader>,
[ [<item:minecraft:redstone_block>,<item:minecraft:diamond_block>,<item:minecraft:redstone_block>],
  [<item:minecraft:end_crystal>,<item:chunkloaders:advanced_chunk_loader>,<item:minecraft:end_crystal>],
  [<item:minecraft:redstone_block>,<item:minecraft:diamond_block>,<item:minecraft:redstone_block>]]);

//Storage Block Breakdown
craftingTable.addShapeless("enriched_iron_storage_breakdown",<item:refinedstorage:quartz_enriched_iron>*9,[<item:refinedstorage:quartz_enriched_iron_block>]);
craftingTable.addShapeless("biotite_storage_breakdown",<item:quark:biotite>*4,[<item:quark:biotite_block>]);
craftingTable.addShapeless("neterwart_storage_breakdwon",<item:minecraft:nether_wart>*4,[<item:minecraft:nether_wart_block>]);

// flint saw
craftingTable.removeRecipe(<item:natural-progression:basic_saw>);
craftingTable.addShaped("flint_saw",<item:natural-progression:basic_saw>,
    [ [stick,stick,stick],[<item:notreepunching:flint_shard>,<item:notreepunching:flint_shard>,<item:notreepunching:flint_shard>]]);

// mob imprisonment tool
craftingTable.removeRecipe(<item:industrialforegoing:mob_imprisonment_tool>);
craftingTable.addShaped("mob_imprisonment_tool",<item:industrialforegoing:mob_imprisonment_tool>,
 [[air,<item:industrialforegoing:plastic>,air],
 [<item:industrialforegoing:plastic>,<item:betterportals:portal_fluid_bucket>,<item:industrialforegoing:plastic>],
 [air,<item:industrialforegoing:plastic>,air]]);

println("END misc.zs");
