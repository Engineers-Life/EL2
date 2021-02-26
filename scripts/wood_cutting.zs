
import crafttweaker.api.BracketHandlers;
import crafttweaker.api.item.IItemStack;
import crafttweaker.api.item.MCItemDefinition;

println("BEGIN wood_cutting");

// transer all recipes from woodenutilities:woodcutter to Charm's minecraft:woodcutter
// exclude recipes that already exist

val fromType = <recipetype:woodenutilities:woodcutter>;
val toType = <recipetype:charm:woodcutting>;
val recipePrefix = "woodcutter";

// make mine a double - fix bad recipes
//    <item:immersiveengineering:treated_scaffold>,
val changeOutput = {
    <item:immersiveengineering:treated_scaffold>            : 2,
    <item:immersiveengineering:slab_treated_wood_horizontal>: 2,
    <item:immersiveengineering:slab_treated_wood_vertical>  : 2,
    <item:immersiveengineering:slab_treated_wood_packaged>  : 2,
    <item:immersiveengineering:stick_treated>               : 2
    };

fromType.removeRecipe(<item:minecraft:air>);
toType.removeRecipe(<item:minecraft:air>);
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
                val out = output in changeOutput ? changeOutput[output] : 1;
                toType.addJSONRecipe(recipePrefix+"."+validName(fromTypeItem.registryName)+".to."+validName(output.registryName), {ingredient:{item:fromTypeItem.registryName},result:output.registryName,count:out as int});

            }
        }
    }
}
fromType.removeAll();

toType.removeRecipe(<item:minecraft:air>);
val stick = <item:minecraft:stick>;
for element in <tag:items:minecraft:planks>.getElements() {
    val name = element.defaultInstance.registryName;
    toType.addJSONRecipe(recipePrefix+"."+validName(name)+".to.sticks", {ingredient:{item:name},result:stick.registryName,count:2 as int});
}

craftingTable.removeRecipe(<item:woodenutilities:wood_cutter>);
mods.jei.JEI.hideItem(<item:woodenutilities:wood_cutter>);

// remove WOOD cutting recipes from STONE cutter
for wrapper in stoneCutter.getAllRecipes() {
    if (wrapper.ingredients[0].items[0] in <tag:items:minecraft:planks>.getElements()) {
        stoneCutter.removeRecipe(wrapper.output);
    }
}

println("END wood_cutting");
