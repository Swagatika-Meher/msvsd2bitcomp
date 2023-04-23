# ==============================================================================
# Run 3-bit flash ADC
# ==============================================================================

sim_pex=
sim=
inv=
head=

ifneq ("$(sim)","")
	sim_pex = --pex
endif

ifneq ("$(ninv)","")
	inv="--ninv"
endif

ifneq ("$(nhead)","")
	head="--nhead"
endif


help:banner
	@@echo "OpenFASOC is focused on open source automated analog generation"
	@@echo "from user specification to GDSII with fully open-sourced tools."
	@@echo "This project is led by a team of researchers at the University of Michigan and is inspired from FASOC"
	@@echo "For more info, visit https://fasoc.engin.umich.edu/"
	@@echo  ""
	@@echo "IP: Asynchronous UP Counter \nSupported Technology: Sky130A \nSupported Library: sky130hd"
	@@echo ""
	@@echo "Targets supported:"
	@@echo "1. make sky130hd_ADC_verilog"
	@@echo "    >> This will create the verilog file for the thermal sensor IP. It doesn't create a macro, won't create lef/def/gds files and won't run simulations "
	@@echo "2. make sky130hd_ADC [ninv=<num>] [nhead=<num>]"
	@@echo "    >> This will create the macro for the thermal sensor, creates the lef/def/gds/spice netlist files and performs lvs/drc checks. But this won't run simulations."
	@@echo "3. make sky130hd_ADC_full [ninv=<num>] [nhead=<num>] [sim=pex]"
	@@echo "    >> This will create the macro for the thermal sensor, creates the lef/def/gds/spice netlist files, performs lvs/drc checks and also runs simulations."
	@@echo "    >> Note: Only Pre-PEX simulations are performed, by default, under this target. To perform Post-PEX simulations as well, set sim to 'pex' as shown in the target definition"
	@@echo "4. make clean"
	@@echo "    >> This will clean all files generated during the run inside the run/, flow/ and work/ directories"
	@@echo "5. make help"
	@@echo "    >> Displays this message"

sky130hd_ADC_verilog:
	python3 tools/flash-adc-gen.py --specfile test.json --outputDir ./work --platform sky130hd --mode verilog
	@@echo "=============================================================="
	@@echo " __ 	   __ ____ ____   _____ _     ___   ___ "
	@@echo " \ \      / /|  __|  _  \|_   _| |   / _ \ / __\ "
	@@echo "  \ \    / / | |_|| |_) |  | | | |  | | | | |  _ " 
	@@echo "   \ \__/ /  | |__|  __/  _| |_| |__| |_| | |_| | "
	@@echo "    \____/   |____|_|\_\ |_____|____|\___/ \___/ "
	@@echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	@@echo "OpenFASoC For Verilog Generation"
	@@echo "==============================================================="

sky130hd_ADC:
	@python3 tools/flash-adc-gen.py --specfile test.json --outputDir ./work --platform sky130hd --mode macro
	@python3 tools/parse_rpt.py
	@@echo "=================================================================================="
	@@echo "Thank you for using OpenFASOC"
	@@echo "For more info, please read the latest documentation on openfasoc.readthedocs.io"
	@@echo "For any issues, please feel free to open an issue on GitHub repository"
	@@echo "=================================================================================="

sky130hd_ADC_build:
	@python3 tools/flash-adc-gen.py --specfile test.json --outputDir ./work --platform sky130hd --mode full
	@python3 tools/parse_rpt.py
	@@echo "=================================================================================="
	@@echo "Thank you for using OpenFASOC"
	@@echo "=================================================================================="
	@@echo "   ___  _____ ______ _   _ _____  _     ____   ___   ____"
	@@echo "  / _ \|  _  \| ____| \ | |  ___|/ \   / ___| / _ \ / ___|"
	@@echo " | | | | |_) ||  _| |  \| | |_  / _ \  \___ \| | | | |    "
	@@echo " | |_| |  __/ | |___| |\  |  _|/ ___ \  ___) | |_| | |___ "
	@@echo "  \___/|_|    |_____|_| \_|_| /_/   \_\|____/ \___/ \____|"
	@@echo ""
	@@echo "==============================================================="

clean:
	rm -f error_within_x.csv golden_error_opt.csv search_result.csv
	rm -rf work
	rm -rf tools/*.pyc tools/__pycache__/
	cd flow && make clean_all
	cd simulations && rm -rf run

banner:
	@@echo "=============================================================="
	@@echo "   ___  _____ ______ _   _ _____  _     ____   ___   ____"
	@@echo "  / _ \|  _  \| ____| \ | |  ___|/ \   / ___| / _ \ / ___|"
	@@echo " | | | | |_) ||  _| |  \| | |_  / _ \  \___ \| | | | |    "
	@@echo " | |_| |  __/ | |___| |\  |  _|/ ___ \  ___) | |_| | |___ "
	@@echo "  \___/|_|    |_____|_| \_|_| /_/   \_\|____/ \___/ \____|"
	@@echo ""
	@@echo "==============================================================="
