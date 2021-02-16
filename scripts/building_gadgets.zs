
import crafttweaker.api.item.IIngredient;
import crafttweaker.api.item.IItemStack;

// iron/redstone/iron
// diamond/redstone/diamond
// iron/lapis/iron

// iron/redstone/iron
// diamond/lapis/diamond
// iron/lapis/iron

// iron/redstone/iron
// emerald/redstone/emerald
// iron/lapis/iron

// iron/redstone/iron
// pearl/redstone/pearl
// iron/lapis/iron

// gold/redstone/gold
// emerald/redstone/emerald
// gold/lapis/gold

val iron_plate  = <tag:items:forge:plates/iron>;
val steel_plate = <tag:items:forge:plates/steel>;
val elect_plate = <tag:items:forge:plates/electrum>;
val gold_plate  = <tag:items:forge:plates/gold>;
val transformer = <item:immersiveengineering:current_transformer>;
val lt_engineer = <item:immersiveengineering:light_engineering>;
val hv_engineer = <item:immersiveengineering:heavy_engineering>;
val rs_engineer = <item:immersiveengineering:rs_engineering>;
val capacitor   = <item:immersiveengineering:capacitor_lv>;
val treat_scaff = <item:immersiveengineering:treated_scaffold>;
val steel_scaff = <tag:items:immersiveengineering:scaffoldings/steel>;
val alum_scaff  = <tag:items:immersiveengineering:scaffoldings/aluminum>;
val frame       = <item:industrialforegoing:machine_frame_pity>;
val steel_dhead = <item:immersiveengineering:drillhead_steel>;
// val plastic     = <item:industrialforegoing:plastic>;

val building_gadget_recipes = {
    <item:buildinggadgets:gadget_building> : [
        [iron_plate,transformer,iron_plate],
        [lt_engineer,capacitor,lt_engineer],
        [treat_scaff,frame,treat_scaff] ],
    <item:buildinggadgets:gadget_exchanging>  : [
        [steel_plate,transformer,steel_plate],
        [hv_engineer,capacitor,hv_engineer],
        [steel_scaff,frame,steel_scaff] ],
    <item:buildinggadgets:gadget_copy_paste>  : [
        [elect_plate,transformer,elect_plate],
        [rs_engineer,capacitor,rs_engineer],
        [alum_scaff,frame,alum_scaff] ],
    <item:buildinggadgets:gadget_destruction> : [
        [steel_dhead,transformer,steel_dhead],
        [hv_engineer,capacitor,hv_engineer],
        [steel_scaff,frame,steel_scaff] ],
    <item:buildinggadgets:template_manager>   : [
        [gold_plate,elect_plate,gold_plate],
        [rs_engineer,capacitor,rs_engineer],
        [gold_plate,frame,gold_plate] ]
    } as IIngredient[][][IItemStack];

for gadget, matrix in building_gadget_recipes {
    craftingTable.removeRecipe(gadget);
    craftingTable.addShaped(gadget.translationKey,gadget, matrix, null);
}
