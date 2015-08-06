
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name CPU_project -dir "C:/Users/lx/Desktop/CPU_works/FPGA/CPU_project/planAhead_run_3" -part xc6slx100fgg676-3
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Users/lx/Desktop/CPU_works/FPGA/CPU_project/CPU.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Users/lx/Desktop/CPU_works/FPGA/CPU_project} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "CPU.ucf" [current_fileset -constrset]
add_files [list {CPU.ucf}] -fileset [get_property constrset [current_run]]
link_design
