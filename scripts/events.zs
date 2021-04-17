
//import crafttweaker.api.blocks.MCBlockState;
//import crafttweaker.api.event.MCEvent;
//import crafttweaker.api.event.block.MCBlockBreakEvent;
//import crafttweaker.api.event.block.MCBlockEvent;
//import crafttweaker.api.event.entity.player.MCPlayerEvent;
//import crafttweaker.api.event.entity.player.interact.MCPlayerInteractEvent;
//import crafttweaker.api.event.entity.player.interact.MCRightClickBlockEvent;
import crafttweaker.api.events.CTEventManager;
//import crafttweaker.api.util.BlockPos;
//import crafttweaker.api.world.MCWorld;
//import crafttweaker.api.event.entity.MCEntityEvent;
//import crafttweaker.api.commands.custom.MCCommand;
import crafttweaker.api.util.text.MCTextComponent;
import crafttweaker.api.util.text.MCStyle;

println("BEGIN events.zs");

/*
CTEventManager.register<crafttweaker.api.event.block.MCBlockBreakEvent>(event=>{
        if event.state.hasTileEntity && event.state.commandString.startsWith('<blockstate:engineersdecor:') {
            event.world.destroyBlock(event.pos,true,event.player);
        }});
*/

CTEventManager.register<crafttweaker.api.event.entity.player.interact.MCRightClickBlockEvent>(event=>{
        val state = event.entity.getWorld().getBlockState(event.blockPos);
        if (    (state.commandString.startsWith('<blockstate:buildersaddition:cupboard_'))
            &&  (event.player.isSecondaryUseActive()) ) {

            val highlight = new MCStyle().setColor(<formatting:red>).setItalic(true);
            val lowlight = new MCStyle().setColor(<formatting:white>).setItalic(false);
            if (state.getPropertyValue("half").startsWith("upper")) {
                event.player.sendMessage(("If you pick up the top half of a cupboard, it will not be able to placed back down. Use the " as MCTextComponent).setStyle(lowlight).appendSibling(("/carryon clear" as MCTextComponent).setStyle(highlight)).appendSibling((" command to clear your hands. The cupboard will be voided." as MCTextComponent).setStyle(lowlight)));
            }
            // event.entity.getWorld().destroyBlock(event.blockPos,true,event.player);
        }});

println("END events.zs");
