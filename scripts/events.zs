
//import crafttweaker.api.blocks.MCBlockState;
//import crafttweaker.api.commands.custom.MCCommand;
//import crafttweaker.api.event.MCEvent;
//import crafttweaker.api.event.block.MCBlockBreakEvent;
//import crafttweaker.api.event.block.MCBlockEvent;
//import crafttweaker.api.event.entity.MCEntityEvent;
//import crafttweaker.api.event.entity.player.MCPlayerEvent;
//import crafttweaker.api.event.entity.player.interact.MCPlayerInteractEvent;
//import crafttweaker.api.event.entity.player.interact.MCRightClickBlockEvent;
//import crafttweaker.api.util.BlockPos;
//import crafttweaker.api.world.MCWorld;
//import crafttweaker.api.event.entity.player.interact.MCPlayerInteractEvent;
//import crafttweaker.api.events.CTEventManager;
//import crafttweaker.api.util.text.MCStyle;
//import crafttweaker.api.util.text.MCTextComponent;
//import crafttweaker.api.item.IItemStack;

println("BEGIN events.zs");

/*
CTEventManager.register<crafttweaker.api.event.block.MCBlockBreakEvent>(event=>{
        if event.state.hasTileEntity && event.state.commandString.startsWith('<blockstate:engineersdecor:') {
            event.world.destroyBlock(event.pos,true,event.player);
        }});
*//*


*/
/*
CTEventManager.register<crafttweaker.api.event.entity.player.interact.MCRightClickBlockEvent>(event=>{
        val state = event.entity.getWorld().getBlockState(event.blockPos);
        if (    (state.commandString.startsWith('<blockstate:buildersaddition:cupboard_'))
            &&  (event.player.isSecondaryUseActive()) ) {

            val highlight = new MCStyle().setColor(<formatting:red>).setItalic(true);
            val lowlight = new MCStyle().setColor(<formatting:white>).setItalic(false);
            if (state.getPropertyValue("half").startsWith("upper")) {
                event.player.sendMessage(("If you pick up the top half of a cupboard, it will not be able to placed back down. Use the " as MCTextComponent).setStyle(lowlight).appendSibling(("/carryon clear" as MCTextComponent).setStyle(highlight)).appendSibling((" command to clear your hands. The cupboard will be voided." as MCTextComponent).setStyle(lowlight)));
            }
            // event.eentity.getWorld().destroyBlock(event.blockPos,true,event.player);
        }});
*/

/*
CTEventManager.register<crafttweaker.api.event.entity.player.interact.MCPlayerInteractEvent>(event=>{
        if (!event.itemStack.empty) {
            val state = event.entity.getWorld().getBlockState(event.blockPos);
            var item = event.itemStack;
            // println(state.commandString);
            if (state.commandString.startsWith('<blockstate:charm:woodcutter')) {
                val isAxe = item in <tag:items:minecraft:axes>;
                if (item.registryName.toString() == "tetra:modular_double") {
                    val data = item.getOrCreate.asMap();
                    isAxe = (   ("double/basic_axe_left_material" in data)
                            ||  ("double/basic_axe_right_material" in data)
                            ||  ("double/adze_left_material" in data)
                            ||  ("double/adze_right_material" in data) );
                }
                if (isAxe) {
                    event.entity.getWorld().destroyBlock(event.blockPos,true,event.player);
                    val italic = new MCStyle().setItalic(true);
                    val not_italic = new MCStyle().setItalic(false);
                    event.player.sendMessage((("Hey, watch it with that "+item.displayName+"!") as MCTextComponent).setStyle(italic));
                }
            }
        }
    });
*/

println("END events.zs");
