
// METAL PRESS

<recipetype:immersiveengineering:metal_press>.addRecipe("plastic_from_dryrubber_in_press", <item:industrialforegoing:dryrubber>, <item:immersiveengineering:mold_plate>, 2400, <item:industrialforegoing:plastic>);



// ARC FURNACE
craftingTable.removeRecipe(<item:refinedstorage:quartz_enriched_iron>);
<recipetype:immersiveengineering:arc_furnace>.addRecipe("quartz_enriched_iron", <item:minecraft:iron_ingot>, [<item:minecraft:quartz>*3], 400, 400*512, [<item:refinedstorage:quartz_enriched_iron>],<item:immersiveengineering:slag>);

<recipetype:immersiveengineering:arc_furnace>.addRecipe("plastic_from_dryrubber_in_arc", <item:industrialforegoing:dryrubber>, [], 100, 100*512, [<item:industrialforegoing:plastic>],<item:immersiveengineering:slag>);

<recipetype:immersiveengineering:arc_furnace>.addRecipe("yellorium_ingot_from_dust", <item:bigreactors:yellorium_dust>, [<item:minecraft:quartz>], 100, 100*512, [<item:bigreactors:yellorium_ingot>],<item:immersiveengineering:slag>);
<recipetype:immersiveengineering:arc_furnace>.addRecipe("yellorium_ingot_from_ore",  <item:bigreactors:yellorite_ore>,  [<item:minecraft:quartz>], 200, 200*512, [<item:bigreactors:yellorium_ingot>],<item:immersiveengineering:slag>);

<recipetype:immersiveengineering:arc_furnace>.addRecipe("graphite_ingot_from_dust",   <item:bigreactors:graphite_dust>,      [],                        100, 100*512, [<item:bigreactors:graphite_ingot>]);
<recipetype:immersiveengineering:arc_furnace>.addRecipe("graphite_ingot_from_quartz", <item:immersiveengineering:coal_coke>, [<item:minecraft:quartz>], 400, 400*512, [<item:bigreactors:graphite_ingot>],<item:immersiveengineering:slag>);

