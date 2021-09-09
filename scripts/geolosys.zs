
val scriptName="geolosys.zs";
println("BEGIN "+scriptName);

<recipetype:immersiveengineering:blast_furnace_fuel>.addFuel(
        scriptName+".lignite_coal_coke_as_blast_furnace_fuel",<item:geolosys:lignite_coal_coke>,<item:geolosys:lignite_coal_coke>.burnTime*6/16);
<recipetype:immersiveengineering:blast_furnace_fuel>.addFuel(
        scriptName+".bituminous_coal_coke_as_blast_furnace_fuel",<item:geolosys:bituminous_coal_coke>,<item:geolosys:bituminous_coal_coke>.burnTime*6/16);

println("END "+scriptName);
