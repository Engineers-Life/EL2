
var air = <item:minecraft:air>;

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

<recipetype:industrialforegoing:dissolution_chamber>.removeRecipe(<item:minecraft:experience_bottle>); // which may or may not exist
<recipetype:industrialforegoing:dissolution_chamber>.addJSONRecipe("industrialforegoing.dissolution_chamber/xp_bottles", {
    input: [ { tag: "forge:empty_bottles" } ],
    inputFluid: "{FluidName:\"industrialforegoing:essence\",Amount:250}",
    processingTime: 300,
    output: {
        item: <item:minecraft:experience_bottle>.registryName,
        count:1 } } );

// mob imprisonment tool
craftingTable.removeRecipe(<item:industrialforegoing:mob_imprisonment_tool>);
craftingTable.addShaped("mob_imprisonment_tool",<item:industrialforegoing:mob_imprisonment_tool>,
 [[air,<item:industrialforegoing:plastic>,air],
 [<item:industrialforegoing:plastic>,<item:betterportals:portal_fluid_bucket>,<item:industrialforegoing:plastic>],
 [air,<item:industrialforegoing:plastic>,air]]);

 //Disable items
 for item in [
        <item:industrialforegoing:infinity_hammer>,
        <item:industrialforegoing:infinity_backpack>,
        <item:industrialforegoing:infinity_saw>,
        <item:industrialforegoing:infinity_drill>,
        <item:industrialforegoing:infinity_trident>,
        <item:industrialforegoing:infinity_charger>,
        <item:industrialforegoing:infinity_nuke>,
        <item:industrialforegoing:infinity_launcher>,
        <item:industrialforegoing:meat_feeder>,
        <item:industrialforegoing:pity_black_hole_tank>,
        <item:industrialforegoing:simple_black_hole_tank>,
        <item:industrialforegoing:common_black_hole_tank>,
        <item:industrialforegoing:advanced_black_hole_tank>,
        <item:industrialforegoing:supreme_black_hole_tank>,
        <item:industrialforegoing:simple_black_hole_unit>,
        <item:industrialforegoing:pity_black_hole_unit>,
        <item:industrialforegoing:common_black_hole_unit>,
        <item:industrialforegoing:advanced_black_hole_unit>,
        <item:industrialforegoing:supreme_black_hole_unit>,
        <item:industrialforegoing:black_hole_controller>,
        <item:industrialforegoing:conveyor>,
        <item:industrialforegoing:conveyor_extraction_upgrade>,
        <item:industrialforegoing:conveyor_insertion_upgrade>,
        <item:industrialforegoing:conveyor_detection_upgrade>,
        <item:industrialforegoing:conveyor_bouncing_upgrade>,
        <item:industrialforegoing:conveyor_dropping_upgrade>,
        <item:industrialforegoing:conveyor_blinking_upgrade>,
        <item:industrialforegoing:conveyor_splitting_upgrade>,
        <item:industrialforegoing:spores_recreator>,
        <item:industrialforegoing:pitiful_generator>,
        <item:industrialforegoing:biofuel_generator>,
        <item:industrialforegoing:bioreactor>,
        <item:industrialforegoing:mycelial_reactor>,
        <item:industrialforegoing:mycelial_furnace>,
        <item:industrialforegoing:mycelial_slimey>,
        <item:industrialforegoing:mycelial_culinary>,
        <item:industrialforegoing:mycelial_potion>,
        <item:industrialforegoing:mycelial_disenchantment>,
        <item:industrialforegoing:mycelial_ender>,
        <item:industrialforegoing:mycelial_explosive>,
        <item:industrialforegoing:mycelial_frosty>,
        <item:industrialforegoing:mycelial_halitosis>,
        <item:industrialforegoing:mycelial_magma>,
        <item:industrialforegoing:mycelial_pink>,
        <item:industrialforegoing:mycelial_netherstar>,
        <item:industrialforegoing:mycelial_death>,
        <item:industrialforegoing:mycelial_rocket>,
        <item:industrialforegoing:mycelial_crimed>,
        <item:industrialforegoing:mycelial_meatallurgic>,
        <item:industrialforegoing:washing_factory>,
        <item:industrialforegoing:fermentation_station>,
        <item:industrialforegoing:item_transporter_type>,
        <item:industrialforegoing:fluid_transporter_type>,
        <item:industrialforegoing:world_transporter_type>,
        <item:industrialforegoing:fluid_sieving_machine>
    ] {
     removeFromListAndHide([craftingTable,<recipetype:industrialforegoing:dissolution_chamber>],item);
 }
