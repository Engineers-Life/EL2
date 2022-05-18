
println("BEGIN conflicts.zs");

val air = <item:minecraft:air>;
val bar = <item:engineersdecor:metal_bar>;
val dirt = <item:minecraft:dirt>;
val fruitLog = <item:simplefarming:fruit_log>;
val impCable = <item:storagenetwork:import_kabel>;
val ironBucket = <item:minecraft:bucket>;
val ironIngot = <tag:items:forge:ingots/iron>;
val log = <tag:items:minecraft:logs>;
val planks = <tag:items:minecraft:planks>;
val stick = <tag:items:forge:rods/wooden>;
val wooden_slab = <tag:items:minecraft:wooden_slabs>;

//<recipetype:minecraft:crafting>
//<recipetype:minecraft:stonecutting>
//<recipetype:minecraft:woodcutting>
//<recipetype:industrialforegoing:stonework_generate>

replaceByName("buildersaddition:vertical_slab/reverse/reverse_polished_granite_slab",<item:minecraft:polished_granite>,[[<item:minecraft:polished_granite_slab>,<item:minecraft:polished_granite_slab>]]);
replaceByName("buildersaddition:vertical_slab/reverse/reverse_polished_andesite_slab",<item:minecraft:polished_andesite>,[[<item:minecraft:polished_andesite_slab>,<item:minecraft:polished_andesite_slab>]]);
replaceByName("buildersaddition:vertical_slab/reverse/reverse_polished_diorite_slab",<item:minecraft:polished_diorite>,[[<item:minecraft:polished_diorite_slab>,<item:minecraft:polished_diorite_slab>]]);
replaceByName("buildersaddition:vertical_slab/reverse/reverse_stone_brick_slab",<item:minecraft:stone_bricks>,[[<item:minecraft:stone_brick_slab>,<item:minecraft:stone_brick_slab>]]);
replaceByName("buildersaddition:vertical_slab/reverse/reverse_nether_brick_slab",<item:minecraft:nether_brick>,[[<item:minecraft:nether_brick_slab>,<item:minecraft:nether_brick_slab>]]);
replaceByName("buildersaddition:vertical_slab/reverse/reverse_purpur_slab",<item:minecraft:purpur_block>,[[<item:minecraft:purpur_slab>,<item:minecraft:purpur_slab>]]);
replaceByName("buildersaddition:vertical_slab/reverse/reverse_polished_blackstone_slab",<item:minecraft:polished_blackstone>,[[<item:minecraft:polished_blackstone_slab>,<item:minecraft:polished_blackstone_slab>]]);
replaceByName("buildersaddition:vertical_slab/reverse/reverse_quartz_slab",<item:minecraft:quartz_block>,[[<item:minecraft:quartz_slab>,<item:minecraft:quartz_slab>]]);
replaceByName("buildersaddition:vertical_slab/reverse/reverse_sandstone_slab",<item:minecraft:sandstone>,[[<item:minecraft:sandstone_slab>,<item:minecraft:sandstone_slab>]]);

replaceByName("embellishcraft:granite_paving",<item:embellishcraft:granite_paving>*4,[[<item:quark:granite_bricks>,<item:quark:granite_bricks>],[<item:quark:granite_bricks>,<item:quark:granite_bricks>]]);
replaceByName("embellishcraft:diorite_paving",<item:embellishcraft:diorite_paving>*4,[[<item:quark:diorite_bricks>,<item:quark:diorite_bricks>],[<item:quark:diorite_bricks>,<item:quark:diorite_bricks>]]);
replaceByName("embellishcraft:andesite_paving",<item:embellishcraft:andesite_paving>*4,[[<item:quark:andesite_bricks>,<item:quark:andesite_bricks>],[<item:quark:andesite_bricks>,<item:quark:andesite_bricks>]]);

replaceByName("pamhc2foodcore:tool_roller",<item:pamhc2foodcore:rolleritem>,[[air,air,stick],[air,log,air],[stick,air,air]]);

