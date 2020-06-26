action = "simulation"
sim_tool = "modelsim"
sim_top = "xorshift_tb"

sim_post_cmd = "vsim -novopt -do ../vsim.do -c xorshift_tb"

modules = {
  "local" : [ "../../test/" ],
}
