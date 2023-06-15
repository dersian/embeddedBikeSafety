// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.1 (lin64) Build 3247384 Thu Jun 10 19:36:07 MDT 2021
// Date        : Wed Jun 14 16:19:09 2023
// Host        : indi-VM running 64-bit Ubuntu 20.04.1 LTS
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_mic_test_0_0_sim_netlist.v
// Design      : design_1_mic_test_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_mic_test_0_0,mic_test,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* ip_definition_source = "module_ref" *) 
(* x_core_info = "mic_test,Vivado 2021.1" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (i_FPGAclk,
    i_mic,
    o_mic_clk,
    o_mic);
  input i_FPGAclk;
  input i_mic;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 o_mic_clk CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME o_mic_clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_mic_test_0_0_o_mic_clk, INSERT_VIP 0" *) output o_mic_clk;
  output o_mic;

  wire i_FPGAclk;
  wire i_mic;
  wire o_mic_clk;

  assign o_mic = i_mic;
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_mic_test U0
       (.i_FPGAclk(i_FPGAclk),
        .o_mic_clk(o_mic_clk));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_mic_test
   (o_mic_clk,
    i_FPGAclk);
  output o_mic_clk;
  input i_FPGAclk;

  wire [7:0]PDMclk_counter;
  wire \PDMclk_counter[3]_i_2_n_0 ;
  wire \PDMclk_counter[7]_i_2_n_0 ;
  wire \PDMclk_counter_reg_n_0_[0] ;
  wire \PDMclk_counter_reg_n_0_[1] ;
  wire \PDMclk_counter_reg_n_0_[2] ;
  wire \PDMclk_counter_reg_n_0_[3] ;
  wire \PDMclk_counter_reg_n_0_[4] ;
  wire \PDMclk_counter_reg_n_0_[5] ;
  wire \PDMclk_counter_reg_n_0_[6] ;
  wire \PDMclk_counter_reg_n_0_[7] ;
  wire PDMclk_i_1_n_0;
  wire PDMclk_i_2_n_0;
  wire i_FPGAclk;
  wire o_mic_clk;

  LUT1 #(
    .INIT(2'h1)) 
    \PDMclk_counter[0]_i_1 
       (.I0(\PDMclk_counter_reg_n_0_[0] ),
        .O(PDMclk_counter[0]));
  LUT6 #(
    .INIT(64'h55AA55AA55AA55A8)) 
    \PDMclk_counter[1]_i_1 
       (.I0(\PDMclk_counter_reg_n_0_[0] ),
        .I1(PDMclk_i_2_n_0),
        .I2(\PDMclk_counter_reg_n_0_[6] ),
        .I3(\PDMclk_counter_reg_n_0_[1] ),
        .I4(\PDMclk_counter_reg_n_0_[7] ),
        .I5(\PDMclk_counter_reg_n_0_[5] ),
        .O(PDMclk_counter[1]));
  LUT6 #(
    .INIT(64'h00FFDFFFFF000000)) 
    \PDMclk_counter[2]_i_1 
       (.I0(\PDMclk_counter_reg_n_0_[3] ),
        .I1(\PDMclk_counter_reg_n_0_[4] ),
        .I2(\PDMclk_counter[3]_i_2_n_0 ),
        .I3(\PDMclk_counter_reg_n_0_[0] ),
        .I4(\PDMclk_counter_reg_n_0_[1] ),
        .I5(\PDMclk_counter_reg_n_0_[2] ),
        .O(PDMclk_counter[2]));
  LUT6 #(
    .INIT(64'h7F803F807F807F80)) 
    \PDMclk_counter[3]_i_1 
       (.I0(\PDMclk_counter_reg_n_0_[1] ),
        .I1(\PDMclk_counter_reg_n_0_[2] ),
        .I2(\PDMclk_counter_reg_n_0_[0] ),
        .I3(\PDMclk_counter_reg_n_0_[3] ),
        .I4(\PDMclk_counter_reg_n_0_[4] ),
        .I5(\PDMclk_counter[3]_i_2_n_0 ),
        .O(PDMclk_counter[3]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    \PDMclk_counter[3]_i_2 
       (.I0(\PDMclk_counter_reg_n_0_[6] ),
        .I1(\PDMclk_counter_reg_n_0_[1] ),
        .I2(\PDMclk_counter_reg_n_0_[7] ),
        .I3(\PDMclk_counter_reg_n_0_[5] ),
        .O(\PDMclk_counter[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \PDMclk_counter[4]_i_1 
       (.I0(\PDMclk_counter_reg_n_0_[4] ),
        .I1(\PDMclk_counter_reg_n_0_[2] ),
        .I2(\PDMclk_counter_reg_n_0_[1] ),
        .I3(\PDMclk_counter_reg_n_0_[0] ),
        .I4(\PDMclk_counter_reg_n_0_[3] ),
        .O(PDMclk_counter[4]));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \PDMclk_counter[5]_i_1 
       (.I0(\PDMclk_counter_reg_n_0_[5] ),
        .I1(\PDMclk_counter_reg_n_0_[3] ),
        .I2(\PDMclk_counter_reg_n_0_[0] ),
        .I3(\PDMclk_counter_reg_n_0_[1] ),
        .I4(\PDMclk_counter_reg_n_0_[2] ),
        .I5(\PDMclk_counter_reg_n_0_[4] ),
        .O(PDMclk_counter[5]));
  LUT2 #(
    .INIT(4'h6)) 
    \PDMclk_counter[6]_i_1 
       (.I0(\PDMclk_counter_reg_n_0_[6] ),
        .I1(\PDMclk_counter[7]_i_2_n_0 ),
        .O(PDMclk_counter[6]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \PDMclk_counter[7]_i_1 
       (.I0(\PDMclk_counter_reg_n_0_[7] ),
        .I1(\PDMclk_counter[7]_i_2_n_0 ),
        .I2(\PDMclk_counter_reg_n_0_[6] ),
        .O(PDMclk_counter[7]));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \PDMclk_counter[7]_i_2 
       (.I0(\PDMclk_counter_reg_n_0_[5] ),
        .I1(\PDMclk_counter_reg_n_0_[3] ),
        .I2(\PDMclk_counter_reg_n_0_[0] ),
        .I3(\PDMclk_counter_reg_n_0_[1] ),
        .I4(\PDMclk_counter_reg_n_0_[2] ),
        .I5(\PDMclk_counter_reg_n_0_[4] ),
        .O(\PDMclk_counter[7]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \PDMclk_counter_reg[0] 
       (.C(i_FPGAclk),
        .CE(1'b1),
        .D(PDMclk_counter[0]),
        .Q(\PDMclk_counter_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PDMclk_counter_reg[1] 
       (.C(i_FPGAclk),
        .CE(1'b1),
        .D(PDMclk_counter[1]),
        .Q(\PDMclk_counter_reg_n_0_[1] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PDMclk_counter_reg[2] 
       (.C(i_FPGAclk),
        .CE(1'b1),
        .D(PDMclk_counter[2]),
        .Q(\PDMclk_counter_reg_n_0_[2] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PDMclk_counter_reg[3] 
       (.C(i_FPGAclk),
        .CE(1'b1),
        .D(PDMclk_counter[3]),
        .Q(\PDMclk_counter_reg_n_0_[3] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PDMclk_counter_reg[4] 
       (.C(i_FPGAclk),
        .CE(1'b1),
        .D(PDMclk_counter[4]),
        .Q(\PDMclk_counter_reg_n_0_[4] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PDMclk_counter_reg[5] 
       (.C(i_FPGAclk),
        .CE(1'b1),
        .D(PDMclk_counter[5]),
        .Q(\PDMclk_counter_reg_n_0_[5] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PDMclk_counter_reg[6] 
       (.C(i_FPGAclk),
        .CE(1'b1),
        .D(PDMclk_counter[6]),
        .Q(\PDMclk_counter_reg_n_0_[6] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PDMclk_counter_reg[7] 
       (.C(i_FPGAclk),
        .CE(1'b1),
        .D(PDMclk_counter[7]),
        .Q(\PDMclk_counter_reg_n_0_[7] ),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000001)) 
    PDMclk_i_1
       (.I0(PDMclk_i_2_n_0),
        .I1(\PDMclk_counter_reg_n_0_[6] ),
        .I2(\PDMclk_counter_reg_n_0_[1] ),
        .I3(\PDMclk_counter_reg_n_0_[7] ),
        .I4(\PDMclk_counter_reg_n_0_[5] ),
        .I5(o_mic_clk),
        .O(PDMclk_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'hFF7F)) 
    PDMclk_i_2
       (.I0(\PDMclk_counter_reg_n_0_[2] ),
        .I1(\PDMclk_counter_reg_n_0_[0] ),
        .I2(\PDMclk_counter_reg_n_0_[3] ),
        .I3(\PDMclk_counter_reg_n_0_[4] ),
        .O(PDMclk_i_2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    PDMclk_reg
       (.C(i_FPGAclk),
        .CE(1'b1),
        .D(PDMclk_i_1_n_0),
        .Q(o_mic_clk),
        .R(1'b0));
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