var rsb = <item:quark:red_sandstone_bricks>;
replaceByName("embellishcraft:red_sandstone_paving_stones",<item:embellishcraft:red_sandstone_paving_stones>*4,[[air,rsb,air],[rsb,air,rsb],[air,rsb,air]]);
removeAndHide(<item:embellishcraft:red_sandstone_bricks>);
replaceByName("embellishcraft:red_sandstone_large_bricks",<item:embellishcraft:red_sandstone_large_bricks>*4,[[rsb,rsb],[rsb,rsb]]);

replaceByName("embellishcraft:granite_large_bricks",<item:quark:granite_bricks>*4,[[<item:embellishcraft:granite_bricks>,<item:embellishcraft:granite_bricks>],[<item:embellishcraft:granite_bricks>,<item:embellishcraft:granite_bricks>]]);
<recipetype:industrialforegoing:stonework_generate>.removeRecipe(<item:embellishcraft:granite_large_bricks>);
replaceByName("embellishcraft:granite_large_bricks_pressure_plate",<item:embellishcraft:granite_large_bricks_pressure_plate>,[[<item:quark:granite_bricks>,<item:quark:granite_bricks>]]);
SimpleJsonReplaceByName(<recipetype:minecraft:stonecutting>,"minecraft:granite_large_bricks_pressure_plate_from_granite_large_bricks_stonecutting",<item:embellishcraft:granite_large_bricks_pressure_plate>*2,<item:quark:granite_bricks>);
removeAndHide(<item:embellishcraft:granite_large_bricks>);
removeFromListAndHide([craftingTable,stoneCutter],<item:embellishcraft:granite_large_bricks_stairs>);
removeFromListAndHide([craftingTable,stoneCutter],<item:embellishcraft:granite_large_bricks_slab>);
removeFromListAndHide([craftingTable,stoneCutter],<item:embellishcraft:granite_large_bricks_wall>);

replaceByName("buildersaddition:vertical_slab/reverse/reverse_red_sandstone_slab",<item:minecraft:red_sandstone>,[[<item:minecraft:red_sandstone_slab>,<item:minecraft:red_sandstone_slab>]]);

replaceByName("minecraft:barrel",<item:minecraft:barrel>,[[wooden_slab,wooden_slab,wooden_slab],[planks,air,planks],[planks,planks,planks]]);
val barrels = <tag:items:forge:barrels/wooden>;
barrels.add(<item:minecraft:barrel>);
for item in <tag:items:charm:barrels>.getElements() {
    barrels.add(item);
}
replaceByName("engineersdecor:independent/fluid_barrel_recipe",<item:engineersdecor:fluid_barrel>,[[bar,bar,bar],[bar,barrels,bar],[bar,bar,bar]]);
replaceByName("storagenetwork:import_filter_kabel",<item:storagenetwork:import_filter_kabel>,[[air,impCable,air],[impCable,barrels,impCable],[air,impCable,air]]);
replaceByName("simplefarming:brewing_barrel",<item:simplefarming:brewing_barrel>,[[fruitLog,ironIngot,fruitLog],[ironIngot,barrels,ironIngot],[fruitLog,ironBucket,fruitLog]]);
replaceByNameShapeless("buildersaddition:planter",<item:buildersaddition:planter>,[dirt,barrels]);

replaceByName("vanillafoodpantry:bits/bit_milk_no_measure",<item:vanillafoodpantry:portion_milk>*4,[[<item:pamhc2foodcore:freshmilkitem>]]);
replaceByName("vanillafoodpantry:bits/bit_water_no_measure",<item:vanillafoodpantry:portion_water>*4,[[<item:pamhc2foodcore:freshwateritem>]]);

<tag:items:forge:rods/all_metal>.remove(<item:buildersaddition:iron_rod>);
<tag:items:forge:rods/iron>.remove(<item:buildersaddition:iron_rod>);
removeAndHide(<item:buildersaddition:iron_rod>);
replaceByName("immersiveengineering:crafting/screwdriver",<item:immersiveengineering:screwdriver>,[[air,<item:immersiveengineering:stick_iron>],[stick,air]]);

