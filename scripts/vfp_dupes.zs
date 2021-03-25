
import crafttweaker.api.item.IItemStack;

// Convert the function of vanilla food pantry foods to duplicate foods in simple farming
// The duplicates from vanilla food pantry will be disabled in the config (because simple farming doesn't have that option).

// ------------------------
// Move tags from VFP to SF

println("BEGIN vfp_dupes.zs");

val move_tags_and_hide = {
    <item:vanillafoodpantry:horse_raw>      : <item:simplefarming:raw_horse_meat>,
    <item:vanillafoodpantry:horse_cooked>   : <item:simplefarming:cooked_horse_meat>,
    <item:vanillafoodpantry:squidd_raw>     : <item:simplefarming:raw_calamari>
} as IItemStack[IItemStack];

for source, dest in move_tags_and_hide {
    for tag in <tagManager:items>.getAllTagsFor(source) {
        tag.add(dest);
    }
    mods.jei.JEI.hideItem(source);
}

// -----------------------------------------------
// Change cooking recipes: SF raw makes VFP cooked

val cooking_managers = {
    <recipetype:minecraft:campfire_cooking> : 15,
    <recipetype:minecraft:smelting>         : 5,
    <recipetype:minecraft:smoking>	        : 2 };
    
for manager, time in cooking_managers {
    manager.removeRecipe(<item:vanillafoodpantry:squidd_cooked>, <item:vanillafoodpantry:squidd_raw>);
    manager.removeRecipe(<item:simplefarming:fried_calamari>, <item:simplefarming:raw_calamari>);
    manager.addRecipe("squidd_cooked",<item:vanillafoodpantry:squidd_cooked>,<item:simplefarming:raw_calamari>,0.2,time*20); // campfire cooking doesn't xp? but the recipe works.
}

mods.jei.JEI.hideItem(<item:simplefarming:fried_calamari>);

// ----------------------------------------------------------
// Change recipes: VFP squidd_raw replaced by SF raw_calamari

craftingTable.removeByName("vanillafoodpantry:meat/portion_squid");
craftingTable.addShapeless("portion_squid",<item:vanillafoodpantry:portion_squid>*3,
    [<item:simplefarming:raw_calamari>,<tag:items:carrots:food_cutters>]);

craftingTable.removeByName("vanillafoodpantry:nuggets/nuggets_squid_fried_prep_alt");

craftingTable.addShapedMirrored("battered_calamari_with_bowl", <item:vanillafoodpantry:nuggets_squid_fried_prep>*2, [
    [<item:simplefarming:raw_calamari>,<item:simplefarming:raw_calamari>],
    [<item:vanillafoodpantry:foodpowder_batter_mix>,<item:vanillafoodpantry:bowl_water>] ]);

craftingTable.addShapedMirrored("battered_calamari_with_bottle", <item:vanillafoodpantry:nuggets_squid_fried_prep>*2, [
    [<item:simplefarming:raw_calamari>,<item:simplefarming:raw_calamari>],
    [<item:vanillafoodpantry:foodpowder_batter_mix>,<item:vanillafoodpantry:bottle_water>.transformReplace(<item:vanillafoodpantry:empty_bottle>)] ]);

mods.jei.JEI.hideItem(<item:vanillafoodpantry:squidd_raw>);

removeAndHide(<item:veggie_way:dough>);
removeAndHide(<item:pamhc2foodcore:doughitem>);
removeAndHide(<item:vanillafoodpantry:leavening_agent>);
removeAndHide(<item:vanillafoodpantry:leavening_agent_ball>);
removeAndHide(<item:vanillafoodpantry:leavening_agent_pantry_block>);
changeIngredientWithConversion(<item:pamhc2foodcore:doughitem>,<item:vanillafoodpantry:dough_ball>);
changeIngredientWithConversion(<item:veggie_way:dough>,<item:vanillafoodpantry:dough_ball>);
replaceByName("vanillafoodpantry:bakery/dough_ball",<item:vanillafoodpantry:dough_ball>*2,[[<tag:items:forge:tool_mixingbowl>,<tag:items:forge:flour>],[<tag:items:forge:water>,<tag:items:forge:salt>]]);
removeAndHide(<item:vanillafoodpantry:cooked_dough>);

println("END vfp_dupes.zs");
