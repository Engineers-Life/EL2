#priority 50

println("BEGIN tags.zs");

for axe in [
        <item:aquaculture:neptunium_axe>,
        <item:betterendforge:aeternium_axe>,
        <item:betterendforge:terminite_axe>,
        <item:immersiveengineering:axe_steel>,
        <item:minecraft:netherite_axe>,
        <item:notreepunching:diamond_mattock>,
        <item:notreepunching:flint_axe>,
        <item:notreepunching:gold_mattock>,
        <item:notreepunching:iron_mattock>,
        <item:vanillafoodpantry:flint_butcher_axe> ] {
    <tag:items:minecraft:axes>.add(axe);
}

println("END tags.zs");