replaceByName("simplefarming:vinegar",<item:simplefarming:vinegar>,[[<tag:items:forge:empty_bottles>,<tag:items:forge:vinegar_ingredients>]]);
replaceByName("simplefarming:jam",<item:simplefarming:jam>,[[<tag:items:forge:fruits>],[<tag:items:forge:empty_bottles>]]);

replaceByName("embellishcraft:sandstone_large_bricks",<item:embellishcraft:sandstone_large_bricks>*4,[[<item:quark:sandstone_bricks>,<item:quark:sandstone_bricks>],[<item:quark:sandstone_bricks>,<item:quark:sandstone_bricks>]]);
replaceByName("embellishcraft:sandstone_bricks_pressure_plate",<item:embellishcraft:sandstone_bricks_pressure_plate>,[[<item:quark:sandstone_bricks>,<item:quark:sandstone_bricks>]]);
replaceByName("embellishcraft:sandstone_paving_stones",<item:embellishcraft:sandstone_paving_stones>*4,[[air,<item:quark:sandstone_bricks>,air],[<item:quark:sandstone_bricks>,air,<item:quark:sandstone_bricks>],[air,<item:quark:sandstone_bricks>,air]]);
SimpleJsonReplaceByName(stoneCutter,"minecraft:sandstone_bricks_pressure_plate_from_sandstone_bricks_stonecutting",<item:embellishcraft:sandstone_bricks_pressure_plate>*2,<item:quark:sandstone_bricks>);
removeAndHide(<item:embellishcraft:sandstone_bricks>);
removeFromListAndHide([craftingTable,stoneCutter],<item:embellishcraft:sandstone_bricks_stairs>);
removeFromListAndHide([craftingTable,stoneCutter],<item:embellishcraft:sandstone_bricks_slab>);
removeFromListAndHide([craftingTable,stoneCutter],<item:embellishcraft:sandstone_bricks_wall>);

replaceByName("immersiveengineering:crafting/metal_ladder_steel",<item:immersiveengineering:metal_ladder_steel>*3,[[<tag:items:immersiveengineering:scaffoldings/steel>],[<item:buildersaddition:iron_ladder_rough>]]);
replaceByName("immersiveengineering:crafting/metal_ladder_alu",<item:immersiveengineering:metal_ladder_alu>*3,[[<tag:items:immersiveengineering:scaffoldings/aluminum>],[<item:buildersaddition:iron_ladder>]]);
removeAndHide(<item:immersiveengineering:metal_ladder_none>);
removeAndHide(<item:quark:iron_ladder>); // didn't conflict, just redundant

replaceByName("terraincognita:compat/quark/apple/vertical_slabs",<item:terraincognita:apple_vertical_slab>*3,[[<item:terraincognita:apple_slab>],[<item:terraincognita:apple_slab>],[<item:terraincognita:apple_slab>]]);
replaceByNameMirrored("quark:building/crafting/shingles/shingles",<item:quark:shingles>*2,[[<item:minecraft:terracotta>,air],[air,<item:minecraft:terracotta>]]);

replaceByNameShapeless("simplefarming:pink_dye",<item:minecraft:pink_dye>,[<item:simplefarming:cactus_fruit>]);
replaceByNameShapeless("simplefarming:blue_dye",<item:minecraft:blue_dye>,[<item:simplefarming:blueberries>]);
craftingTable.removeByName("simplefarming:red_dye1");
craftingTable.removeByName("simplefarming:red_dye2");
craftingTable.addShapeless(validName("simplefarming:red_dye"),<item:minecraft:red_dye>,[<item:simplefarming:raspberries>|<item:simplefarming:strawberries>|<item:minecraft:sweet_berries>]);
replaceByNameShapeless("simplefarming:black_dye",<item:minecraft:black_dye>,[<item:simplefarming:blackberries>]);

