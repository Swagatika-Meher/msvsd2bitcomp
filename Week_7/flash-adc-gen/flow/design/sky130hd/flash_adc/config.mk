export DESIGN_NICKNAME = flash_adc
export DESIGN_NAME = flash_adc

export PLATFORM    = sky130hd

export VERILOG_FILES 		= $(sort $(wildcard ./design/src/$(DESIGN_NICKNAME)/*.v)) \
#			  	  ../blocks/$(PLATFORM)/flash_adc.blackbox.v
export SDC_FILE    		= ./design/$(PLATFORM)/$(DESIGN_NICKNAME)/constraint.sdc

export DIE_AREA   	 	= 0 0 110 105
export CORE_AREA   		= 20 20 90 85

# area of the smaller voltage domain
#export VD1_AREA                 = 50 40 200 190

# power delivery network config file
export PDN_TCL 			= ../blocks/$(PLATFORM)/pdn.tcl

export ADDITIONAL_LEFS  	= ../blocks/$(PLATFORM)/lef/FLASH_ADC_SYM_1.lef \
                        	  ../blocks/$(PLATFORM)/lef/FLASH_ADC_SYM_2.lef \
                        	  ../blocks/$(PLATFORM)/lef/FLASH_ADC_SYM_3.lef \
                        	  ../blocks/$(PLATFORM)/lef/FLASH_ADC_SYM_4.lef \
                        	  ../blocks/$(PLATFORM)/lef/FLASH_ADC_SYM_5.lef \
                        	  ../blocks/$(PLATFORM)/lef/FLASH_ADC_SYM_6.lef \
                        	  ../blocks/$(PLATFORM)/lef/FLASH_ADC_SYM_7.lef

export ADDITIONAL_GDS_FILES 	= ../blocks/$(PLATFORM)/gds/FLASH_ADC_SYM_1.gds \
			      	  ../blocks/$(PLATFORM)/gds/FLASH_ADC_SYM_2.gds \
			      	  ../blocks/$(PLATFORM)/gds/FLASH_ADC_SYM_3.gds \
			      	  ../blocks/$(PLATFORM)/gds/FLASH_ADC_SYM_4.gds \
			      	  ../blocks/$(PLATFORM)/gds/FLASH_ADC_SYM_5.gds \
			      	  ../blocks/$(PLATFORM)/gds/FLASH_ADC_SYM_6.gds \
			      	  ../blocks/$(PLATFORM)/gds/FLASH_ADC_SYM_7.gds

# informs what cells should be placed in the smaller voltage domain
export DOMAIN_INSTS_LIST 	= ../blocks/$(PLATFORM)/flash_adc_domain_insts.txt

# configuration for placement
export MACRO_PLACE_HALO         = 1 1
export MACRO_PLACE_CHANNEL      = 30 30
export MACRO_PLACEMENT          = ../blocks/$(PLATFORM)/manual_macro.tcl

# export CELL_PAD_IN_SITES_GLOBAL_PLACEMENT = 1
# export CELL_PAD_IN_SITES_DETAIL_PLACEMENT = 0
# don't run global place w/o IOs
export HAS_IO_CONSTRAINTS = 1
# don't run non-random IO placement (step 3_2)
export PLACE_PINS_ARGS = -random

export GPL_ROUTABILITY_DRIVEN = 1

# DPO optimization currently fails on the flash_adc
export ENABLE_DPO = 0

# export CELL_PAD_IN_SITES_GLOBAL_PLACEMENT = 4
# export CELL_PAD_IN_SITES_DETAIL_PLACEMENT = 2

# configuration for routing

export PRE_GLOBAL_ROUTE = $(SCRIPTS_DIR)/openfasoc/pre_global_route.tcl

# informs any short circuits that should be forced during routing
export VDD_CUSTOM_CONNECTION 	= ../blocks/$(PLATFORM)/flash_adc_custom_net_VDD.txt
export VSS_CUSTOM_CONNECTION 	= ../blocks/$(PLATFORM)/flash_adc_custom_net_VSS.txt

# indicates with how many connections the VIN route from the HEADER cells connects to the VIN power ring
export VIN_ROUTE_CONNECTION_POINTS = 10
