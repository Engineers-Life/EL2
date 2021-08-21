
import crafttweaker.api.BracketHandlers;
import crafttweaker.api.item.IIngredient;
import crafttweaker.api.item.IItemStack;

println("BEGIN chests.zs");

craftingTable.addShapeless("basic_chest",<item:minecraft:chest>,[<tag:items:forge:chests/wooden>]);

val air = <item:minecraft:air>;

// this doesn't work.  wooden_chest will include both trapped and non-trapped chests
val wooden_chest = <tag:items:forge:chests/wooden>.asIIngredient();

val trapped_chests = {
        <item:minecraft:chest>            : <item:minecraft:trapped_chest>,
        <item:quark:oak_chest>            : <item:quark:oak_trapped_chest>,
        <item:quark:spruce_chest>         : <item:quark:spruce_trapped_chest>,
        <item:quark:birch_chest>          : <item:quark:birch_trapped_chest>,
        <item:quark:jungle_chest>         : <item:quark:jungle_trapped_chest>,
        <item:quark:acacia_chest>         : <item:quark:acacia_trapped_chest>,
        <item:quark:dark_oak_chest>       : <item:quark:dark_oak_trapped_chest>,
        <item:quark:crimson_chest>        : <item:quark:crimson_trapped_chest>,
        <item:quark:warped_chest>         : <item:quark:warped_trapped_chest>,
        <item:quark:nether_brick_chest>   : <item:quark:nether_brick_trapped_chest>,
        <item:quark:purpur_chest>         : <item:quark:purpur_trapped_chest>,
        <item:quark:prismarine_chest>     : <item:quark:prismarine_trapped_chest>,
        <item:quark:mushroom_chest>       : <item:quark:mushroom_trapped_chest>,
        <item:terraincognita:apple_chest> : <item:terraincognita:apple_trapped_chest>,
        <item:terraincognita:hazel_chest> : <item:terraincognita:hazel_trapped_chest>,

        } as IItemStack[IItemStack];

var itsATrap as function(usualOut as IItemStack, inputs as IItemStack[][]) as IItemStack = (usualOut, inputs) => {
    println(usualOut.commandString);
    println((usualOut*1).commandString);
    return ( (inputs[1][1] in <tag:items:forge:chests/trapped>) && ((usualOut*1) in trapped_chests) ) ? (trapped_chests[usualOut*1] * usualOut.amount) : usualOut;
};

// simple chests
for output, plank in {
        <item:quark:oak_chest>          : <item:minecraft:oak_planks> as IIngredient,
        <item:quark:spruce_chest>       : <item:minecraft:spruce_planks> as IIngredient,
        <item:quark:birch_chest>        : <item:minecraft:birch_planks> as IIngredient,
        <item:quark:jungle_chest>       : <item:minecraft:jungle_planks> as IIngredient,
        <item:quark:acacia_chest>       : <item:minecraft:acacia_planks> as IIngredient,
        <item:quark:dark_oak_chest>     : <item:minecraft:dark_oak_planks> as IIngredient,
        <item:quark:crimson_chest>      : <item:minecraft:crimson_planks> as IIngredient,
        <item:quark:warped_chest>       : <item:minecraft:warped_planks> as IIngredient,
        <item:quark:nether_brick_chest> : <item:minecraft:nether_brick> as IIngredient,
        <item:quark:purpur_chest>       : <item:minecraft:popped_chorus_fruit> as IIngredient,
        <item:quark:prismarine_chest>   : <item:minecraft:prismarine_shard> as IIngredient,
        <item:quark:mushroom_chest>     : <tag:items:forge:mushrooms>.asIIngredient() as IIngredient,
        <item:terraincognita:apple_chest> : <item:terraincognita:apple_planks> as IIngredient,
        <item:terraincognita:hazel_chest> : <item:terraincognita:hazel_planks> as IIngredient,
        <item:betterendforge:mossy_glowshroom_chest> : <item:betterendforge:mossy_glowshroom_planks> as IIngredient,
        <item:betterendforge:lacugrove_chest>        : <item:betterendforge:lacugrove_planks> as IIngredient,
        <item:betterendforge:end_lotus_chest>        : <item:betterendforge:end_lotus_planks> as IIngredient,
        <item:betterendforge:pythadendron_chest>     : <item:betterendforge:pythadendron_planks> as IIngredient,
        <item:betterendforge:dragon_tree_chest>      : <item:betterendforge:dragon_tree_planks> as IIngredient,
        <item:betterendforge:tenanea_chest>          : <item:betterendforge:tenanea_planks> as IIngredient,
        <item:betterendforge:helix_tree_chest>       : <item:betterendforge:helix_tree_planks> as IIngredient,
        <item:betterendforge:umbrella_tree_chest>    : <item:betterendforge:umbrella_tree_planks> as IIngredient,
        <item:betterendforge:jellyshroom_chest>      : <item:betterendforge:jellyshroom_planks> as IIngredient } as IIngredient[IItemStack] {
    craftingTable.addShaped(validName(output.registryName)+".double",output*2,[[plank,plank,plank],[plank,wooden_chest,plank],[plank,plank,plank]],itsATrap);
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
for input, output in trapped_chests {
    craftingTable.addShapeless(validName(output.registryName),output,[input,<item:minecraft:tripwire_hook>]);
}

println("END chests.zs");
