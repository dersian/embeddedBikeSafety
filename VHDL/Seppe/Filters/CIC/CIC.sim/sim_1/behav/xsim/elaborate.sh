#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2021.1 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Wed Apr 12 11:18:15 CEST 2023
# SW Build 3247384 on Thu Jun 10 19:36:07 MDT 2021
#
# IP Build 3246043 on Fri Jun 11 00:30:35 MDT 2021
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# elaborate design
echo "xelab -wto 5ecb9955c9514dffaaf67ae7a0ec9cd5 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L xbip_utils_v3_0_10 -L axi_utils_v2_0_6 -L cic_compiler_v4_0_15 -L secureip -L xpm --snapshot mainTop_tb_behav xil_defaultlib.mainTop_tb -log elaborate.log"
xelab -wto 5ecb9955c9514dffaaf67ae7a0ec9cd5 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L xbip_utils_v3_0_10 -L axi_utils_v2_0_6 -L cic_compiler_v4_0_15 -L secureip -L xpm --snapshot mainTop_tb_behav xil_defaultlib.mainTop_tb -log elaborate.log

