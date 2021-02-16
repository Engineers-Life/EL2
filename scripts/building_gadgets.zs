
import crafttweaker.api.item.IIngredient;
import crafttweaker.api.item.IItemStack;
import crafttweaker.api.data.IData;

val iron_plate  = <tag:items:forge:plates/iron>;
val steel_plate = <tag:items:forge:plates/steel>;
val elect_plate = <tag:items:forge:plates/electrum>;
val gold_plate  = <tag:items:forge:plates/gold>;
val transformer = <item:immersiveengineering:current_transformer>;
val lt_engineer = <item:immersiveengineering:light_engineering>;
val hv_engineer = <item:immersiveengineering:heavy_engineering>;
val rs_engineer = <item:immersiveengineering:rs_engineering>;
val capacitor   = <item:immersiveengineering:capacitor_lv>;
val circutboard = <item:immersiveengineering:circuit_board>;
val treat_scaff = <item:immersiveengineering:treated_scaffold>;
val steel_scaff = <tag:items:immersiveengineering:scaffoldings/steel>;
val alum_scaff  = <tag:items:immersiveengineering:scaffoldings/aluminum>;
val frame       = <item:industrialforegoing:machine_frame_pity>;
val steel_dhead = <item:immersiveengineering:drillhead_steel>;
// val plastic     = <item:industrialforegoing:plastic>;

// <item:immersiveengineering:capacitor_lv>.withTag({sideConfig_0: 0 as int, ifluxEnergy: 4608 as int, sideConfig_1: 1 as int, sideConfig_2: 0 as int, sideConfig_3: 0 as int, sideConfig_4: 0 as int, sideConfig_5: 0 as int})
// <item:buildinggadgets:gadget_building>.withTag({state: {serializer: "buildinggadgets:dummy_serializer" as string, state: {Name: "minecraft:air" as string}, data: {}}, energy: 2304 as int})

var convertPower as function(usualOut as IItemStack, inputs as IItemStack[][]) as IItemStack = (usualOut, inputs) => {
    val in_center = inputs[1][1];
    if (in_center.hasTag) {
        val cap_data = in_center.tag.asMap();
        val flux = cap_data["ifluxEnergy"].asNumber().getInt();
        if (flux > 0) {
            return usualOut.withTag({energy: flux as int});
        }
    }
    return usualOut;
};

val building_gadget_recipes = {
    <item:buildinggadgets:gadget_building> : [
        [iron_plate,transformer,iron_plate],
        [lt_engineer,capacitor,lt_engineer],
        [treat_scaff,circutboard,treat_scaff] ],
    <item:buildinggadgets:gadget_exchanging>  : [
        [steel_plate,transformer,steel_plate],
        [hv_engineer,capacitor,hv_engineer],
        [steel_scaff,circutboard,steel_scaff] ],
    <item:buildinggadgets:gadget_copy_paste>  : [
        [elect_plate,transformer,elect_plate],
        [rs_engineer,capacitor,rs_engineer],
        [alum_scaff,circutboard,alum_scaff] ],
    <item:buildinggadgets:gadget_destruction> : [
        [steel_dhead,transformer,steel_dhead],
        [hv_engineer,capacitor,hv_engineer],
        [steel_scaff,circutboard,steel_scaff] ],
    <item:buildinggadgets:template_manager>   : [
        [gold_plate,elect_plate,gold_plate],
        [rs_engineer,frame,rs_engineer],
        [gold_plate,circutboard,gold_plate] ]
    } as IIngredient[][][IItemStack];

for gadget, matrix in building_gadget_recipes {
    craftingTable.removeRecipe(gadget);
    craftingTable.addShaped(gadget.translationKey,gadget, matrix, convertPower);
}
