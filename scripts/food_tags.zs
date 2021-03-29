
// add useful tags to various food items

val any_fish_tags = [
    <tag:items:alexsmobs:seal_foodstuff>,
    <tag:items:alexsmobs:shoebill_foodstuff>,
    <tag:items:carrots:nutrition/notes/animal_strict>,
    <tag:items:carrots:nutrition/notes/animal>,
    <tag:items:carrots:nutrition/notes/fish>,
    <tag:items:carrots:nutrition/notes/protein>,
    <tag:items:carrots:nutrition/notes/seafood>,
    <tag:items:forge:fishes>,
    <tag:items:forge:foods/any_proteins>,
    <tag:items:minecraft:fishes> ];

val cooked_fish_tags = [
    <tag:items:forge:cooked_fish>,
    <tag:items:forge:cooked_fishes>,
    <tag:items:forge:foods/cooked_fish>,
    <tag:items:forge:foods/cooked_proteins>,
    <tag:items:forge:foods/cooked_seafood>,
    <tag:items:forge:ingredients/fish_chowder_filler>,
    <tag:items:vanillafoodpantry:decker_proteins>,
    <tag:items:vanillafoodpantry:fish_salad_main>,
    <tag:items:vanillafoodpantry:stuffable_seafood> ];

val raw_fish_tags = [
    <tag:items:forge:fish>,
    <tag:items:forge:foods/raw_fish>,
    <tag:items:forge:foods/raw_seafood>,
    <tag:items:forge:ingredients/fish_sausage_main>,
    <tag:items:forge:ingredients/kebabs/fish>,
    <tag:items:forge:rawfish>,
    <tag:items:forge:rawmeats>,
    <tag:items:forge:stock_ingredients>,
    <tag:items:vanillafoodpantry:polarbear_feed> ];

for tag in any_fish_tags {
    tag.add(<item:aquaculture:fish_fillet_cooked>);
    tag.add(<item:aquaculture:fish_fillet_raw>);
}

for tag in cooked_fish_tags {
    tag.add(<item:aquaculture:fish_fillet_cooked>);
}

for tag in raw_fish_tags {
    tag.add(<item:aquaculture:fish_fillet_raw>);
}

val any_frogleg_tags = [
    <tag:items:carrots:nutrition/notes/animal_strict>,
    <tag:items:carrots:nutrition/notes/animal>,
    <tag:items:carrots:nutrition/notes/protein>,
    <tag:items:forge:foods/any_proteins> ];

val cooked_frogleg_tags = [
    <tag:items:forge:foods/cooked_proteins>,
    <tag:items:vanillafoodpantry:decker_proteins> ];

val raw_frogleg_tags = [
    <tag:items:forge:rawmeats>,
    <tag:items:forge:stock_ingredients>,
    <tag:items:vanillafoodpantry:polarbear_feed> ];

val froglegs_raw = [
    <item:aquaculture:frog_legs_raw>,
    <item:betterdefaultbiomes:frog_leg>,
    <item:quark:frog_leg> ];

val froglegs_cooked = [
    <item:aquaculture:frog_legs_cooked>,
    <item:betterdefaultbiomes:cooked_frog_leg>,
    <item:quark:cooked_frog_leg> ];

for tag in any_frogleg_tags {
    for item in froglegs_raw { tag.add(item); }
    for item in froglegs_cooked { tag.add(item); }
}

for tag in cooked_frogleg_tags {
    for item in froglegs_cooked { tag.add(item); }
}

for tag in raw_frogleg_tags {
    for item in froglegs_raw { tag.add(item); }
}

val bone_tags = [
    <tag:items:carrots:nutrition/notes/animal>,
    <tag:items:carrots:nutrition/notes/animal_strict>,
    <tag:items:forge:bones>,
    <tag:items:forge:stock_ingredients>,
    <tag:items:forge:stock_ingredients/bone> ];

for tag in bone_tags {
    tag.add(<item:aquaculture:fish_bones>);
}

<tag:items:forge:dough>.add(<item:vanillafoodpantry:dough_ball>);
