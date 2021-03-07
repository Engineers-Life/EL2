
println("BEGIN builders_addition.zs");

// remove the 39 panels because they are also added by Quark
craftingTable.removeByRegex("buildersaddition:.*_vertical_slab");
craftingTable.removeByRegex("buildersaddition:vertical_slab/reverse/reverse_.*_both");
stoneCutter.removeByRegex("buildersaddition:.*_vertical_slab_stonecutter");

// vertical slabs are in recipes through the use of the quark tag
val tag = <tag:items:quark:planks_vertical_slab>;
for definition in tag.getElements() {
    val item = definition.defaultInstance;
    if (item.owner == "buildersaddition") {
        println("remove quark tag from "+item.registryName);
        tag.remove(item);
    }
}

// vertical slabs are in recipes that already have quark vertical slab using copies
val modid = "buildersaddition";
val substr = "_vertical_slab";
craftingTable.removeByModid(modid, (name) => {
    val wrapper = craftingTable.getRecipeByName(modid+":"+name);
    for ingList in wrapper.ingredients {
        for item in ingList.items {
            if ((modid == item.owner) && item.registryName.path.endsWith(substr)) {
                return false;
            }
        }
    }
    return true;
});

// now that they aren't in any more recipes
mods.jei.JEI.hideRegex("buildersaddition:.*_vertical_slab");

println("END builders_addition.zs");
