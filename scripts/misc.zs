
println("BEGIN misc.zs");

var air = <item:minecraft:air>;

removeAndHide(<item:productivebees:centrifuge>);

replaceByName("productivebees:powered_centrifuge/vanilla",<item:productivebees:powered_centrifuge>, [
    [<item:minecraft:iron_ingot>, <item:minecraft:iron_ingot>, <item:minecraft:iron_ingot>],
    [<item:minecraft:piston>, <item:minecraft:grindstone>, <item:minecraft:piston>],
    [<item:minecraft:redstone>, <item:minecraft:iron_ingot>, <item:minecraft:redstone>] ]);

replaceByName("productivebees:hives/advanced_oak_beehive",<item:productivebees:advanced_oak_beehive>, [
    [<item:minecraft:oak_planks>, <item:minecraft:oak_planks>, <item:minecraft:oak_planks>],
    [<item:minecraft:honeycomb>, <item:minecraft:beehive>, <item:minecraft:honeycomb>],
    [<item:minecraft:soul_campfire>, <item:minecraft:oak_planks>, <item:minecraft:shears>] ]);

//craftingTable.removeRecipe(<item:farmersdelight:stove>);
//craftingTable.addShaped("stove", <item:farmersdelight:stove>, [
//[<item:minecraft:iron_ingot>, <item:minecraft:iron_ingot>, <item:minecraft:iron_ingot>], 
//[<item:minecraft:bricks>, air, <item:minecraft:bricks>], 
//[<item:minecraft:bricks>, <item:minecraft:furnace>, <item:minecraft:bricks>]], null);

replaceByName("storagenetwork:master",<item:storagenetwork:master>, [
    [<item:minecraft:quartz_block>, <item:storagenetwork:kabel>, <item:minecraft:quartz_block>],
    [<item:storagenetwork:kabel>, <item:minecraft:nether_star>, <item:storagenetwork:kabel>],
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
craftingTable.addShapeless("vanillafoodpantry:empty_bottle", <item:vanillafoodpantry:empty_bottle>, [<item:minecraft:glass_bottle>]);
craftingTable.addShapeless("minecraft:glass_bottle", <item:minecraft:glass_bottle>, [<item:vanillafoodpantry:empty_bottle>]);

// String Mesh conflicted with Tetra Toolbelt (rope)
craftingTable.removeRecipe(<item:waterstrainer:string_mesh>);
craftingTable.addShaped("string_mesh", <item:waterstrainer:string_mesh>, [
    [<item:minecraft:string>,air,<item:minecraft:string>],
    [air,<item:minecraft:string>,air],
    [<item:minecraft:string>,air,<item:minecraft:string>] ]);

// Charm Woodcutter
craftingTable.removeRecipe(<item:charm:woodcutter>);
craftingTable.addShaped("charm:woodcutter", <item:charm:woodcutter>, [
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
<tag:blocks:forge:coils/copper>.add(<block:immersiveengineering:coil_lv>);
<tag:blocks:forge:coils/electrum>.add(<block:immersiveengineering:coil_mv>);
<tag:blocks:forge:coils/steel>.add(<block:immersiveengineering:coil_hv>);

// Better End Forge
<tag:blocks:forge:storage_blocks/aeternium>.add(<block:betterendforge:aeternium_block>);
<tag:blocks:forge:storage_blocks/amber>.add(<block:betterendforge:amber_block>);
<tag:blocks:forge:storage_blocks/thallasium>.add(<block:betterendforge:thallasium_block>);
<tag:blocks:forge:storage_blocks/terminite>.add(<block:betterendforge:terminite_block>);

println("END misc.zs");
