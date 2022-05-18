//for replacing food based recipes
import crafttweaker.api.item.MCItemDefinition;
import crafttweaker.api.item.IItemStack;
import crafttweaker.api.tag.MCTag;

val air = <item:minecraft:air>;

//Egg Recipes
craftingTable.removeRecipe(<item:simplefarming:egg_sandwich>);
craftingTable.addShaped("egg_sandwich", <item:simplefarming:egg_sandwich>, [
[<tag:items:forge:bread>,<item:simplefarming:cooked_bacon>],
[<item:vanillafoodpantry:fried_egg>, air]], null);

craftingTable.removeRecipe(<item:simplefarming:fried_rice>);
craftingTable.addShaped("fried_rice", <item:simplefarming:fried_rice>, [
[<item:simplefarming:rice>, <item:vanillafoodpantry:fried_egg>],
[<tag:items:forge:vegetables>, air]], null);