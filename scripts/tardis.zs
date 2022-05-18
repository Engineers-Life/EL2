import crafttweaker.api.item.IItemStack;
import crafttweaker.api.data.ICollectionData;
import mods.jei.JEI;

val quantiscope = <recipetype:tardis:quantiscope>;

function addQuantiscopeRecipe(recipeName as string, product as IItemStack, ingredients as ICollectionData) as void {
    <recipetype:tardis:quantiscope>.addJSONRecipe(recipeName, {
        "repair": false,
        "ingredients": ingredients,
        "result": product
    });
}

function addQuantiscopeRepairRecipe(recipeName as string, product as IItemStack, ingredients as ICollectionData) as void {
    <recipetype:tardis:quantiscope>.addJSONRecipe(recipeName, {
        "repair": true,
        "ingredients": ingredients,
        "result": product
    });
}

// Exotronic Circuit
<recipetype:tardis:alembic>.removeRecipe(<item:tardis:circuit_paste>);
JEI.hideIngredient(<item:tardis:circuit_paste>);
quantiscope.removeByName("tardis:quantiscope/circuits");
craftingTable.removeRecipe(<item:tardis:circuits>);
craftingTable.addShaped("tardis/circuits", <item:tardis:circuits>, [
    [<item:minecraft:air>, <item:tardis:xion_crystal>, <item:minecraft:air>],
    [<item:immersiveengineering:electron_tube>, <tag:items:forge:wires/copper>, <item:immersiveengineering:electron_tube>],
    [<item:immersiveengineering:circuit_board>, <item:immersiveengineering:circuit_board>, <item:immersiveengineering:circuit_board>]
]);
addQuantiscopeRecipe("tardis/quantiscope/circuits", <item:tardis:circuits>, [
    <item:immersiveengineering:circuit_board>,
    <tag:items:forge:wires/copper>,
    <item:immersiveengineering:electron_tube>,
    <item:tardis:xion_crystal>,
]);

// Blank Upgrade
craftingTable.removeRecipe(<item:tardis:blank_upgrade>);
craftingTable.addShaped("tardis/blank_upgrade", <item:tardis:blank_upgrade>, [
    [<item:immersiveengineering:circuit_board>, <item:minecraft:gold_nugget>],
    [<item:immersiveengineering:electron_tube>, <item:minecraft:gold_nugget>],
    [<item:immersiveengineering:circuit_board>, <item:minecraft:gold_nugget>]
]);

// Alembic
craftingTable.removeRecipe(<item:tardis:alembic>);
craftingTable.addShaped("tardis/alembic", <item:tardis:alembic>, [
    [<item:immersiveengineering:metal_barrel>, <item:immersiveengineering:plate_copper>, <item:minecraft:air>],
    [<item:minecraft:furnace>, <item:immersiveengineering:fluid_pipe>, <item:immersiveengineering:metal_barrel>]
]);

// Quantiscope Iron
craftingTable.removeRecipe(<item:tardis:quantiscope_iron>);
craftingTable.addShapeless("tardis/quantiscope_iron_from_brass", <item:tardis:quantiscope_iron>, [<item:tardis:quantiscope_brass>, <tag:items:forge:dyes/white>]);
craftingTable.addShaped("tardis/quantiscope_iron", <item:tardis:quantiscope_iron>, [
    [<item:minecraft:air>, <item:cavesandcliffs:amethyst_shard>, <item:minecraft:air>],
    [<item:immersiveengineering:logic_unit>, <item:immersiveengineering:component_steel>, <item:tardis:circuits>],
    [<item:immersiveengineering:slab_sheetmetal_iron>, <item:immersiveengineering:slab_sheetmetal_iron>, <item:immersiveengineering:slab_sheetmetal_iron>]
]);

// Quantiscope Brass
craftingTable.removeRecipe(<item:tardis:quantiscope_brass>);
craftingTable.addShapeless("tardis/quantiscope_brass_from_iron", <item:tardis:quantiscope_brass>, [<item:tardis:quantiscope_iron>, <tag:items:forge:dyes/orange>]);
craftingTable.addShaped("tardis/quantiscope_brass", <item:tardis:quantiscope_brass>, [
    [<item:minecraft:air>, <item:cavesandcliffs:amethyst_shard>, <item:minecraft:air>],
    [<item:immersiveengineering:logic_unit>, <item:immersiveengineering:component_steel>, <item:tardis:circuits>],
    [<item:immersiveengineering:slab_sheetmetal_copper>, <item:immersiveengineering:slab_sheetmetal_copper>, <item:immersiveengineering:slab_sheetmetal_copper>]
]);