// bitumen to use tag and fluid crafting
craftingTable.removeByName("immersivepetroleum:asphalt");
craftingTable.removeByName("immersivepetroleum:asphalt2");
changeIngredientsToTag([<item:immersivepetroleum:bitumen>,<item:mapperbase:raw_bitumen>],<tag:items:forge:bitumen>);
changeItemListToBaseItem([<item:mapperbase:raw_bitumen>],<item:immersivepetroleum:bitumen>);
craftingTable.addJSONRecipe("asphalt",{
    "type":"immersiveengineering:shaped_fluid",
    "pattern": ["SBS","GWG","SBS"],
    "key": {
        "S": {  "tag":  "forge:sand" },
        "B": {  "tag":  "forge:bitumen" },
        "G": {  "item": "minecraft:gravel" },
        "W": {  "tag":  "minecraft:water",
                "amount": 1000,
                "type": "immersiveengineering:fluid" } },
    "result": { "item": "immersivepetroleum:asphalt",
                "count": 8 } } );
craftingTable.addJSONRecipe("asphalt2",{
    "type":"immersiveengineering:shaped_fluid",
    "pattern": ["SBS","GWG","SBS"],
    "key": {
        "S": {  "item": "immersiveengineering:slag" },
        "B": {  "tag": "forge:bitumen" },
        "G": {  "item": "minecraft:gravel" },
        "W": {  "tag": "minecraft:water",
                "amount": 1000,
                "type": "immersiveengineering:fluid" } },
    "result": { "item": "immersivepetroleum:asphalt",
                "count": 12 } } );

// FOOD ITEMS

replaceByName("vanillafoodpantry:sandwich/cyclops_sandwich",<item:vanillafoodpantry:cyclops_sandwich>*2,[[<tag:items:forge:foods/sandwich_breads>,<item:vanillafoodpantry:tangy_mayonnaise>,<tag:items:forge:cheese>],[<item:vanillafoodpantry:guardian_meat>,<tag:items:forge:ingredients/salad>]]);

removeAllTagsAndHide(<item:simplefarming:raw_horse_meat>);
removeFromListAndHide([campfire,furnace,smoker,<recipetype:charm:firing>],<item:simplefarming:cooked_horse_meat>);

removeAllTagsAndHide(<item:simplefarming:raw_calamari>);
removeFromListAndHide([campfire,furnace,smoker,<recipetype:charm:firing>],<item:simplefarming:fried_calamari>);

removeAndHide(<item:veggie_way:dough>);
removeAndHide(<item:pamhc2foodcore:doughitem>);
removeAndHide(<item:vanillafoodpantry:leavening_agent>);
removeAndHide(<item:vanillafoodpantry:leavening_agent_ball>);
removeAndHide(<item:vanillafoodpantry:leavening_agent_pantry_block>);
changeIngredientWithConversion(<item:pamhc2foodcore:doughitem>,<item:vanillafoodpantry:dough_ball>);
changeIngredientWithConversion(<item:veggie_way:dough>,<item:vanillafoodpantry:dough_ball>);
replaceByName("vanillafoodpantry:bakery/dough_ball",<item:vanillafoodpantry:dough_ball>*2,[[<tag:items:forge:tool_mixingbowl>,<tag:items:forge:flour>],[<tag:items:forge:water>,<tag:items:forge:salt>]]);
removeFromListAndHide([campfire,furnace,smoker,<recipetype:charm:firing>],<item:vanillafoodpantry:cooked_dough>);
changeIngredientsToTag([<item:vanillafoodpantry:leavening_agent_ball>],<tag:items:forge:salt>);

changeIngredientWithConversion(<item:pamhc2foodcore:friedeggitem>,<item:vanillafoodpantry:fried_egg>);
removeAndHide(<item:pamhc2foodcore:friedeggitem>);

changeIngredientAndBaseRecipes([<item:pamhc2foodcore:flouritem>,<item:veggie_way:flour>],<item:vanillafoodpantry:portion_flour>,[<item:pamhc2foodcore:flouritem>,<item:veggie_way:flour>,<item:vanillafoodpantry:portion_flour>]);

println("END conflicts.zs");
