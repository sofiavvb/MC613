all: 
	quartus_sh --flow compile multiplier_board

load: 
	quartus_pgm -m jtag -c "DE-SoC" -o "p;output_files/multiplier_board.sof@2"