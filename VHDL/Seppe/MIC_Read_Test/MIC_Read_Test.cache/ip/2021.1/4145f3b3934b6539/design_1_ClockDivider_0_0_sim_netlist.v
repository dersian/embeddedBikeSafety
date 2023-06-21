// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.1 (lin64) Build 3247384 Thu Jun 10 19:36:07 MDT 2021
// Date        : Mon Jun 19 14:24:42 2023
// Host        : indi-VM running 64-bit Ubuntu 20.04.1 LTS
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_ClockDivider_0_0_sim_netlist.v
// Design      : design_1_ClockDivider_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ClockDivider
   (o_PDM_clk,
    i_FPGA_clk);
  output o_PDM_clk;
  input i_FPGA_clk;

  wire PDM_clk_i_1_n_0;
  wire PDM_clk_i_2_n_0;
  wire [7:0]PDM_ctr;
  wire \PDM_ctr[6]_i_2_n_0 ;
  wire \PDM_ctr[7]_i_2_n_0 ;
  wire \PDM_ctr_reg_n_0_[0] ;
  wire \PDM_ctr_reg_n_0_[1] ;
  wire \PDM_ctr_reg_n_0_[2] ;
  wire \PDM_ctr_reg_n_0_[3] ;
  wire \PDM_ctr_reg_n_0_[4] ;
  wire \PDM_ctr_reg_n_0_[5] ;
  wire \PDM_ctr_reg_n_0_[6] ;
  wire \PDM_ctr_reg_n_0_[7] ;
  wire i_FPGA_clk;
  wire o_PDM_clk;

  LUT6 #(
    .INIT(64'hFFFFBFFF00004000)) 
    PDM_clk_i_1
       (.I0(PDM_clk_i_2_n_0),
        .I1(\PDM_ctr_reg_n_0_[3] ),
        .I2(\PDM_ctr_reg_n_0_[0] ),
        .I3(\PDM_ctr_reg_n_0_[1] ),
        .I4(\PDM_ctr_reg_n_0_[2] ),
        .I5(o_PDM_clk),
        .O(PDM_clk_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    PDM_clk_i_2
       (.I0(\PDM_ctr_reg_n_0_[5] ),
        .I1(\PDM_ctr_reg_n_0_[4] ),
        .I2(\PDM_ctr_reg_n_0_[7] ),
        .I3(\PDM_ctr_reg_n_0_[6] ),
        .O(PDM_clk_i_2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    PDM_clk_reg
       (.C(i_FPGA_clk),
        .CE(1'b1),
        .D(PDM_clk_i_1_n_0),
        .Q(o_PDM_clk),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \PDM_ctr[0]_i_1 
       (.I0(\PDM_ctr_reg_n_0_[0] ),
        .O(PDM_ctr[0]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \PDM_ctr[1]_i_1 
       (.I0(\PDM_ctr_reg_n_0_[0] ),
        .I1(\PDM_ctr_reg_n_0_[1] ),
        .O(PDM_ctr[1]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h0FFFB000)) 
    \PDM_ctr[2]_i_1 
       (.I0(PDM_clk_i_2_n_0),
        .I1(\PDM_ctr_reg_n_0_[3] ),
        .I2(\PDM_ctr_reg_n_0_[1] ),
        .I3(\PDM_ctr_reg_n_0_[0] ),
        .I4(\PDM_ctr_reg_n_0_[2] ),
        .O(PDM_ctr[2]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h4AF0F0F0)) 
    \PDM_ctr[3]_i_1 
       (.I0(\PDM_ctr_reg_n_0_[2] ),
        .I1(PDM_clk_i_2_n_0),
        .I2(\PDM_ctr_reg_n_0_[3] ),
        .I3(\PDM_ctr_reg_n_0_[0] ),
        .I4(\PDM_ctr_reg_n_0_[1] ),
        .O(PDM_ctr[3]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \PDM_ctr[4]_i_1 
       (.I0(\PDM_ctr_reg_n_0_[2] ),
        .I1(\PDM_ctr_reg_n_0_[1] ),
        .I2(\PDM_ctr_reg_n_0_[0] ),
        .I3(\PDM_ctr_reg_n_0_[3] ),
        .I4(\PDM_ctr_reg_n_0_[4] ),
        .O(PDM_ctr[4]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \PDM_ctr[5]_i_1 
       (.I0(\PDM_ctr_reg_n_0_[4] ),
        .I1(\PDM_ctr_reg_n_0_[3] ),
        .I2(\PDM_ctr_reg_n_0_[0] ),
        .I3(\PDM_ctr_reg_n_0_[1] ),
        .I4(\PDM_ctr_reg_n_0_[2] ),
        .I5(\PDM_ctr_reg_n_0_[5] ),
        .O(PDM_ctr[5]));
  LUT6 #(
    .INIT(64'hF7FFFFFF08000000)) 
    \PDM_ctr[6]_i_1 
       (.I0(\PDM_ctr_reg_n_0_[5] ),
        .I1(\PDM_ctr_reg_n_0_[2] ),
        .I2(\PDM_ctr[6]_i_2_n_0 ),
        .I3(\PDM_ctr_reg_n_0_[3] ),
        .I4(\PDM_ctr_reg_n_0_[4] ),
        .I5(\PDM_ctr_reg_n_0_[6] ),
        .O(PDM_ctr[6]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \PDM_ctr[6]_i_2 
       (.I0(\PDM_ctr_reg_n_0_[0] ),
        .I1(\PDM_ctr_reg_n_0_[1] ),
        .O(\PDM_ctr[6]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hD2)) 
    \PDM_ctr[7]_i_1 
       (.I0(\PDM_ctr_reg_n_0_[6] ),
        .I1(\PDM_ctr[7]_i_2_n_0 ),
        .I2(\PDM_ctr_reg_n_0_[7] ),
        .O(PDM_ctr[7]));
  LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
    \PDM_ctr[7]_i_2 
       (.I0(\PDM_ctr_reg_n_0_[4] ),
        .I1(\PDM_ctr_reg_n_0_[3] ),
        .I2(\PDM_ctr_reg_n_0_[0] ),
        .I3(\PDM_ctr_reg_n_0_[1] ),
        .I4(\PDM_ctr_reg_n_0_[2] ),
        .I5(\PDM_ctr_reg_n_0_[5] ),
        .O(\PDM_ctr[7]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \PDM_ctr_reg[0] 
       (.C(i_FPGA_clk),
        .CE(1'b1),
        .D(PDM_ctr[0]),
        .Q(\PDM_ctr_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PDM_ctr_reg[1] 
       (.C(i_FPGA_clk),
        .CE(1'b1),
        .D(PDM_ctr[1]),
        .Q(\PDM_ctr_reg_n_0_[1] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PDM_ctr_reg[2] 
       (.C(i_FPGA_clk),
        .CE(1'b1),
        .D(PDM_ctr[2]),
        .Q(\PDM_ctr_reg_n_0_[2] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PDM_ctr_reg[3] 
       (.C(i_FPGA_clk),
        .CE(1'b1),
        .D(PDM_ctr[3]),
        .Q(\PDM_ctr_reg_n_0_[3] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PDM_ctr_reg[4] 
       (.C(i_FPGA_clk),
        .CE(1'b1),
        .D(PDM_ctr[4]),
        .Q(\PDM_ctr_reg_n_0_[4] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PDM_ctr_reg[5] 
       (.C(i_FPGA_clk),
        .CE(1'b1),
        .D(PDM_ctr[5]),
        .Q(\PDM_ctr_reg_n_0_[5] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PDM_ctr_reg[6] 
       (.C(i_FPGA_clk),
        .CE(1'b1),
        .D(PDM_ctr[6]),
        .Q(\PDM_ctr_reg_n_0_[6] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PDM_ctr_reg[7] 
       (.C(i_FPGA_clk),
        .CE(1'b1),
        .D(PDM_ctr[7]),
        .Q(\PDM_ctr_reg_n_0_[7] ),
        .R(1'b0));
endmodule

(* CHECK_LICENSE_TYPE = "design_1_ClockDivider_0_0,ClockDivider,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* ip_definition_source = "module_ref" *) 
(* x_core_info = "ClockDivider,Vivado 2021.1" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (i_FPGA_clk,
    o_PDM_clk);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 i_FPGA_clk CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME i_FPGA_clk, FREQ_HZ 55298913, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0" *) input i_FPGA_clk;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 o_PDM_clk CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME o_PDM_clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_ClockDivider_0_0_o_PDM_clk, INSERT_VIP 0" *) output o_PDM_clk;

  wire i_FPGA_clk;
  wire o_PDM_clk;

  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ClockDivider U0
       (.i_FPGA_clk(i_FPGA_clk),
        .o_PDM_clk(o_PDM_clk));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
