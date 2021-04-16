
// METAL PRESS

<recipetype:immersiveengineering:metal_press>.addRecipe("plastic_from_dryrubber_in_press", <item:industrialforegoing:dryrubber>, <item:immersiveengineering:mold_plate>, 2400, <item:industrialforegoing:plastic>);
<recipetype:immersiveengineering:metal_press>.addRecipe("clay_brick_from_clay_block_in_press", <item:minecraft:clay>, <item:immersiveengineering:mold_unpacking>, 2400, <item:notreepunching:clay_brick>*4);

// ARC FURNACE
craftingTable.removeRecipe(<item:refinedstorage:quartz_enriched_iron>);
<recipetype:immersiveengineering:arc_furnace>.addRecipe("quartz_enriched_iron", <item:minecraft:iron_ingot>, [<item:minecraft:quartz>*3], 400, 400*512, [<item:refinedstorage:quartz_enriched_iron>],<item:immersiveengineering:slag>);

<recipetype:immersiveengineering:arc_furnace>.addRecipe("plastic_from_dryrubber_in_arc", <item:industrialforegoing:dryrubber>, [], 100, 100*512, [<item:industrialforegoing:plastic>],<item:immersiveengineering:slag>);

<recipetype:immersiveengineering:arc_furnace>.addRecipe("yellorium_ingot_from_dust", <item:bigreactors:yellorium_dust>, [<item:minecraft:quartz>], 100, 100*512, [<item:bigreactors:yellorium_ingot>],<item:immersiveengineering:slag>);
<recipetype:immersiveengineering:arc_furnace>.addRecipe("yellorium_ingot_from_ore",  <item:bigreactors:yellorite_ore>,  [<item:minecraft:quartz>], 200, 200*512, [<item:bigreactors:yellorium_ingot>*2],<item:immersiveengineering:slag>);

<recipetype:immersiveengineering:arc_furnace>.addRecipe("graphite_ingot_from_dust",   <item:bigreactors:graphite_dust>,      [],                        100, 100*512, [<item:bigreactors:graphite_ingot>]);
<recipetype:immersiveengineering:arc_furnace>.addRecipe("graphite_ingot_from_quartz", <item:immersiveengineering:coal_coke>, [<item:minecraft:quartz>], 400, 400*512, [<item:bigreactors:graphite_ingot>],<item:immersiveengineering:slag>);

<recipetype:immersiveengineering:arc_furnace>.addRecipe("brick_from_clay_brick",   <item:notreepunching:clay_brick>,      [],                        100, 100*512, [<item:minecraft:brick>]);

// RANDOM STUFF (extreme reactors)
furnace.removeRecipe(<item:bigreactors:graphite_block>);
blastFurnace.removeRecipe(<item:bigreactors:graphite_block>);
<tag:items:natural-progression:override_pickaxes>.add(<item:immersiveengineering:buzzsaw>);

// 2 ingots - 1 plate recipes

craftingTable.removeRecipe(<item:immersiveengineering:plate_silver>);
craftingTable.addShaped("plate_silver", <item:immersiveengineering:plate_silver>, [
[<item:immersiveengineering:hammer>.anyDamage().transformDamage()], 
[<item:immersiveengineering:ingot_silver>], 
[<item:immersiveengineering:ingot_silver>]]);

craftingTable.removeRecipe(<item:immersiveengineering:plate_aluminum>);
craftingTable.addShaped("plate_aluminum", <item:immersiveengineering:plate_aluminum>, [
[<item:immersiveengineering:hammer>.anyDamage().transformDamage()], 
[<item:immersiveengineering:ingot_aluminum>], 
[<item:immersiveengineering:ingot_aluminum>]]);

craftingTable.removeRecipe(<item:immersiveengineering:plate_gold>);
craftingTable.addShaped("plate_gold", <item:immersiveengineering:plate_gold>, [
[<item:immersiveengineering:hammer>.anyDamage().transformDamage()], 
[<item:minecraft:gold_ingot>], 
[<item:minecraft:gold_ingot>]]);

craftingTable.removeRecipe(<item:immersiveengineering:plate_electrum>);
craftingTable.addShaped("plate_electrum", <item:immersiveengineering:plate_electrum>, [
[<item:immersiveengineering:hammer>.anyDamage().transformDamage()], 
[<item:immersiveengineering:ingot_electrum>], 
[<item:immersiveengineering:ingot_electrum>]]);

craftingTable.removeRecipe(<item:immersiveengineering:plate_uranium>);
craftingTable.addShaped("plate_uranium", <item:immersiveengineering:plate_uranium>, [
[<item:immersiveengineering:hammer>.anyDamage().transformDamage()], 
[<item:immersiveengineering:ingot_uranium>], 
[<item:immersiveengineering:ingot_uranium>]]);

craftingTable.removeRecipe(<item:immersiveengineering:plate_copper>);
craftingTable.addShaped("plate_copper", <item:immersiveengineering:plate_copper>, [
[<item:immersiveengineering:hammer>.anyDamage().transformDamage()], 
[<item:immersiveengineering:ingot_copper>], 
[<item:immersiveengineering:ingot_copper>]]);

craftingTable.removeRecipe(<item:immersiveengineering:plate_nickel>);
craftingTable.addShaped("plate_nickel", <item:immersiveengineering:plate_nickel>, [
[<item:immersiveengineering:hammer>.anyDamage().transformDamage()], 
[<item:immersiveengineering:ingot_nickel>], 
[<item:immersiveengineering:ingot_nickel>]]);

craftingTable.removeRecipe(<item:immersiveengineering:plate_lead>);
craftingTable.addShaped("plate_lead", <item:immersiveengineering:plate_lead>, [
[<item:immersiveengineering:hammer>.anyDamage().transformDamage()], 
[<item:immersiveengineering:ingot_lead>], 
[<item:immersiveengineering:ingot_lead>]]);

craftingTable.removeRecipe(<item:immersiveengineering:plate_constantan>);
craftingTable.addShaped("plate_constantan", <item:immersiveengineering:plate_constantan>, [
[<item:immersiveengineering:hammer>.anyDamage().transformDamage()], 
[<item:immersiveengineering:ingot_constantan>], 
[<item:immersiveengineering:ingot_constantan>]]);