// Dematerialisation Circuit
quantiscope.removeByName("tardis:quantiscope/subsystem/demat");
addQuantiscopeRecipe("tardis/quantiscope/subsystem/demat", <item:tardis:subsystem/dematerialisation_circuit>, [
    <item:tardis:circuits>,
    <item:immersiveengineering:heavy_engineering>,
    <item:minecraft:ender_pearl>,
]);

// Fluid Link
quantiscope.removeByName("tardis:quantiscope/subsystem/fluid_link");
addQuantiscopeRecipe("tardis/quantiscope/subsystem/fluid_link", <item:tardis:subsystem/fluid_link>, [
    <item:tardis:circuits>,
    <item:immersiveengineering:fluid_pipe>,
    <item:tardis:mercury_bottle>,
]);

// Artron Capacitor
quantiscope.removeByName("tardis:quantiscope/artron_capacitor");
addQuantiscopeRecipe("tardis/quantiscope/artron_capacitor", <item:tardis:artron_capacitor>, [
    <item:tardis:mercury_bottle>,
    <item:tardis:circuits>,
    <item:immersiveengineering:capacitor_mv>,
    <item:tardis:mercury_bottle>,
    <tag:items:forge:ingots/electrum>,
]);
addQuantiscopeRecipe("tardis/quantiscope/artron_capacitor_repair", <item:tardis:artron_capacitor>, [
    <item:tardis:leaky_capacitor>,
    <item:tardis:mercury_bottle>,
    <tag:items:forge:nuggets/electrum>,
]);

// Artron Capacitor (Medium)
quantiscope.removeByName("tardis:quantiscope/artron_capacitor_mid");
addQuantiscopeRecipe("tardis/quantiscope/artron_capacitor_mid", <item:tardis:artron_capacitor_mid>, [
    <item:tardis:mercury_bottle>,
    <item:immersiveengineering:capacitor_mv>,
    <item:tardis:artron_capacitor>,
    <tag:items:forge:ingots/electrum>,
    <tag:items:forge:ingots/electrum>,
]);

// Artron Capacitor (High)
quantiscope.removeByName("tardis:quantiscope/artron_capacitor_high");
addQuantiscopeRecipe("tardis/quantiscope/artron_capacitor_high", <item:tardis:artron_capacitor_high>, [
    <item:tardis:mercury_bottle>,
    <item:immersiveengineering:capacitor_hv>,
    <item:tardis:artron_capacitor_mid>,
    <tag:items:forge:ingots/steel>,
    <tag:items:forge:ingots/steel>,
]);

// Nav Com
quantiscope.removeByName("tardis:quantiscope/subsystem/nav_com");
addQuantiscopeRecipe("tardis/quantiscope/subsystem/nav_com", <item:tardis:subsystem/nav_com>, [
    <item:tardis:circuits>,
    <item:minecraft:clock>,
    <item:minecraft:compass>,
    <item:minecraft:ender_eye>,
    <item:tardis:xion_crystal>,
]);

// Shield Generator
quantiscope.removeByName("tardis:quantiscope/subsystem/shield_generator");
quantiscope.removeByName("tardis:quantiscope/subsystem/shield_generator_repair");
addQuantiscopeRecipe("tardis/quantiscope/subsystem/shield_generator", <item:tardis:subsystem/shield_generator>, [
    <item:tardis:circuits>,
    <item:immersiveengineering:tesla_coil>,
]);
addQuantiscopeRepairRecipe("tardis/quantiscope/subsystem/shield_generator_repair", <item:tardis:subsystem/shield_generator>, [
        <item:immersiveengineering:coil_lv>
]);

// Temporal Grace
quantiscope.removeByName("tardis:quantiscope/subsystem/temporal_grace");
quantiscope.removeByName("tardis:quantiscope/subsystem/temporal_grace_repair");
addQuantiscopeRecipe("tardis/quantiscope/subsystem/temporal_grace", <item:tardis:subsystem/temporal_grace>, [
    <item:tardis:circuits>,
    <item:minecraft:totem_of_undying>,
]);
addQuantiscopeRepairRecipe("tardis/quantiscope/subsystem/temporal_grace_repair", <item:tardis:subsystem/temporal_grace>, [
    <item:tardis:circuits>,
    <item:minecraft:golden_apple>,
]);

// Interstitial Antenna
quantiscope.removeByName("tardis:quantiscope/subsystem/interstitial_antenna");
quantiscope.removeByName("tardis:quantiscope/subsystem/interstitial_antenna_repair");
addQuantiscopeRecipe("tardis/quantiscope/subsystem/interstitial_antenna", <item:tardis:subsystem/interstitial_antenna>, [
    <item:tardis:circuits>,
    <item:tardis:xion_crystal>,
    <tag:items:forge:wires/copper>,
]);
addQuantiscopeRepairRecipe("tardis/quantiscope/subsystem/interstitial_antenna_repair", <item:tardis:subsystem/interstitial_antenna>, [
    <tag:items:forge:wires/copper>
]);