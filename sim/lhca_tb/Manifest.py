action = "simulation"
sim_tool = "modelsim"
sim_top = "lhca_tb"

sim_post_cmd = "vsim -novopt -do ../vsim.do -c lhca_tb"

modules = {
  "local" : [ "../../test/" ],
}
