
// remove the 39 panels because they are also added by Quark
craftingTable.removeByRegex("buildersaddition:.*_vertical_slab");
craftingTable.removeByRegex("buildersaddition:vertical_slab/reverse/reverse_.*");
stoneCutter.removeByRegex("buildersaddition:.*_vertical_slab_stonecutter");
mods.jei.JEI.hideRegex("buildersaddition:.*_vertical_slab");
