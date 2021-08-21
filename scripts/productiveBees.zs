import crafttweaker.api.item.IItemStack;
 
var replacement_item = <item:minecraft:stick> as IItemStack;
 
val wooden_sword_nests = {
    <item:productivebees:snow_nest>         : <item:minecraft:snow_block>,
    <item:productivebees:coarse_dirt_nest>  : <item:minecraft:coarse_dirt>,
    <item:productivebees:jungle_wood_nest>  : <item:minecraft:jungle_log>,
    <item:productivebees:dark_oak_wood_nest>: <item:minecraft:dark_oak_log>,
    <item:productivebees:oak_wood_nest>     : <item:minecraft:oak_log>,
    <item:productivebees:sand_nest>         : <item:minecraft:sand>,
    <item:productivebees:soul_sand_nest>    : <item:minecraft:soul_sand>,
    <item:productivebees:acacia_wood_nest>  : <item:minecraft:acacia_log>,
    <item:productivebees:birch_wood_nest>   : <item:minecraft:birch_log>,
    <item:productivebees:gravel_nest>       : <item:minecraft:gravel>,
    <item:productivebees:sugar_cane_nest>   : <item:minecraft:sugar_cane>,
    <item:productivebees:spruce_wood_nest>  : <item:minecraft:spruce_log>,
    <item:productivebees:glowstone_nest>    : <item:minecraft:glowstone>,
    <item:productivebees:bumble_bee_nest>   : <item:minecraft:grass_block>
} as IItemStack[IItemStack];
 
for nest, block in wooden_sword_nests {
    craftingTable.removeRecipe(nest);
    craftingTable.addShapeless("shapeless_"+nest.translationKey,nest,[replacement_item,block]);
    craftingTable.addShapeless("clear_"+nest.translationKey,nest,[nest]);
}
