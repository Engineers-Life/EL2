
<tag:items:forge:ingots/uranium>.remove(<item:bigreactors:yellorium_ingot>);
<tag:items:forge:dusts/uranium>.remove(<item:bigreactors:yellorium_dust>);

//Arc furance processing
<recipetype:immersiveengineering:arc_furnace>.addRecipe("yellorium_ingot_from_dust", <item:bigreactors:yellorium_dust>, [<item:minecraft:quartz>], 100, 100*512, [<item:bigreactors:yellorium_ingot>],<item:immersiveengineering:slag>);

// Holdover Yellorite Ore processing
<recipetype:immersiveengineering:crusher>.addRecipe("yellorite_ore_to_dust", <item:bigreactors:yellorite_ore>, 500, <item:bigreactors:yellorium_dust>*2);

//"Enrichment"
<tag:fluids:immersivepetroleum:gasoline>.add(<fluid:immersivepetroleum:gasoline>);
craftingTable.addJSONRecipe("uranium_enrich_with_fluid",{
    "type":"immersiveengineering:shaped_fluid",
    "pattern": ["UUU","UGU","UUU"],
    "key": {
        "U": {  "item": "immersiveengineering:dust_uranium" },
        "G": {  "tag": "immersivepetroleum:gasoline",
                "amount": 1000,
                "type": "immersiveengineering:fluid" } },
    "result": { "item": "bigreactors:yellorium_dust",
                "count": 8 } } );

// Power Taps
removeAndHide(<item:bigreactors:reinforced_reactorpowertapfe_passive>);
removeAndHide(<item:bigreactors:reinforced_reactorpowertapfe_active>);

// Remove yellorite reactor component recipes
craftingTable.removeByName("bigreactors:reactor/basic/controller_ingots_yellorium");
craftingTable.removeByName("bigreactors:reactor/basic/fuelrod_ingots_yellorium");
craftingTable.removeByName("bigreactors:reactor/reinforced/controller_ingots_yellorium");
craftingTable.removeByName("bigreactors:reactor/reinforced/fuelrod_ingots_yellorium");
