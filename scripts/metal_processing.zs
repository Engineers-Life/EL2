
println("BEGIN metal_processing");

// remove making dust in crafting table

for dust in <tag:items:forge:dusts>.getElements() {
    craftingTable.removeRecipe(dust);
}

// remove processing ores in furnace

for wrapper in furnace.getAllRecipes() {
    // WrapperRecipe.List<IIngredient>[0].IItemStack[0] in List<>
    if (wrapper.ingredients[0].items[0] in <tag:items:forge:ores>.getElements()) {
        furnace.removeRecipe(wrapper.output);
    }
}

// move melting items into nuggets from furnace into blast furnace
// only adds recipe to blast furnace if recipe doesn't already exist there
// iterates every furnace recipe, checks if the output is a nugget
// if it is a nugget, iterates through all the items that can produce that nugget
// for each of those, iterates through all the blast furnace recipes that also produce that nugget
// if any of the blast furnace recipes use the same input as the item being checked, it won't add the recipe
// because the recipe already exists.  If none of the blast furnace recipes use that item
// then the item is a quark trowel, because that's the only thing this whole section manages to find
// but let's keep it, in case mods change, cause this code will catch that.
for furnaceWrapper in furnace.getAllRecipes() {
    if (furnaceWrapper.output in <tag:items:forge:nuggets>.getElements()) {
        val ingredientsList = furnaceWrapper.ingredients;
        val output = furnaceWrapper.output;
        val blastRecipes = blastFurnace.getRecipesByOutput(output);
        // println("Evaluating furnace recipe that outputs: "+output.displayName);
        for furnaceIngredient in ingredientsList {
            for furnaceItem in furnaceIngredient.items {
                // println("Evaluating furnace recipe that converts "+furnaceItem.displayName+" into "+output.displayName);
                var existingRecipe = false;
                for blastWrapper in blastRecipes {
                    for blastIngredient in blastWrapper.ingredients {
                        for blastItem in blastIngredient.items {
                            existingRecipe = existingRecipe || (blastItem.matches(furnaceItem));
                        }
                    }
                }
                if (!existingRecipe) {
                    println("Couldn\'t find blast furnace recipe that converts "+furnaceItem.displayName+" into "+output.displayName+", adding it.");
                    blastFurnace.addRecipe("melt."+furnaceItem.translationKey,output,furnaceItem,0.1,5*20);
                }
            }
        }
    }
}
// this is part of the above, but pulled out of the loop in case more than one recipe makes the same nugget.
for furnaceWrapper in furnace.getAllRecipes() {
    if (furnaceWrapper.output in <tag:items:forge:nuggets>.getElements()) {
        furnace.removeRecipe(furnaceWrapper.output);
    }
}

println("END metal_processing");
