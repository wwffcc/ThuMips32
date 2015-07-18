
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name FlashAndRam32 -dir "C:/Users/lx/Desktop/CPU_works/FPGA/FlashAndRam32/planAhead_run_1" -part xc6slx100fgg676-3
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Users/lx/Desktop/CPU_works/FPGA/FlashAndRam32/flashAndram.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Users/lx/Desktop/CPU_works/FPGA/FlashAndRam32} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "flashAndram.ucf" [current_fileset -constrset]
add_files [list {flashAndram.ucf}] -fileset [get_property constrset [current_run]]
link_design
