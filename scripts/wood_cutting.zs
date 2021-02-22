
import crafttweaker.api.BracketHandlers;

println("BEGIN wood_cutting");

// transer all recipes from woodenutilities:woodcutter to Charm's minecraft:woodcutter
// exclude recipes that already exist

val fromType = <recipetype:woodenutilities:woodcutter>;
val toType = <recipetype:minecraft:woodcutting>;
val recipePrefix = "woodcutter";

function validName(name as string) as string {
    val rl = BracketHandlers.getResourceLocation(name);
    return rl.namespace+"."+rl.path;
}

for fromTypeWrapper in fromType.getAllRecipes() {
    val ingredientsList = fromTypeWrapper.ingredients;
    val output = fromTypeWrapper.output;
    val toTypeRecipes = toType.getRecipesByOutput(output);
    // println("Evaluating recipe that outputs: "+output.displayName);
    for fromTypeIngredient in ingredientsList {
        for fromTypeItem in fromTypeIngredient.items {
            // println("Evaluating recipe that converts "+fromTypeItem.displayName+" into "+output.displayName);
            var existingRecipe = false;
            for toTypeWrapper in toTypeRecipes {
                for toTypeIngredient in toTypeWrapper.ingredients {
                    for toTypeItem in toTypeIngredient.items {
                        existingRecipe = existingRecipe || (toTypeItem.matches(fromTypeItem));
                    }
                }
            }
            if (!existingRecipe) {
                // println("Couldn\'t find that converts "+fromTypeItem.displayName+" into "+output.displayName+", adding it.");
                toType.addJSONRecipe(recipePrefix+"."+validName(fromTypeItem.registryName)+".to."+validName(output.registryName), {ingredient:{item:fromTypeItem.registryName},result:output.registryName,count:1 as int});

            }
        }
    }
}
fromType.removeAll();

craftingTable.removeRecipe(<item:woodenutilities:wood_cutter>);
mods.jei.JEI.hideItem(<item:woodenutilities:wood_cutter>);

// remove WOOD cutting recipes from STONE cutter
for wrapper in stoneCutter.getAllRecipes() {
    if (wrapper.ingredients[0].items[0] in <tag:items:minecraft:planks>.getElements()) {
        stoneCutter.removeRecipe(wrapper.output);
    }
}

println("END wood_cutting");
