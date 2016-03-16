# $Id: Makefile,v 1.3 2009/12/08 20:10:54 lak Exp $

#
# Copyright 2004 SRC Computers, LLC  All Rights Reserved.
#
#	Manufactured in the United States of America.
#
# SRC Computers, LLC
# 4240 N Nevada Avenue
# Colorado Springs, CO 80907
# (v) (719) 262-0213
# (f) (719) 262-0223
#
# No permission has been granted to distribute this software
# without the express permission of SRC Computers, LLC
#
# This program is distributed WITHOUT ANY WARRANTY OF ANY KIND.
#

# ----------------------------------
# User defines FILES, MAPFILES, and BIN here
# ----------------------------------
FILES 		= main.c

MAPFILES 	= des.mc

BIN 		= DES

# -----------------------------------
# User defined macros info supplied here
#
# (Leave commented out if not used)
# -----------------------------------

MACROS		= my_macro/DES_hw.vhd

MY_BLKBOX 	= my_macro/blk.v
MY_MACRO_DIR 	= my_macro
MY_INFO 	= my_macro/info
# -----------------------------------
# User supplied MCC and MFTN flags
# -----------------------------------

MCCFLAGS 	=
MFTNFLAGS	=

# -----------------------------------
# User supplied flags for C & Fortran compilers
# -----------------------------------

CC		= icc
FC		= ifort
LD		= icc

CFLAGS 		= 
FFLAGS		=

# -----------------------------------
# No modifications are required below
# -----------------------------------
MAKIN   ?= $(MC_ROOT)/opt/srcci/comp/lib/AppRules.make
include $(MAKIN)
