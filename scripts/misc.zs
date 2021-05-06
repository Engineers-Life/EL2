import crafttweaker.api.item.IIngredient;

println("BEGIN misc.zs");

var air = <item:minecraft:air>;
var cobblestone = <item:minecraft:cobblestone>;

// Construction Wands
removeAndHide(<item:constructionwand:infinity_wand>);
removeAndHide(<item:constructionwand:core_angel>);
removeAndHide(<item:constructionwand:core_destruction>);

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

replaceJsonByName(<recipetype:industrialforegoing:dissolution_chamber>,"industrialforegoing:dissolution_chamber/xp_bottles", {
    input: [ { tag: "forge:empty_bottles" } ],
    inputFluid: "{FluidName:\"industrialforegoing:essence\",Amount:250}",
    processingTime: 300,
    output: {
        item: <item:minecraft:experience_bottle>.registryName,
        count:1 } } );

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

//dragon egg recipe for servers
craftingTable.addShapeless("inactive_dragon_egg_from_dragon_head",<item:productivebees:inactive_dragon_egg>,[<item:minecraft:dragon_head>]);

//Remove second green dye
removeAndHide(<item:pitg:green_dye>);

//Quark Crystal and Rune Crafting
//crystal clusters
var cc_red = <item:quark:red_crystal_cluster>;
var cc_orange = <item:quark:orange_crystal_cluster>;
var cc_yellow = <item:quark:yellow_crystal_cluster>;
var cc_green = <item:quark:green_crystal_cluster>;
var cc_blue = <item:quark:blue_crystal_cluster>;
var cc_indigo = <item:quark:indigo_crystal_cluster>;
var cc_violet = <item:quark:violet_crystal_cluster>;
var cc_white = <item:quark:white_crystal_cluster>;
var cc_black = <item:quark:black_crystal_cluster>;
//crystal block
var c_red = <item:quark:red_crystal>;
var c_orange = <item:quark:orange_crystal>;
var c_yellow = <item:quark:yellow_crystal>;
var c_green = <item:quark:green_crystal>;
var c_blue = <item:quark:blue_crystal>;
var c_indigo = <item:quark:indigo_crystal>;
var c_violet = <item:quark:violet_crystal>;
var c_white = <item:quark:white_crystal>;
var c_black = <item:quark:black_crystal>;
//crystal panes
var cp_red = <item:quark:red_crystal_pane>;
var cp_orange = <item:quark:orange_crystal_pane>;
var cp_yellow = <item:quark:yellow_crystal_pane>;
var cp_green = <item:quark:green_crystal_pane>;
var cp_blue = <item:quark:blue_crystal_pane>;
var cp_indigo = <item:quark:indigo_crystal_pane>;
var cp_violet = <item:quark:violet_crystal_pane>;
var cp_white = <item:quark:white_crystal_pane>;
var cp_black = <item:quark:black_crystal_pane>;

//clusters to blocks
craftingTable.addShaped("red_crystal",c_red,[[cc_red,cc_red],[cc_red,cc_red]]);
craftingTable.addShaped("orange_crystal",c_orange,[[cc_orange,cc_orange],[cc_orange,cc_orange]]);
craftingTable.addShaped("yellow_crystal",c_yellow,[[cc_yellow,cc_yellow],[cc_yellow,cc_yellow]]);
craftingTable.addShaped("green_crystal",c_green,[[cc_green,cc_green],[cc_green,cc_green]]);
craftingTable.addShaped("blue_crystal",c_blue,[[cc_blue,cc_blue],[cc_blue,cc_blue]]);
craftingTable.addShaped("indigo_crystal",c_indigo,[[cc_indigo,cc_indigo],[cc_indigo,cc_indigo]]);
craftingTable.addShaped("violet_crystal",c_violet,[[cc_violet,cc_violet],[cc_violet,cc_violet]]);
craftingTable.addShaped("white_crystal",c_white,[[cc_white,cc_white],[cc_white,cc_white]]);
craftingTable.addShaped("black_crystal",c_black,[[cc_black,cc_black],[cc_black,cc_black]]);

//blocks to panes
craftingTable.addShaped("red_crystal_pane",cp_red*16,[[c_red,c_red,c_red],[c_red,c_red,c_red]]);
craftingTable.addShaped("orange_crystal_pane",cp_orange*16,[[c_orange,c_orange,c_orange],[c_orange,c_orange,c_orange]]);
craftingTable.addShaped("yellow_crystal_pane",cp_yellow*16,[[c_yellow,c_yellow,c_yellow],[c_yellow,c_yellow,c_yellow]]);
craftingTable.addShaped("green_crystal_pane",cp_green*16,[[c_green,c_green,c_green],[c_green,c_green,c_green]]);
craftingTable.addShaped("blue_crystal_pane",cp_blue*16,[[c_blue,c_blue,c_blue],[c_blue,c_blue,c_blue]]);
craftingTable.addShaped("indigo_crystal_pane",cp_indigo*16,[[c_indigo,c_indigo,c_indigo],[c_indigo,c_indigo,c_indigo]]);
craftingTable.addShaped("violet_crystal_pane",cp_violet*16,[[c_violet,c_violet,c_violet],[c_violet,c_violet,c_violet]]);
craftingTable.addShaped("white_crystal_pane",cp_white*16,[[c_white,c_white,c_white],[c_white,c_white,c_white]]);
craftingTable.addShaped("black_crystal_pane",cp_black*16,[[c_black,c_black,c_black],[c_black,c_black,c_black]]);

