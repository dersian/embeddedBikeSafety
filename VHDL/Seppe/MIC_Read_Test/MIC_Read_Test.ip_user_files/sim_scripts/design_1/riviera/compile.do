vlib work
vlib riviera

vlib riviera/xilinx_vip
vlib riviera/xpm
vlib riviera/xil_defaultlib
vlib riviera/axi_infrastructure_v1_1_0
vlib riviera/axi_vip_v1_1_10
vlib riviera/processing_system7_vip_v1_0_12

vmap xilinx_vip riviera/xilinx_vip
vmap xpm riviera/xpm
vmap xil_defaultlib riviera/xil_defaultlib
vmap axi_infrastructure_v1_1_0 riviera/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_10 riviera/axi_vip_v1_1_10
vmap processing_system7_vip_v1_0_12 riviera/processing_system7_vip_v1_0_12

vlog -work xilinx_vip  -sv2k12 "+incdir+/tools/Xilinx/Vivado/2021.1/data/xilinx_vip/include" \
"/tools/Xilinx/Vivado/2021.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/tools/Xilinx/Vivado/2021.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/tools/Xilinx/Vivado/2021.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/tools/Xilinx/Vivado/2021.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/tools/Xilinx/Vivado/2021.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/tools/Xilinx/Vivado/2021.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/tools/Xilinx/Vivado/2021.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/tools/Xilinx/Vivado/2021.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/tools/Xilinx/Vivado/2021.1/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm  -sv2k12 "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/f42d/hdl" "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/6dcf" "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/1b7e/hdl/verilog" "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/122e/hdl/verilog" "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/b205/hdl/verilog" "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/c968/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2021.1/data/xilinx_vip/include" \
"/tools/Xilinx/Vivado/2021.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/tools/Xilinx/Vivado/2021.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"/tools/Xilinx/Vivado/2021.1/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/ip/design_1_ila_0_0/sim/design_1_ila_0_0.vhd" \

vlog -work axi_infrastructure_v1_1_0  -v2k5 "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/f42d/hdl" "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/6dcf" "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/1b7e/hdl/verilog" "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/122e/hdl/verilog" "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/b205/hdl/verilog" "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/c968/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2021.1/data/xilinx_vip/include" \
"../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_10  -sv2k12 "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/f42d/hdl" "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/6dcf" "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/1b7e/hdl/verilog" "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/122e/hdl/verilog" "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/b205/hdl/verilog" "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/c968/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2021.1/data/xilinx_vip/include" \
"../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/0980/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work processing_system7_vip_v1_0_12  -sv2k12 "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/f42d/hdl" "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/6dcf" "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/1b7e/hdl/verilog" "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/122e/hdl/verilog" "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/b205/hdl/verilog" "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/c968/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2021.1/data/xilinx_vip/include" \
"../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/f42d/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/f42d/hdl" "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/6dcf" "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/1b7e/hdl/verilog" "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/122e/hdl/verilog" "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/b205/hdl/verilog" "+incdir+../../../../MIC_Read_Test.gen/sources_1/bd/design_1/ipshared/c968/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2021.1/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_processing_system7_0_0/sim/design_1_processing_system7_0_0.v" \
"../../../bd/design_1/ip/design_1_clk_wiz_0_1/design_1_clk_wiz_0_1_clk_wiz.v" \
"../../../bd/design_1/ip/design_1_clk_wiz_0_1/design_1_clk_wiz_0_1.v" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/ip/design_1_mic_test_0_0/sim/design_1_mic_test_0_0.vhd" \
"../../../bd/design_1/ip/design_1_ClockDivider_0_0/sim/design_1_ClockDivider_0_0.vhd" \
"../../../bd/design_1/sim/design_1.vhd" \

vlog -work xil_defaultlib \
"glbl.v"
