
if { [info exist ::env(MAGIC_EXT_USE_GDS)] && $::env(MAGIC_EXT_USE_GDS) } {
	gds read $::env(CURRENT_GDS)
} else {
	lef read /home/emre/ASIC/pdk/sky130A/libs.ref/sky130_fd_sc_hd/techlef/sky130_fd_sc_hd.tlef
	if {  [info exist ::env(EXTRA_LEFS)] } {
		set lefs_in $::env(EXTRA_LEFS)
		foreach lef_file $lefs_in {
			lef read $lef_file
		}
	}
	def read /openlane/designs/PrimitiveCalculator/runs/RUN_2022.05.04_12.01.04/results/routing/PrimitiveCalculator.def
}
load PrimitiveCalculator -dereference
cd /openlane/designs/PrimitiveCalculator/runs/RUN_2022.05.04_12.01.04/results/finishing/
extract do local
extract no capacitance
extract no coupling
extract no resistance
extract no adjust
if { ! 0 } {
	extract unique
}
# extract warn all
extract

ext2spice lvs
ext2spice -o /openlane/designs/PrimitiveCalculator/runs/RUN_2022.05.04_12.01.04/results/finishing/PrimitiveCalculator.spice PrimitiveCalculator.ext
feedback save /openlane/designs/PrimitiveCalculator/runs/RUN_2022.05.04_12.01.04/logs/finishing/28-ext2spice.feedback.txt
# exec cp PrimitiveCalculator.spice /openlane/designs/PrimitiveCalculator/runs/RUN_2022.05.04_12.01.04/results/finishing/PrimitiveCalculator.spice

