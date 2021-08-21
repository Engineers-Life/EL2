var air = <item:minecraft:air>;

println("BEGIN MM.zs");

//Machinery Manual
craftingTable.addShaped("machinery_manual", <item:patchouli:guide_book>.withTag({"patchouli:book": "patchouli:el2-machine-manual" as string}), [
    [<item:minecraft:book>],
    [<item:immersiveengineering:light_engineering>]]);

//Foundations
craftingTable.addShaped("foundation_block", <item:spareparts:reinforcement/reinforcement_block> * 2, [
    [<item:immersiveengineering:plate_steel>, air, <item:immersiveengineering:plate_steel>],
    [air, <item:immersiveengineering:steel_scaffolding_standard>, air],
    [<item:immersiveengineering:plate_steel>, air, <item:immersiveengineering:plate_steel>]]);

craftingTable.addShapeless("half_foundation", <item:spareparts:reinforcement/foundation_half> * 2, [<item:spareparts:reinforcement/reinforcement_block>]);

craftingTable.addShapeless("quarter_foundation", <item:spareparts:reinforcement/foundation_quarter> * 2, [<item:spareparts:reinforcement/foundation_half>]);

craftingTable.addShapeless("back_half_foundation", <item:spareparts:reinforcement/foundation_half>, [<item:spareparts:reinforcement/foundation_quarter>,<item:spareparts:reinforcement/foundation_quarter>]);

craftingTable.addShapeless("back_foundation_block", <item:spareparts:reinforcement/reinforcement_block>, [<item:spareparts:reinforcement/foundation_half>,<item:spareparts:reinforcement/foundation_half>]);

//MM Blocks

removeAndHide(<item:masterfulmachinery:ind_kln_energy_port_energy_output>);

craftingTable.addShaped("kiln_controller", <item:masterfulmachinery:ind_kln_controller> , [
    [<item:immersiveengineering:plate_steel>, <item:minecraft:bricks>, <item:immersiveengineering:plate_steel>],
    [<item:minecraft:bricks>, <item:immersiveengineering:rs_engineering>, <item:minecraft:bricks>],
    [<item:immersiveengineering:plate_steel>, <item:minecraft:bricks>, <item:immersiveengineering:plate_steel>]]);

craftingTable.addShaped("kiln_item_input", <item:masterfulmachinery:ind_kln_item_port_items_input> , [
    [<item:immersiveengineering:plate_steel>, <item:minecraft:bricks>, <item:immersiveengineering:plate_steel>],
    [<item:minecraft:bricks>, <item:immersiveengineering:conveyor_redstone>, <item:minecraft:bricks>],
    [<item:immersiveengineering:plate_steel>, <item:minecraft:bricks>, <item:immersiveengineering:plate_steel>]]);

craftingTable.addShaped("kiln_item_output", <item:masterfulmachinery:ind_kln_item_port_items_output> , [
    [<item:immersiveengineering:plate_steel>, <item:minecraft:bricks>, <item:immersiveengineering:plate_steel>],
    [<item:minecraft:bricks>, <item:immersiveengineering:conveyor_extract>, <item:minecraft:bricks>],
    [<item:immersiveengineering:plate_steel>, <item:minecraft:bricks>, <item:immersiveengineering:plate_steel>]]);

craftingTable.addShaped("kiln_energy_input", <item:masterfulmachinery:ind_kln_energy_port_energy_input> , [
    [<item:immersiveengineering:plate_steel>, <item:minecraft:bricks>, <item:immersiveengineering:plate_steel>],
    [<item:minecraft:bricks>, <item:immersiveengineering:capacitor_lv>, <item:minecraft:bricks>],
    [<item:immersiveengineering:plate_steel>, <item:minecraft:bricks>, <item:immersiveengineering:plate_steel>]]);        

//building tools comment out for building stuff
removeAndHide(<item:masterfulmachinery:structure_gen_device>);
removeAndHide(<item:masterfulmachinery:structure_generator>);
removeAndHide(<item:masterfulmachinery:projector>);
println("END misc.zs");
