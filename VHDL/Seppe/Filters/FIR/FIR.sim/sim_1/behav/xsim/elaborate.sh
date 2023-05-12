#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2021.1 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Tue Apr 11 18:54:11 CEST 2023
# SW Build 3247384 on Thu Jun 10 19:36:07 MDT 2021
#
# IP Build 3246043 on Fri Jun 11 00:30:35 MDT 2021
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# elaborate design
echo "xelab -wto 76591b64dc0440a4a73f755e9ae45910 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L xbip_utils_v3_0_10 -L axi_utils_v2_0_6 -L fir_compiler_v7_2_16 -L secureip -L xpm --snapshot mainTop_tb_behav xil_defaultlib.mainTop_tb -log elaborate.log"
xelab -wto 76591b64dc0440a4a73f755e9ae45910 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L xbip_utils_v3_0_10 -L axi_utils_v2_0_6 -L fir_compiler_v7_2_16 -L secureip -L xpm --snapshot mainTop_tb_behav xil_defaultlib.mainTop_tb -log elaborate.log

