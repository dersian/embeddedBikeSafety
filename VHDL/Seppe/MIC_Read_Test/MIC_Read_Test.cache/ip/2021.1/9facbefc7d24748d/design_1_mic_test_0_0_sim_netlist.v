// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.1 (lin64) Build 3247384 Thu Jun 10 19:36:07 MDT 2021
// Date        : Wed Jun 14 17:14:09 2023
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
  wire o_mic;
  wire o_mic_clk;

  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_mic_test U0
       (.i_FPGAclk(i_FPGAclk),
        .i_mic(i_mic),
        .o_mic(o_mic),
        .o_mic_clk(o_mic_clk));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_mic_test
   (o_mic,
    o_mic_clk,
    i_FPGAclk,
    i_mic);
  output o_mic;
  output o_mic_clk;
  input i_FPGAclk;
  input i_mic;

  wire [7:0]PDMclk_ctr;
  wire \PDMclk_ctr[6]_i_2_n_0 ;
  wire \PDMclk_ctr[7]_i_2_n_0 ;
  wire \PDMclk_ctr_reg_n_0_[0] ;
  wire \PDMclk_ctr_reg_n_0_[1] ;
  wire \PDMclk_ctr_reg_n_0_[2] ;
  wire \PDMclk_ctr_reg_n_0_[3] ;
  wire \PDMclk_ctr_reg_n_0_[4] ;
  wire \PDMclk_ctr_reg_n_0_[5] ;
  wire \PDMclk_ctr_reg_n_0_[6] ;
  wire \PDMclk_ctr_reg_n_0_[7] ;
  wire PDMclk_i_1_n_0;
  wire PDMclk_i_2_n_0;
  wire \delay_ctr[0]_i_1_n_0 ;
  wire \delay_ctr[1]_i_1_n_0 ;
  wire \delay_ctr[2]_i_1_n_0 ;
  wire \delay_ctr[3]_i_1_n_0 ;
  wire \delay_ctr[3]_i_2_n_0 ;
  wire \delay_ctr_reg_n_0_[0] ;
  wire \delay_ctr_reg_n_0_[1] ;
  wire \delay_ctr_reg_n_0_[2] ;
  wire \delay_ctr_reg_n_0_[3] ;
  wire i_FPGAclk;
  wire i_mic;
  wire o_mic;
  wire o_mic_clk;
  wire temp_mic_i_1_n_0;

  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \PDMclk_ctr[0]_i_1 
       (.I0(\PDMclk_ctr_reg_n_0_[0] ),
        .O(PDMclk_ctr[0]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \PDMclk_ctr[1]_i_1 
       (.I0(\PDMclk_ctr_reg_n_0_[0] ),
        .I1(\PDMclk_ctr_reg_n_0_[1] ),
        .O(PDMclk_ctr[1]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h0FFFB000)) 
    \PDMclk_ctr[2]_i_1 
       (.I0(PDMclk_i_2_n_0),
        .I1(\PDMclk_ctr_reg_n_0_[3] ),
        .I2(\PDMclk_ctr_reg_n_0_[1] ),
        .I3(\PDMclk_ctr_reg_n_0_[0] ),
        .I4(\PDMclk_ctr_reg_n_0_[2] ),
        .O(PDMclk_ctr[2]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h4AF0F0F0)) 
    \PDMclk_ctr[3]_i_1 
       (.I0(\PDMclk_ctr_reg_n_0_[2] ),
        .I1(PDMclk_i_2_n_0),
        .I2(\PDMclk_ctr_reg_n_0_[3] ),
        .I3(\PDMclk_ctr_reg_n_0_[0] ),
        .I4(\PDMclk_ctr_reg_n_0_[1] ),
        .O(PDMclk_ctr[3]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \PDMclk_ctr[4]_i_1 
       (.I0(\PDMclk_ctr_reg_n_0_[2] ),
        .I1(\PDMclk_ctr_reg_n_0_[1] ),
        .I2(\PDMclk_ctr_reg_n_0_[0] ),
        .I3(\PDMclk_ctr_reg_n_0_[3] ),
        .I4(\PDMclk_ctr_reg_n_0_[4] ),
        .O(PDMclk_ctr[4]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \PDMclk_ctr[5]_i_1 
       (.I0(\PDMclk_ctr_reg_n_0_[4] ),
        .I1(\PDMclk_ctr_reg_n_0_[3] ),
        .I2(\PDMclk_ctr_reg_n_0_[0] ),
        .I3(\PDMclk_ctr_reg_n_0_[1] ),
        .I4(\PDMclk_ctr_reg_n_0_[2] ),
        .I5(\PDMclk_ctr_reg_n_0_[5] ),
        .O(PDMclk_ctr[5]));
  LUT6 #(
    .INIT(64'hF7FFFFFF08000000)) 
    \PDMclk_ctr[6]_i_1 
       (.I0(\PDMclk_ctr_reg_n_0_[5] ),
        .I1(\PDMclk_ctr_reg_n_0_[2] ),
        .I2(\PDMclk_ctr[6]_i_2_n_0 ),
        .I3(\PDMclk_ctr_reg_n_0_[3] ),
        .I4(\PDMclk_ctr_reg_n_0_[4] ),
        .I5(\PDMclk_ctr_reg_n_0_[6] ),
        .O(PDMclk_ctr[6]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \PDMclk_ctr[6]_i_2 
       (.I0(\PDMclk_ctr_reg_n_0_[0] ),
        .I1(\PDMclk_ctr_reg_n_0_[1] ),
        .O(\PDMclk_ctr[6]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hD2)) 
    \PDMclk_ctr[7]_i_1 
       (.I0(\PDMclk_ctr_reg_n_0_[6] ),
        .I1(\PDMclk_ctr[7]_i_2_n_0 ),
        .I2(\PDMclk_ctr_reg_n_0_[7] ),
        .O(PDMclk_ctr[7]));
  LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
    \PDMclk_ctr[7]_i_2 
       (.I0(\PDMclk_ctr_reg_n_0_[4] ),
        .I1(\PDMclk_ctr_reg_n_0_[3] ),
        .I2(\PDMclk_ctr_reg_n_0_[0] ),
        .I3(\PDMclk_ctr_reg_n_0_[1] ),
        .I4(\PDMclk_ctr_reg_n_0_[2] ),
        .I5(\PDMclk_ctr_reg_n_0_[5] ),
        .O(\PDMclk_ctr[7]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \PDMclk_ctr_reg[0] 
       (.C(i_FPGAclk),
        .CE(1'b1),
        .D(PDMclk_ctr[0]),
        .Q(\PDMclk_ctr_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PDMclk_ctr_reg[1] 
       (.C(i_FPGAclk),
        .CE(1'b1),
        .D(PDMclk_ctr[1]),
        .Q(\PDMclk_ctr_reg_n_0_[1] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PDMclk_ctr_reg[2] 
       (.C(i_FPGAclk),
        .CE(1'b1),
        .D(PDMclk_ctr[2]),
        .Q(\PDMclk_ctr_reg_n_0_[2] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PDMclk_ctr_reg[3] 
       (.C(i_FPGAclk),
        .CE(1'b1),
        .D(PDMclk_ctr[3]),
        .Q(\PDMclk_ctr_reg_n_0_[3] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PDMclk_ctr_reg[4] 
       (.C(i_FPGAclk),
        .CE(1'b1),
        .D(PDMclk_ctr[4]),
        .Q(\PDMclk_ctr_reg_n_0_[4] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PDMclk_ctr_reg[5] 
       (.C(i_FPGAclk),
        .CE(1'b1),
        .D(PDMclk_ctr[5]),
        .Q(\PDMclk_ctr_reg_n_0_[5] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PDMclk_ctr_reg[6] 
       (.C(i_FPGAclk),
        .CE(1'b1),
        .D(PDMclk_ctr[6]),
        .Q(\PDMclk_ctr_reg_n_0_[6] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PDMclk_ctr_reg[7] 
       (.C(i_FPGAclk),
        .CE(1'b1),
        .D(PDMclk_ctr[7]),
        .Q(\PDMclk_ctr_reg_n_0_[7] ),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFFFFBFFF00004000)) 
    PDMclk_i_1
       (.I0(PDMclk_i_2_n_0),
        .I1(\PDMclk_ctr_reg_n_0_[3] ),
        .I2(\PDMclk_ctr_reg_n_0_[0] ),
        .I3(\PDMclk_ctr_reg_n_0_[1] ),
        .I4(\PDMclk_ctr_reg_n_0_[2] ),
        .I5(o_mic_clk),
        .O(PDMclk_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    PDMclk_i_2
       (.I0(\PDMclk_ctr_reg_n_0_[5] ),
        .I1(\PDMclk_ctr_reg_n_0_[4] ),
        .I2(\PDMclk_ctr_reg_n_0_[7] ),
        .I3(\PDMclk_ctr_reg_n_0_[6] ),
        .O(PDMclk_i_2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    PDMclk_reg
       (.C(i_FPGAclk),
        .CE(1'b1),
        .D(PDMclk_i_1_n_0),
        .Q(o_mic_clk),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \delay_ctr[0]_i_1 
       (.I0(\delay_ctr_reg_n_0_[0] ),
        .O(\delay_ctr[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \delay_ctr[1]_i_1 
       (.I0(\delay_ctr_reg_n_0_[0] ),
        .I1(\delay_ctr_reg_n_0_[1] ),
        .O(\delay_ctr[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \delay_ctr[2]_i_1 
       (.I0(\delay_ctr_reg_n_0_[1] ),
        .I1(\delay_ctr_reg_n_0_[0] ),
        .I2(\delay_ctr_reg_n_0_[2] ),
        .O(\delay_ctr[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h1000)) 
    \delay_ctr[3]_i_1 
       (.I0(\delay_ctr_reg_n_0_[2] ),
        .I1(\delay_ctr_reg_n_0_[3] ),
        .I2(\delay_ctr_reg_n_0_[0] ),
        .I3(\delay_ctr_reg_n_0_[1] ),
        .O(\delay_ctr[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \delay_ctr[3]_i_2 
       (.I0(\delay_ctr_reg_n_0_[0] ),
        .I1(\delay_ctr_reg_n_0_[1] ),
        .I2(\delay_ctr_reg_n_0_[2] ),
        .I3(\delay_ctr_reg_n_0_[3] ),
        .O(\delay_ctr[3]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \delay_ctr_reg[0] 
       (.C(i_FPGAclk),
        .CE(1'b1),
        .D(\delay_ctr[0]_i_1_n_0 ),
        .Q(\delay_ctr_reg_n_0_[0] ),
        .R(\delay_ctr[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \delay_ctr_reg[1] 
       (.C(i_FPGAclk),
        .CE(1'b1),
        .D(\delay_ctr[1]_i_1_n_0 ),
        .Q(\delay_ctr_reg_n_0_[1] ),
        .R(\delay_ctr[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \delay_ctr_reg[2] 
       (.C(i_FPGAclk),
        .CE(1'b1),
        .D(\delay_ctr[2]_i_1_n_0 ),
        .Q(\delay_ctr_reg_n_0_[2] ),
        .R(\delay_ctr[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \delay_ctr_reg[3] 
       (.C(i_FPGAclk),
        .CE(1'b1),
        .D(\delay_ctr[3]_i_2_n_0 ),
        .Q(\delay_ctr_reg_n_0_[3] ),
        .R(\delay_ctr[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFEFFFFFF02000000)) 
    temp_mic_i_1
       (.I0(i_mic),
        .I1(\delay_ctr_reg_n_0_[2] ),
        .I2(\delay_ctr_reg_n_0_[3] ),
        .I3(\delay_ctr_reg_n_0_[1] ),
        .I4(\delay_ctr_reg_n_0_[0] ),
        .I5(o_mic),
        .O(temp_mic_i_1_n_0));
  FDRE temp_mic_reg
       (.C(i_FPGAclk),
        .CE(1'b1),
        .D(temp_mic_i_1_n_0),
        .Q(o_mic),
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