//panes to blocks
craftingTable.addShaped("red_crystal_pane",c_red*3,[[c_red,c_red,c_red],[c_red,air,c_red],[c_red,c_red,c_red]]);
craftingTable.addShaped("orange_crystal_pane",c_orange*3,[[c_orange,c_orange,c_orange],[c_orange,air,c_orange],[c_orange,c_orange,c_orange]]);
craftingTable.addShaped("yellow_crystal_pane",c_yellow*3,[[c_yellow,c_yellow,c_yellow],[c_yellow,air,c_yellow],[c_yellow,c_yellow,c_yellow]]);
craftingTable.addShaped("green_crystal_pane",c_green*3,[[c_green,c_green,c_green],[c_green,air,c_green],[c_green,c_green,c_green]]);
craftingTable.addShaped("blue_crystal_pane",c_blue*3,[[c_blue,c_blue,c_blue],[c_blue,air,c_blue],[c_blue,c_blue,c_blue]]);
craftingTable.addShaped("indigo_crystal_pane",c_indigo*3,[[c_indigo,c_indigo,c_indigo],[c_indigo,air,c_indigo],[c_indigo,c_indigo,c_indigo]]);
craftingTable.addShaped("violet_crystal_pane",c_violet*3,[[c_violet,c_violet,c_violet],[c_violet,air,c_violet],[c_violet,c_violet,c_violet]]);
craftingTable.addShaped("white_crystal_pane",c_white*3,[[c_white,c_white,c_white],[c_white,air,c_white],[c_white,c_white,c_white]]);
craftingTable.addShaped("black_crystal_pane",c_black*3,[[c_black,c_black,c_black],[c_black,air,c_black],[c_black,c_black,c_black]]);

//Runes
var stone = <tag:items:forge:stone>;
craftingTable.addShaped("white_rune",<item:quark:white_rune>,[[c_white,c_white,c_white],[c_white,stone,c_white],[c_white,c_white,c_white]]);
craftingTable.addShaped("orange_rune",<item:quark:orange_rune>,[[c_orange,c_orange,c_orange],[c_orange,stone,c_orange],[c_orange,c_orange,c_orange]]);
craftingTable.addShaped("magenta_rune",<item:quark:magenta_rune>,[[c_violet,c_violet,c_violet],[c_violet,stone,c_violet],[c_violet,c_violet,c_violet]]);
craftingTable.addShaped("light_blue_rune",<item:quark:light_blue_rune>,[[c_blue,c_white,c_blue],[c_white,stone,c_white],[c_blue,c_white,c_blue]]);
craftingTable.addShaped("yellow_rune",<item:quark:yellow_rune>,[[c_yellow,c_yellow,c_yellow],[c_yellow,stone,c_yellow],[c_yellow,c_yellow,c_yellow]]);
craftingTable.addShaped("lime_rune",<item:quark:lime_rune>,[[c_green,c_yellow,c_green],[c_yellow,stone,c_yellow],[c_green,c_yellow,c_green]]);
craftingTable.addShaped("pink_rune",<item:quark:pink_rune>,[[c_violet,c_white,c_violet],[c_white,stone,c_white],[c_violet,c_white,c_violet]]);
craftingTable.addShaped("gray_rune",<item:quark:gray_rune>,[[c_black,c_white,c_black],[c_black,stone,c_black],[c_black,c_white,c_black]]);
craftingTable.addShaped("light_gray_rune",<item:quark:light_gray_rune>,[[c_black,c_white,c_black],[c_white,stone,c_white],[c_black,c_white,c_black]]);
craftingTable.addShaped("cyan_rune",<item:quark:cyan_rune>,[[c_blue,c_green,c_blue],[c_green,stone,c_green],[c_blue,c_green,c_blue]]);
craftingTable.addShaped("purple_rune",<item:quark:purple_rune>,[[c_indigo,c_indigo,c_indigo],[c_indigo,stone,c_indigo],[c_indigo,c_indigo,c_indigo]]);
craftingTable.addShaped("blue_rune",<item:quark:blue_rune>,[[c_blue,c_blue,c_blue],[c_blue,stone,c_blue],[c_blue,c_blue,c_blue]]);
craftingTable.addShaped("brown_rune",<item:quark:brown_rune>,[[c_blue,c_orange,c_blue],[c_orange,stone,c_orange],[c_blue,c_orange,c_blue]]);
craftingTable.addShaped("green_rune",<item:quark:green_rune>,[[c_green,c_green,c_green],[c_green,stone,c_green],[c_green,c_green,c_green]]);
craftingTable.addShaped("red_rune",<item:quark:red_rune>,[[c_red,c_red,c_red],[c_red,stone,c_red],[c_red,c_red,c_red]]);
craftingTable.addShaped("black_rune",<item:quark:black_rune>,[[c_black,c_black,c_black],[c_black,stone,c_black],[c_black,c_black,c_black]]);

println("END misc.zs");
