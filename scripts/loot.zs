
import crafttweaker.api.loot.conditions.vanilla.LootTableId;
import crafttweaker.api.loot.conditions.LootConditionBuilder;
import crafttweaker.api.loot.modifiers.CommonLootModifiers;

println("BEGIN loot.zs");

loot.modifiers.register(
  "have_a_heart",
  LootConditionBuilder.createForSingle<LootTableId>(condition => { condition.withTableId(<resource:minecraft:chests/buried_treasure>); }),
  CommonLootModifiers.add(<item:minecraft:heart_of_the_sea>)
);

println("END loot.zs");
