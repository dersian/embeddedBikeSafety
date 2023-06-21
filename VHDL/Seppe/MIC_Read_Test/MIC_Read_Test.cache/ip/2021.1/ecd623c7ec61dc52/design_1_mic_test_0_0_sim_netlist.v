// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.1 (lin64) Build 3247384 Thu Jun 10 19:36:07 MDT 2021
// Date        : Fri Jun 16 09:39:16 2023
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
   (i_PDMclk,
    i_mic,
    o_mic);
  input i_PDMclk;
  input i_mic;
  output o_mic;

  wire i_PDMclk;
  wire i_mic;
  wire o_mic;

  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_mic_test U0
       (.i_PDMclk(i_PDMclk),
        .i_mic(i_mic),
        .o_mic(o_mic));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_mic_test
   (o_mic,
    i_PDMclk,
    i_mic);
  output o_mic;
  input i_PDMclk;
  input i_mic;

  wire \delay_ctr[3]_i_1_n_0 ;
  wire \delay_ctr_reg_n_0_[0] ;
  wire \delay_ctr_reg_n_0_[1] ;
  wire \delay_ctr_reg_n_0_[2] ;
  wire \delay_ctr_reg_n_0_[3] ;
  wire i_PDMclk;
  wire i_mic;
  wire o_mic;
  wire [3:0]plusOp;
  wire temp_mic_i_1_n_0;

  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \delay_ctr[0]_i_1 
       (.I0(\delay_ctr_reg_n_0_[0] ),
        .O(plusOp[0]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \delay_ctr[1]_i_1 
       (.I0(\delay_ctr_reg_n_0_[0] ),
        .I1(\delay_ctr_reg_n_0_[1] ),
        .O(plusOp[1]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \delay_ctr[2]_i_1 
       (.I0(\delay_ctr_reg_n_0_[0] ),
        .I1(\delay_ctr_reg_n_0_[1] ),
        .I2(\delay_ctr_reg_n_0_[2] ),
        .O(plusOp[2]));
  LUT4 #(
    .INIT(16'h0002)) 
    \delay_ctr[3]_i_1 
       (.I0(\delay_ctr_reg_n_0_[2] ),
        .I1(\delay_ctr_reg_n_0_[3] ),
        .I2(\delay_ctr_reg_n_0_[0] ),
        .I3(\delay_ctr_reg_n_0_[1] ),
        .O(\delay_ctr[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \delay_ctr[3]_i_2 
       (.I0(\delay_ctr_reg_n_0_[1] ),
        .I1(\delay_ctr_reg_n_0_[0] ),
        .I2(\delay_ctr_reg_n_0_[2] ),
        .I3(\delay_ctr_reg_n_0_[3] ),
        .O(plusOp[3]));
  FDRE #(
    .INIT(1'b0)) 
    \delay_ctr_reg[0] 
       (.C(i_PDMclk),
        .CE(1'b1),
        .D(plusOp[0]),
        .Q(\delay_ctr_reg_n_0_[0] ),
        .R(\delay_ctr[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \delay_ctr_reg[1] 
       (.C(i_PDMclk),
        .CE(1'b1),
        .D(plusOp[1]),
        .Q(\delay_ctr_reg_n_0_[1] ),
        .R(\delay_ctr[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \delay_ctr_reg[2] 
       (.C(i_PDMclk),
        .CE(1'b1),
        .D(plusOp[2]),
        .Q(\delay_ctr_reg_n_0_[2] ),
        .R(\delay_ctr[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \delay_ctr_reg[3] 
       (.C(i_PDMclk),
        .CE(1'b1),
        .D(plusOp[3]),
        .Q(\delay_ctr_reg_n_0_[3] ),
        .R(\delay_ctr[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFEFF00000200)) 
    temp_mic_i_1
       (.I0(i_mic),
        .I1(\delay_ctr_reg_n_0_[3] ),
        .I2(\delay_ctr_reg_n_0_[1] ),
        .I3(\delay_ctr_reg_n_0_[2] ),
        .I4(\delay_ctr_reg_n_0_[0] ),
        .I5(o_mic),
        .O(temp_mic_i_1_n_0));
  FDRE temp_mic_reg
       (.C(i_PDMclk),
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
