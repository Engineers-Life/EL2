
<tag:items:forge:ingots/uranium>.remove(<item:bigreactors:yellorium_ingot>);

//Arc furance processing
<recipetype:immersiveengineering:arc_furnace>.addRecipe("yellorium_ingot_from_dust", <item:bigreactors:yellorium_dust>, [<item:minecraft:quartz>], 100, 100*512, [<item:bigreactors:yellorium_ingot>],<item:immersiveengineering:slag>);

// Holdover Yellorite Ore processing
<recipetype:immersiveengineering:crusher>.addRecipe("yellorite_ore_to_dust", <item:bigreactors:yellorite_ore>, 500, <item:bigreactors:yellorium_dust>*2);

//"Enrichment"
var uran = <item:immersiveengineering:dust_uranium>;
craftingTable.addShaped("uranium_enrich", <item:bigreactors:yellorium_dust>*8, [
    [uran,uran,uran],
    [uran,<item:immersivepetroleum:gasoline_bucket>,uran],
    [uran,uran,uran]]);

// Power Taps
removeAndHide(<item:bigreactors:reinforced_reactorpowertapfe_passive>);
removeAndHide(<item:bigreactors:reinforced_reactorpowertapfe_active>);

// Remove yellorite reactor component recipes
craftingTable.removeByName("bigreactors:reactor/basic/controller_ingots_yellorium");
craftingTable.removeByName("bigreactors:reactor/basic/fuelrod_ingots_yellorium");
craftingTable.removeByName("bigreactors:reactor/reinforced/controller_ingots_yellorium");
craftingTable.removeByName("bigreactors:reactor/reinforced/fuelrod_ingots_yellorium");
