
println("BEGIN immersive_petroleum.zs");

// Processing for testing.  Will need numbers altered to help balance production.

// arc furnace forge:bitument and forge:charcoal to make bigreactors:graphite_dust
<recipetype:immersiveengineering:arc_furnace>.addRecipe("graphite_dust", <tag:items:forge:charcoal> * 2, [<tag:items:forge:bitumen>], 100, 51200, [<item:bigreactors:graphite_dust>*3]);
<recipetype:immersiveengineering:arc_furnace>.addRecipe("blocks_to_graphite_dust", <tag:items:forge:storage_blocks/charcoal> * 2, [<tag:items:forge:storage_blocks/bitumen>], 800, 409600, [<item:bigreactors:graphite_dust>*27]);

// graphite dust and gas in mixer to make bio fuel
<recipetype:immersiveengineering:mixer>.addRecipe("bio_fuel_from_gas",<tag:fluids:forge:gasoline>, [<tag:items:forge:dusts/graphite>], 3200, <fluid:industrialforegoing:biofuel>, 500);

// or plant oil and creosote to make biofuel
<recipetype:immersiveengineering:refinery>.addRecipe("bio_fuel_from_creo", <tag:fluids:forge:plantoil> * 4, <tag:fluids:forge:creosote> * 8, 80, <fluid:industrialforegoing:biofuel> * 12);

// bio fuel 4 + gasoline 8 in refinery to make biodiesel 12
<tag:fluids:forge:biofuel>.remove(<fluid:industrialforegoing:biofuel_fluid>); // shows up as translation key.  Probably used for floring bioduwl.
<recipetype:immersiveengineering:refinery>.addRecipe("process_gasoline", <tag:fluids:forge:biofuel> * 4, <tag:fluids:forge:gasoline> * 8, 80, <fluid:immersiveengineering:biodiesel> * 12);

println("END immersive_petroleum.zs");
