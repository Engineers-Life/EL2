import crafttweaker.api.item.IIngredient;
import crafttweaker.api.BracketHandlers;

println("BEGIN misc.zs");

var air = <item:minecraft:air>;
var cobblestone = <item:minecraft:cobblestone>;
val stick = <tag:items:forge:rods/wooden>.asIIngredient();
val flint = <tag:items:forge:flint>.asIIngredient();
val plank = <tag:items:minecraft:planks>.asIIngredient();
val nugget = <tag:items:forge:nuggets>.asIIngredient();

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
craftingTable.removeRecipe(<item:productivebees:powered_centrifuge>);
craftingTable.addShaped("productivebees.powered_centrifuge",<item:productivebees:powered_centrifuge>, [
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
replaceByName("storagedrawers:one_stack_upgrade",<item:storagedrawers:one_stack_upgrade>,
    [ [stick,stick,stick],[flint,<item:storagedrawers:upgrade_template>,flint],[stick,stick,stick] ] );
replaceByName("minecraft:fletching_table",<item:minecraft:fletching_table>,
    [ [flint,flint],[plank,plank],[plank,plank] ] );

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
//craftingTable.addShapeless("neterwart_storage_breakdwon",<item:minecraft:nether_wart>*4,[<item:minecraft:nether_wart_block>]);

// saws
removeAndHide(<item:natural-progression:bronze_saw>);
removeAndHide(<item:notreepunching:iron_saw>);
removeAndHide(<item:notreepunching:gold_saw>);
removeAndHide(<item:notreepunching:diamond_saw>);
removeAndHide(<item:notreepunching:netherite_saw>);
replaceByName("immersiveengineering:crafting/wooden_grip", <item:immersiveengineering:wooden_grip>, [
    [stick,stick],
    [nugget,stick],
    [stick,stick] ]);
for name,material in {
        "basic_saw"    : <item:notreepunching:flint_shard>,
        "improved_saw" : <tag:items:forge:ingots/iron>,
        "golden_saw"   : <tag:items:forge:ingots/gold>,
        "diamond_saw"  : <tag:items:forge:gems/diamond>,
        "copper_saw"   : <tag:items:forge:ingots/copper>,
        "steel_saw"    : <tag:items:forge:ingots/steel> } {
    replaceByName("natural-progression:crafting/saws/"+name, BracketHandlers.getItem("natural-progression:"+name), [
            [stick,air,air],
            [material,stick,air],
            [air,material,<item:immersiveengineering:wooden_grip>]]);
}

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
craftingTable.addShaped("red_crystal_pb",c_red*3,[[cp_red,cp_red,cp_red],[cp_red,air,cp_red],[cp_red,cp_red,cp_red]]);
craftingTable.addShaped("orange_crystal_pb",c_orange*3,[[cp_orange,cp_orange,cp_orange],[cp_orange,air,cp_orange],[cp_orange,cp_orange,cp_orange]]);
craftingTable.addShaped("yellow_crystal_pb",c_yellow*3,[[cp_yellow,cp_yellow,cp_yellow],[cp_yellow,air,cp_yellow],[cp_yellow,cp_yellow,cp_yellow]]);
craftingTable.addShaped("green_crystal_pb",c_green*3,[[cp_green,cp_green,cp_green],[cp_green,air,cp_green],[cp_green,cp_green,cp_green]]);
craftingTable.addShaped("blue_crystal_pb",c_blue*3,[[cp_blue,cp_blue,cp_blue],[cp_blue,air,cp_blue],[cp_blue,cp_blue,cp_blue]]);
craftingTable.addShaped("indigo_crystal_pb",c_indigo*3,[[cp_indigo,cp_indigo,cp_indigo],[cp_indigo,air,cp_indigo],[cp_indigo,cp_indigo,cp_indigo]]);
craftingTable.addShaped("violet_crystal_pb",c_violet*3,[[cp_violet,cp_violet,cp_violet],[cp_violet,air,cp_violet],[cp_violet,cp_violet,cp_violet]]);
craftingTable.addShaped("white_crystal_pb",c_white*3,[[cp_white,cp_white,cp_white],[cp_white,air,cp_white],[cp_white,cp_white,cp_white]]);
craftingTable.addShaped("black_crystal_pb",c_black*3,[[cp_black,cp_black,cp_black],[cp_black,air,cp_black],[cp_black,cp_black,cp_black]]);

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

// Prevent free buckets from cooking for blockheads kitchen
craftingTable.removeByName("vanillafoodpantry:waterdrinks/bucket_potable_water_simple");

moveTagsFromTo(<item:minecraft:rotten_flesh>,<item:betterdefaultbiomes:frozen_flesh>);
changeIngredientsToTag([<item:minecraft:rotten_flesh>],<tag:items:forge:rotten_flesh>);

<tag:blocks:forge:relocation_not_supported>.add(<block:cookingforblockheads:cutting_board>);

println("END misc.zs");
