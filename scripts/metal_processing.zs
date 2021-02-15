
// remove crafting dust in crafting table: no hammering ores, no hand blending alloy from grit
for dust in <tag:items:forge:dusts>.getElements() {
    craftingTable.removeRecipe(dust);
}

// remove all ores processed in furnace
for wrapper in furnace.getAllRecipes() {
    // WrapperRecipe.List<IIngredient>[0].IItemStack[0] in List<>
    if (wrapper.ingredients[0].items[0] in <tag:items:forge:ores>.getElements()) {
        furnace.removeRecipe(wrapper.output);
    }
}
