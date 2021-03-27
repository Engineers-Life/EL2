
println("BEGIN jei.zs");

// Supplimentaries
mods.jei.JEI.addInfo(<item:supplementaries:planter>, ["Used for growing crops without a water source block.", "Now you can grow them even in the nether and you won't have to worry about animals trampling your crops!"]);
mods.jei.JEI.addInfo(<item:supplementaries:faucet>, ["When turned on, it starts spilling on the ground the inventory of up to two blocks behind it. If you place it in front of a water block (cauldron, water/waterlogged), it will start dripping water particles.", "You can use it to pour liquids to and from jars. Since it can extract items from the side of a block it enables some sort of automation not possible with vanilla.", "It will also interact with other blocks like hives and concrete powder. Its water color will depend on what's behind it."]);
mods.jei.JEI.addInfo(<item:supplementaries:jar>, ["Stores 4 buckets or 12 bottles of any vanilla liquids (like honey, milk, lava, potions, soups, dragon beath or xp) as well as fireflies. It functions as a shulker box for liquids or a rudimentary tank. You can now also store cookies and fish! Not compatible with the forge fluid system or with other fluid mods, meant to complement vanilla only."]);
mods.jei.JEI.addInfo(<item:supplementaries:wind_vane>, ["Emits a redstone signal, depending on the weather. The worse the weather, the stronger the signal."]);
mods.jei.JEI.addInfo(<item:supplementaries:pedestal>, ["Place an item on top to have it displayed. Stacking multiple pedestals will turn them into a pillar."]);
mods.jei.JEI.addInfo(<item:supplementaries:redstone_illuminator>, ["Light source that can be switched off with a redstone signal"]);
mods.jei.JEI.addInfo(<item:supplementaries:crank>, ["Outputs a redstone signal that gets stronger the more the crank is rotated."]);
mods.jei.JEI.addInfo(<item:supplementaries:piston_launcher>, ["Launches any entity on top of it when it is given a redstone signal."]);
mods.jei.JEI.addInfo(<item:supplementaries:turn_table>, ["When powered, will rotate any item/entity on top of it."]);
mods.jei.JEI.addInfo(<item:supplementaries:clock_block>, ["Right click on the block to get the time in hours. You are able to sleep at 18:00 and Dawn is at 06:00"]);
mods.jei.JEI.addInfo(<item:supplementaries:bellows>, ["When powered, will blow entities or items in front of it in the direction it is facing."]);
mods.jei.JEI.addInfo(<item:supplementaries:cog_block>, ["Transmits redstone power, just like redstone dust, but connects on all sides.","This making vertical redstone easier and looks cooler too."]);
mods.jei.JEI.addInfo(<item:supplementaries:safe>, ["Extremely hard block that functions as a chest. Retains inventory when broken."]);
mods.jei.JEI.addInfo(<item:supplementaries:hourglass>, ["Place sand in it and it will provide a redstone signal until the sand runs out. Flip and repeat."]);

// No Tree Punching
mods.jei.JEI.addInfo(<item:notreepunching:flint_shard>, ["Used for making early game tools." , "Once you have obtained flint, you can right click against stone of any kind to attempt to break it into shards."]);
mods.jei.JEI.addInfo(<item:notreepunching:clay_tool>, ["Use this tool on blocks of clay placed in the world to obtain items that can be smelted into useful tools. To progress to other items, continue to right click with the tool."]);
mods.jei.JEI.addInfo(<item:notreepunching:clay_large_vessel>, ["Shape a Clay Block placed in the world with the Clay Tool to obtain this vessel, which can then be smelted into a Ceramic Large Vessel."]);
mods.jei.JEI.addInfo(<item:notreepunching:ceramic_large_vessel>, ["Can be placed in the world and used similarly to a chest. However it retains it's inventory when picked up."]);
mods.jei.JEI.addInfo(<item:notreepunching:clay_small_vessel>, ["Shape a Clay Block placed in the world with the Clay Tool to obtain this vessel, which can then be smelted into a Ceramic Small Vessel."]);
mods.jei.JEI.addInfo(<item:notreepunching:ceramic_small_vessel>, ["This vessel acts as an inventory expansion, allowing you to store 9 items in a single spot. Cannot be placed in other Ceramic Vessels but can be placed in chests."]);
mods.jei.JEI.addInfo(<item:notreepunching:clay_bucket>, ["Shape a Clay Block placed in the world with the Clay Tool to obtain this vessel, which can then be smelted into a Ceramic Bucket."]);
mods.jei.JEI.addInfo(<item:notreepunching:ceramic_bucket>, ["A ceramic bucket to use early game until iron is found. Cannot stack empty buckets"]);
mods.jei.JEI.addInfo(<item:minecraft:campfire>, ["To start a campfire you need fire starter. Throw (Q) the following items on the ground, in the space where you want to create the campfire:", "- One wooden fuel item (any log or plank)", "- Three pieces of kindling (sticks, saplings, leaves, or string). Then, right click and hold the fire starter pointing at the pile of items. Smoke particles will appear, and after a short while, a campfire will appear and the items will be consumed."]);

mods.jei.JEI.addInfo(<item:minecraft:firework_rocket>, ["Fireworks are still enabled, though their recipes are not shown in JEI due to their complex nature.","A single piece of paper can be combined with up to 3 gunpowder (to change flight duration) and up to 5 firework stars. Shapeless recipe."]);

<item:backpacker:rucksack>.addShiftTooltip("You can access it with keybinding ('B' by default)");

// Industrial Foregoing
mods.jei.JEI.hideCategory("industrialforegoing:mycelial_crimed");
mods.jei.JEI.hideCategory("industrialforegoing:mycelial_culinary");
mods.jei.JEI.hideCategory("industrialforegoing:mycelial_death");
mods.jei.JEI.hideCategory("industrialforegoing:mycelial_disenchantment");
mods.jei.JEI.hideCategory("industrialforegoing:mycelial_ender");
mods.jei.JEI.hideCategory("industrialforegoing:mycelial_explosive");
mods.jei.JEI.hideCategory("industrialforegoing:mycelial_frosty");
mods.jei.JEI.hideCategory("industrialforegoing:mycelial_furnace");
mods.jei.JEI.hideCategory("industrialforegoing:mycelial_halitosis");
mods.jei.JEI.hideCategory("industrialforegoing:mycelial_magma");
mods.jei.JEI.hideCategory("industrialforegoing:mycelial_meatallurgic");
mods.jei.JEI.hideCategory("industrialforegoing:mycelial_netherstar");
mods.jei.JEI.hideCategory("industrialforegoing:mycelial_pink");
mods.jei.JEI.hideCategory("industrialforegoing:mycelial_potion");
mods.jei.JEI.hideCategory("industrialforegoing:mycelial_slimey");
mods.jei.JEI.hideCategory("industrialforegoing:bioreactor");

println ("END jei.zs");
