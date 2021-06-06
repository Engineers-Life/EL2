#priority 50

println("BEGIN tags.zs");

<tag:items:minecraft:axes>.add(<tag:items:notreepunching:mattocks>);
for axe in [
        <item:aquaculture:neptunium_axe>,
        <item:betterendforge:aeternium_axe>,
        <item:betterendforge:terminite_axe>,
        <item:immersiveengineering:axe_steel>,
        <item:minecraft:netherite_axe>,
        <item:notreepunching:flint_axe>,
        <item:vanillafoodpantry:flint_butcher_axe> ] {
    <tag:items:minecraft:axes>.add(axe);
}

<tag:items:itemfilters:check_nbt>.add(<item:immersiveengineering:blueprint>);
<tag:items:itemfilters:check_nbt>.add(<item:patchouli:guide_book>);
<tag:items:itemfilters:check_nbt>.add(<item:tetra:scroll_rolled>);

println("END tags.zs");
