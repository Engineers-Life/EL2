
import crafttweaker.api.BracketHandlers;
import crafttweaker.api.item.IIngredient;
import crafttweaker.api.item.IItemStack;

println("BEGIN chests.zs");

craftingTable.addShapeless("basic_chest",<item:minecraft:chest>,[<tag:items:forge:chests/wooden>]);

val air = <item:minecraft:air>;

// this doesn't work.  wooden_chest will include both trapped and non-trapped chests
val wooden_chest = <tag:items:forge:chests/wooden>
        .asIIngredient()
        .onlyIf("wooden_chests_omiting_trapped_chests",
                (stack as IItemStack) => { return (<tag:items:forge:chests/trapped>.contains(stack));} );

// simple chests
for output, plank in {
        <item:quark:oak_chest>      : <item:minecraft:oak_planks>,
        <item:quark:spruce_chest>   : <item:minecraft:spruce_planks>,
        <item:quark:birch_chest>    : <item:minecraft:birch_planks>,
        <item:quark:jungle_chest>   : <item:minecraft:jungle_planks>,
        <item:quark:acacia_chest>   : <item:minecraft:acacia_planks>,
        <item:quark:dark_oak_chest> : <item:minecraft:dark_oak_planks>,
        <item:quark:crimson_chest>  : <item:minecraft:crimson_planks>,
        <item:quark:warped_chest>   : <item:minecraft:warped_planks>,
        <item:quark:nether_brick_chest> : <item:minecraft:nether_brick>,
        <item:quark:purpur_chest>       : <item:minecraft:popped_chorus_fruit>,
        <item:quark:prismarine_chest>   : <item:minecraft:prismarine_shard>,
        <item:quark:mushroom_chest>     : <tag:items:forge:mushrooms>.asIIngredient(),
        <item:terraincognita:apple_chest>   : <item:terraincognita:apple_planks>,
        <item:terraincognita:hazel_chest>   : <item:terraincognita:hazel_planks>,
        <item:betterendforge:mossy_glowshroom_chest>    : <item:betterendforge:mossy_glowshroom_planks>,
        <item:betterendforge:lacugrove_chest>    : <item:betterendforge:lacugrove_planks>,
        <item:betterendforge:end_lotus_chest>    : <item:betterendforge:end_lotus_planks>,
        <item:betterendforge:pythadendron_chest>    : <item:betterendforge:pythadendron_planks>,
        <item:betterendforge:dragon_tree_chest>    : <item:betterendforge:dragon_tree_planks>,
        <item:betterendforge:tenanea_chest>    : <item:betterendforge:tenanea_planks>,
        <item:betterendforge:helix_tree_chest>    : <item:betterendforge:helix_tree_planks>,
        <item:betterendforge:umbrella_tree_chest>    : <item:betterendforge:umbrella_tree_planks>,
        <item:betterendforge:jellyshroom_chest>    : <item:betterendforge:jellyshroom_planks> } as IIngredient[IItemStack] {
    craftingTable.addShaped(validName(output.registryName)+".double",output*2,[[plank,plank,plank],[plank,wooden_chest,plank],[plank,plank,plank]]);
}

// fancy chests
for name, slab in {
        "embellishcraft:oak_fancy_chest"      : <item:minecraft:oak_slab>,
        "embellishcraft:spruce_fancy_chest"   : <item:minecraft:spruce_slab>,
        "embellishcraft:birch_fancy_chest"    : <item:minecraft:birch_slab>,
        "embellishcraft:jungle_fancy_chest"   : <item:minecraft:jungle_slab>,
        "embellishcraft:acacia_fancy_chest"   : <item:minecraft:acacia_slab>,
        "embellishcraft:dark_oak_fancy_chest" : <item:minecraft:dark_oak_slab>,
        "embellishcraft:crimson_fancy_chest"  : <item:minecraft:crimson_slab>,
        "embellishcraft:warped_fancy_chest"   : <item:minecraft:warped_slab> } as IItemStack[string] {
    replaceByName(name,BracketHandlers.getItem(name),[[air,slab,air],[slab,wooden_chest,slab],[air,slab,air]]);
}

// trapped chests
for output, input in {
        <item:quark:oak_trapped_chest>      : <item:quark:oak_chest>,
        <item:quark:spruce_trapped_chest>   : <item:quark:spruce_chest>,
        <item:quark:birch_trapped_chest>    : <item:quark:birch_chest>,
        <item:quark:jungle_trapped_chest>   : <item:quark:jungle_chest>,
        <item:quark:acacia_trapped_chest>   : <item:quark:acacia_chest>,
        <item:quark:dark_oak_trapped_chest> : <item:quark:dark_oak_chest>,
        <item:quark:crimson_trapped_chest>  : <item:quark:crimson_chest>,
        <item:quark:warped_trapped_chest>   : <item:quark:warped_chest>,
        <item:quark:nether_brick_trapped_chest> : <item:quark:nether_brick_chest>,
        <item:quark:purpur_trapped_chest>       : <item:quark:purpur_chest>,
        <item:quark:prismarine_trapped_chest>   : <item:quark:prismarine_chest>,
        <item:quark:mushroom_trapped_chest>     : <item:quark:mushroom_chest>,
        <item:terraincognita:apple_trapped_chest>   : <item:terraincognita:apple_chest>,
        <item:terraincognita:hazel_trapped_chest>   : <item:terraincognita:hazel_chest> } as IItemStack[IItemStack] {
    craftingTable.addShapeless(validName(output.registryName),output,[input,<item:minecraft:tripwire_hook>]);
}

println("END chests.zs");
