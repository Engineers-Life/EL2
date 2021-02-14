<recipetype:blasting>.removeRecipe(<item:mapperbase:steel_ingot>);
<recipetype:blasting>.removeRecipe(<item:mapperbase:steel_plate>);
furnace.removeRecipe(<item:minecraft:charcoal>);

<recipetype:blasting>.removeRecipe(<item:bigreactors:yellorium_ingot>);
<recipetype:blasting>.removeRecipe(<item:bigreactors:graphite_ingot>);
furnace.removeRecipe(<item:industrialforegoing:plastic>);
furnace.removeRecipe(<item:bigreactors:yellorium_ingot>);
furnace.removeRecipe(<item:bigreactors:cyanite_ingot>);
furnace.removeRecipe(<item:bigreactors:graphite_ingot>);

// Blast Furnace

val clay_plate = <item:spareparts:plates/fired_clay>;
craftingTable.removeRecipe(<item:minecraft:blast_furnace>);
craftingTable.addShaped("blast_furnace", <item:minecraft:blast_furnace>, [
    [clay_plate,clay_plate,clay_plate],
    [clay_plate,<item:minecraft:furnace>,clay_plate],
    [<item:minecraft:smooth_stone>,<item:minecraft:smooth_stone>,<item:minecraft:smooth_stone>]]);
