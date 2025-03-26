-- Copyright (C) 2017  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 17.1.0 Build 590 10/25/2017 SJ Lite Edition"

-- DATE "03/24/2025 20:01:15"

-- 
-- Device: Altera 5CSEMA5F31C6 Package FBGA896
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	ledshift IS
    PORT (
	LEDR : BUFFER std_logic_vector(9 DOWNTO 0);
	KEY : IN std_logic_vector(3 DOWNTO 0);
	CLOCK_50 : IN std_logic
	);
END ledshift;

-- Design Ports Information
-- LEDR[0]	=>  Location: PIN_V16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDR[1]	=>  Location: PIN_W16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDR[2]	=>  Location: PIN_V17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDR[3]	=>  Location: PIN_V18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDR[4]	=>  Location: PIN_W17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDR[5]	=>  Location: PIN_W19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDR[6]	=>  Location: PIN_Y19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDR[7]	=>  Location: PIN_W20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDR[8]	=>  Location: PIN_W21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDR[9]	=>  Location: PIN_Y21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- KEY[1]	=>  Location: PIN_AA15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- KEY[2]	=>  Location: PIN_W15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- CLOCK_50	=>  Location: PIN_AF14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- KEY[0]	=>  Location: PIN_AA14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- KEY[3]	=>  Location: PIN_Y16,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF ledshift IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_LEDR : std_logic_vector(9 DOWNTO 0);
SIGNAL ww_KEY : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_CLOCK_50 : std_logic;
SIGNAL \KEY[1]~input_o\ : std_logic;
SIGNAL \KEY[2]~input_o\ : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \CLOCK_50~input_o\ : std_logic;
SIGNAL \CLOCK_50~inputCLKENA0_outclk\ : std_logic;
SIGNAL \KEY[0]~input_o\ : std_logic;
SIGNAL \detector_dir[0]~0_combout\ : std_logic;
SIGNAL \KEY[3]~input_o\ : std_logic;
SIGNAL \detector_esq[0]~0_combout\ : std_logic;
SIGNAL \always1~1_combout\ : std_logic;
SIGNAL \detector_esq[2]~feeder_combout\ : std_logic;
SIGNAL \registrador[1]~2_combout\ : std_logic;
SIGNAL \registrador[3]~DUPLICATE_q\ : std_logic;
SIGNAL \registrador~1_combout\ : std_logic;
SIGNAL \registrador~3_combout\ : std_logic;
SIGNAL \registrador~4_combout\ : std_logic;
SIGNAL \registrador~5_combout\ : std_logic;
SIGNAL \registrador~6_combout\ : std_logic;
SIGNAL \registrador~7_combout\ : std_logic;
SIGNAL \registrador~8_combout\ : std_logic;
SIGNAL \registrador[7]~DUPLICATE_q\ : std_logic;
SIGNAL \registrador~9_combout\ : std_logic;
SIGNAL \registrador[9]~10_combout\ : std_logic;
SIGNAL \always1~0_combout\ : std_logic;
SIGNAL \registrador~0_combout\ : std_logic;
SIGNAL \registrador[0]~DUPLICATE_q\ : std_logic;
SIGNAL \LEDR[0]~reg0_q\ : std_logic;
SIGNAL \LEDR[1]~reg0feeder_combout\ : std_logic;
SIGNAL \LEDR[1]~reg0_q\ : std_logic;
SIGNAL \LEDR[2]~reg0feeder_combout\ : std_logic;
SIGNAL \LEDR[2]~reg0_q\ : std_logic;
SIGNAL \LEDR[3]~reg0_q\ : std_logic;
SIGNAL \LEDR[4]~reg0_q\ : std_logic;
SIGNAL \registrador[5]~DUPLICATE_q\ : std_logic;
SIGNAL \LEDR[5]~0_combout\ : std_logic;
SIGNAL \LEDR[5]~reg0_q\ : std_logic;
SIGNAL \registrador[6]~DUPLICATE_q\ : std_logic;
SIGNAL \LEDR[6]~reg0feeder_combout\ : std_logic;
SIGNAL \LEDR[6]~reg0_q\ : std_logic;
SIGNAL \LEDR[7]~reg0_q\ : std_logic;
SIGNAL \registrador[8]~DUPLICATE_q\ : std_logic;
SIGNAL \LEDR[8]~reg0_q\ : std_logic;
SIGNAL \registrador[9]~DUPLICATE_q\ : std_logic;
SIGNAL \LEDR[9]~reg0feeder_combout\ : std_logic;
SIGNAL \LEDR[9]~reg0_q\ : std_logic;
SIGNAL detector_esq : std_logic_vector(2 DOWNTO 0);
SIGNAL detector_dir : std_logic_vector(2 DOWNTO 0);
SIGNAL registrador : std_logic_vector(9 DOWNTO 0);
SIGNAL \ALT_INV_registrador[9]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_registrador[7]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_registrador[6]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_registrador[5]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_registrador[3]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_registrador[0]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_KEY[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_KEY[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_always1~1_combout\ : std_logic;
SIGNAL \ALT_INV_always1~0_combout\ : std_logic;
SIGNAL ALT_INV_detector_esq : std_logic_vector(2 DOWNTO 1);
SIGNAL ALT_INV_detector_dir : std_logic_vector(2 DOWNTO 1);
SIGNAL ALT_INV_registrador : std_logic_vector(9 DOWNTO 0);

BEGIN

LEDR <= ww_LEDR;
ww_KEY <= KEY;
ww_CLOCK_50 <= CLOCK_50;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_registrador[9]~DUPLICATE_q\ <= NOT \registrador[9]~DUPLICATE_q\;
\ALT_INV_registrador[7]~DUPLICATE_q\ <= NOT \registrador[7]~DUPLICATE_q\;
\ALT_INV_registrador[6]~DUPLICATE_q\ <= NOT \registrador[6]~DUPLICATE_q\;
\ALT_INV_registrador[5]~DUPLICATE_q\ <= NOT \registrador[5]~DUPLICATE_q\;
\ALT_INV_registrador[3]~DUPLICATE_q\ <= NOT \registrador[3]~DUPLICATE_q\;
\ALT_INV_registrador[0]~DUPLICATE_q\ <= NOT \registrador[0]~DUPLICATE_q\;
\ALT_INV_KEY[3]~input_o\ <= NOT \KEY[3]~input_o\;
\ALT_INV_KEY[0]~input_o\ <= NOT \KEY[0]~input_o\;
\ALT_INV_always1~1_combout\ <= NOT \always1~1_combout\;
\ALT_INV_always1~0_combout\ <= NOT \always1~0_combout\;
ALT_INV_detector_esq(2) <= NOT detector_esq(2);
ALT_INV_detector_esq(1) <= NOT detector_esq(1);
ALT_INV_detector_dir(2) <= NOT detector_dir(2);
ALT_INV_detector_dir(1) <= NOT detector_dir(1);
ALT_INV_registrador(9) <= NOT registrador(9);
ALT_INV_registrador(8) <= NOT registrador(8);
ALT_INV_registrador(7) <= NOT registrador(7);
ALT_INV_registrador(6) <= NOT registrador(6);
ALT_INV_registrador(5) <= NOT registrador(5);
ALT_INV_registrador(4) <= NOT registrador(4);
ALT_INV_registrador(3) <= NOT registrador(3);
ALT_INV_registrador(2) <= NOT registrador(2);
ALT_INV_registrador(1) <= NOT registrador(1);
ALT_INV_registrador(0) <= NOT registrador(0);

-- Location: IOOBUF_X52_Y0_N2
\LEDR[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \LEDR[0]~reg0_q\,
	devoe => ww_devoe,
	o => ww_LEDR(0));

-- Location: IOOBUF_X52_Y0_N19
\LEDR[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \LEDR[1]~reg0_q\,
	devoe => ww_devoe,
	o => ww_LEDR(1));

-- Location: IOOBUF_X60_Y0_N2
\LEDR[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \LEDR[2]~reg0_q\,
	devoe => ww_devoe,
	o => ww_LEDR(2));

-- Location: IOOBUF_X80_Y0_N2
\LEDR[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \LEDR[3]~reg0_q\,
	devoe => ww_devoe,
	o => ww_LEDR(3));

-- Location: IOOBUF_X60_Y0_N19
\LEDR[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \LEDR[4]~reg0_q\,
	devoe => ww_devoe,
	o => ww_LEDR(4));

-- Location: IOOBUF_X80_Y0_N19
\LEDR[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \LEDR[5]~reg0_q\,
	devoe => ww_devoe,
	o => ww_LEDR(5));

-- Location: IOOBUF_X84_Y0_N2
\LEDR[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \LEDR[6]~reg0_q\,
	devoe => ww_devoe,
	o => ww_LEDR(6));

-- Location: IOOBUF_X89_Y6_N5
\LEDR[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \LEDR[7]~reg0_q\,
	devoe => ww_devoe,
	o => ww_LEDR(7));

-- Location: IOOBUF_X89_Y8_N5
\LEDR[8]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \LEDR[8]~reg0_q\,
	devoe => ww_devoe,
	o => ww_LEDR(8));

-- Location: IOOBUF_X89_Y6_N22
\LEDR[9]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \LEDR[9]~reg0_q\,
	devoe => ww_devoe,
	o => ww_LEDR(9));

-- Location: IOIBUF_X32_Y0_N1
\CLOCK_50~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_CLOCK_50,
	o => \CLOCK_50~input_o\);

-- Location: CLKCTRL_G6
\CLOCK_50~inputCLKENA0\ : cyclonev_clkena
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	disable_mode => "low",
	ena_register_mode => "always enabled",
	ena_register_power_up => "high",
	test_syn => "high")
-- pragma translate_on
PORT MAP (
	inclk => \CLOCK_50~input_o\,
	outclk => \CLOCK_50~inputCLKENA0_outclk\);

-- Location: IOIBUF_X36_Y0_N1
\KEY[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_KEY(0),
	o => \KEY[0]~input_o\);

-- Location: LABCELL_X48_Y1_N15
\detector_dir[0]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \detector_dir[0]~0_combout\ = ( !\KEY[0]~input_o\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_KEY[0]~input_o\,
	combout => \detector_dir[0]~0_combout\);

-- Location: FF_X60_Y1_N22
\detector_dir[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	asdata => \detector_dir[0]~0_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => detector_dir(0));

-- Location: FF_X60_Y1_N35
\detector_dir[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	asdata => detector_dir(0),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => detector_dir(1));

-- Location: FF_X60_Y1_N56
\detector_dir[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	asdata => detector_dir(1),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => detector_dir(2));

-- Location: IOIBUF_X40_Y0_N18
\KEY[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_KEY(3),
	o => \KEY[3]~input_o\);

-- Location: LABCELL_X51_Y1_N45
\detector_esq[0]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \detector_esq[0]~0_combout\ = ( !\KEY[3]~input_o\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_KEY[3]~input_o\,
	combout => \detector_esq[0]~0_combout\);

-- Location: FF_X51_Y1_N46
\detector_esq[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \detector_esq[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => detector_esq(0));

-- Location: FF_X60_Y1_N41
\detector_esq[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	asdata => detector_esq(0),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => detector_esq(1));

-- Location: FF_X60_Y1_N50
\registrador[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \registrador~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => registrador(0));

-- Location: LABCELL_X60_Y1_N21
\always1~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \always1~1_combout\ = ( detector_dir(1) & ( (!registrador(0) & !detector_dir(2)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000010101010000000001010101000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_registrador(0),
	datad => ALT_INV_detector_dir(2),
	dataf => ALT_INV_detector_dir(1),
	combout => \always1~1_combout\);

-- Location: LABCELL_X60_Y1_N18
\detector_esq[2]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \detector_esq[2]~feeder_combout\ = detector_esq(1)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011001100110011001100110011001100110011001100110011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_detector_esq(1),
	combout => \detector_esq[2]~feeder_combout\);

-- Location: FF_X60_Y1_N20
\detector_esq[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \detector_esq[2]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => detector_esq(2));

-- Location: LABCELL_X60_Y1_N57
\registrador[1]~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \registrador[1]~2_combout\ = ( !detector_dir(2) & ( detector_esq(2) & ( (detector_dir(1) & !registrador(0)) ) ) ) # ( detector_dir(2) & ( !detector_esq(2) & ( (!registrador(9) & detector_esq(1)) ) ) ) # ( !detector_dir(2) & ( !detector_esq(2) & ( 
-- (!registrador(9) & (((detector_dir(1) & !registrador(0))) # (detector_esq(1)))) # (registrador(9) & (detector_dir(1) & ((!registrador(0))))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011101100001010000010100000101000110011000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_registrador(9),
	datab => ALT_INV_detector_dir(1),
	datac => ALT_INV_detector_esq(1),
	datad => ALT_INV_registrador(0),
	datae => ALT_INV_detector_dir(2),
	dataf => ALT_INV_detector_esq(2),
	combout => \registrador[1]~2_combout\);

-- Location: FF_X60_Y1_N8
\registrador[3]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \registrador~4_combout\,
	ena => \registrador[1]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \registrador[3]~DUPLICATE_q\);

-- Location: LABCELL_X60_Y1_N0
\registrador~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \registrador~1_combout\ = ( registrador(2) & ( ((!detector_esq(1)) # ((\registrador[0]~DUPLICATE_q\) # (registrador(9)))) # (detector_esq(2)) ) ) # ( !registrador(2) & ( (!detector_esq(2) & (detector_esq(1) & (!registrador(9) & 
-- \registrador[0]~DUPLICATE_q\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000100000000000000010000011011111111111111101111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_detector_esq(2),
	datab => ALT_INV_detector_esq(1),
	datac => ALT_INV_registrador(9),
	datad => \ALT_INV_registrador[0]~DUPLICATE_q\,
	dataf => ALT_INV_registrador(2),
	combout => \registrador~1_combout\);

-- Location: FF_X60_Y1_N1
\registrador[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \registrador~1_combout\,
	ena => \registrador[1]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => registrador(1));

-- Location: LABCELL_X60_Y1_N3
\registrador~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \registrador~3_combout\ = ( registrador(1) & ( ((!detector_esq(2) & (detector_esq(1) & !registrador(9)))) # (\registrador[3]~DUPLICATE_q\) ) ) # ( !registrador(1) & ( (\registrador[3]~DUPLICATE_q\ & (((!detector_esq(1)) # (registrador(9))) # 
-- (detector_esq(2)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000110100001111000011010000111100101111000011110010111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_detector_esq(2),
	datab => ALT_INV_detector_esq(1),
	datac => \ALT_INV_registrador[3]~DUPLICATE_q\,
	datad => ALT_INV_registrador(9),
	dataf => ALT_INV_registrador(1),
	combout => \registrador~3_combout\);

-- Location: FF_X60_Y1_N5
\registrador[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \registrador~3_combout\,
	ena => \registrador[1]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => registrador(2));

-- Location: LABCELL_X60_Y1_N6
\registrador~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \registrador~4_combout\ = ( registrador(4) & ( ((!detector_esq(1)) # ((registrador(9)) # (registrador(2)))) # (detector_esq(2)) ) ) # ( !registrador(4) & ( (!detector_esq(2) & (detector_esq(1) & (registrador(2) & !registrador(9)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000001000000000000000100000000011011111111111111101111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_detector_esq(2),
	datab => ALT_INV_detector_esq(1),
	datac => ALT_INV_registrador(2),
	datad => ALT_INV_registrador(9),
	dataf => ALT_INV_registrador(4),
	combout => \registrador~4_combout\);

-- Location: FF_X60_Y1_N7
\registrador[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \registrador~4_combout\,
	ena => \registrador[1]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => registrador(3));

-- Location: LABCELL_X60_Y1_N42
\registrador~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \registrador~5_combout\ = ( registrador(3) & ( (!registrador(5)) # ((!detector_esq(2) & (detector_esq(1) & !registrador(9)))) ) ) # ( !registrador(3) & ( (!registrador(5) & (((!detector_esq(1)) # (registrador(9))) # (detector_esq(2)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1101000011110000110100001111000011110010111100001111001011110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_detector_esq(2),
	datab => ALT_INV_detector_esq(1),
	datac => ALT_INV_registrador(5),
	datad => ALT_INV_registrador(9),
	dataf => ALT_INV_registrador(3),
	combout => \registrador~5_combout\);

-- Location: FF_X60_Y1_N44
\registrador[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \registrador~5_combout\,
	ena => \registrador[1]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => registrador(4));

-- Location: LABCELL_X60_Y1_N36
\registrador~6\ : cyclonev_lcell_comb
-- Equation(s):
-- \registrador~6_combout\ = ( registrador(5) & ( \always1~0_combout\ & ( !registrador(4) ) ) ) # ( !registrador(5) & ( \always1~0_combout\ & ( !registrador(4) ) ) ) # ( registrador(5) & ( !\always1~0_combout\ & ( (!\always1~1_combout\) # (!registrador(6)) ) 
-- ) ) # ( !registrador(5) & ( !\always1~0_combout\ & ( (\always1~1_combout\ & !registrador(6)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100000000111111111111000011001100110011001100110011001100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_registrador(4),
	datac => \ALT_INV_always1~1_combout\,
	datad => ALT_INV_registrador(6),
	datae => ALT_INV_registrador(5),
	dataf => \ALT_INV_always1~0_combout\,
	combout => \registrador~6_combout\);

-- Location: FF_X60_Y1_N38
\registrador[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \registrador~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => registrador(5));

-- Location: FF_X60_Y1_N46
\registrador[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \registrador~8_combout\,
	ena => \registrador[1]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => registrador(7));

-- Location: LABCELL_X60_Y1_N12
\registrador~7\ : cyclonev_lcell_comb
-- Equation(s):
-- \registrador~7_combout\ = ( registrador(7) & ( ((!detector_esq(1)) # ((!registrador(5)) # (registrador(9)))) # (detector_esq(2)) ) ) # ( !registrador(7) & ( (!detector_esq(2) & (detector_esq(1) & (!registrador(5) & !registrador(9)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010000000000000001000000000000011111101111111111111110111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_detector_esq(2),
	datab => ALT_INV_detector_esq(1),
	datac => ALT_INV_registrador(5),
	datad => ALT_INV_registrador(9),
	dataf => ALT_INV_registrador(7),
	combout => \registrador~7_combout\);

-- Location: FF_X60_Y1_N14
\registrador[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \registrador~7_combout\,
	ena => \registrador[1]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => registrador(6));

-- Location: LABCELL_X60_Y1_N45
\registrador~8\ : cyclonev_lcell_comb
-- Equation(s):
-- \registrador~8_combout\ = ( registrador(6) & ( ((!detector_esq(2) & (detector_esq(1) & !registrador(9)))) # (registrador(8)) ) ) # ( !registrador(6) & ( (registrador(8) & (((!detector_esq(1)) # (registrador(9))) # (detector_esq(2)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000110100001111000011010000111100101111000011110010111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_detector_esq(2),
	datab => ALT_INV_detector_esq(1),
	datac => ALT_INV_registrador(8),
	datad => ALT_INV_registrador(9),
	dataf => ALT_INV_registrador(6),
	combout => \registrador~8_combout\);

-- Location: FF_X60_Y1_N47
\registrador[7]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \registrador~8_combout\,
	ena => \registrador[1]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \registrador[7]~DUPLICATE_q\);

-- Location: LABCELL_X60_Y1_N9
\registrador~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \registrador~9_combout\ = ( detector_esq(1) & ( ((!detector_esq(2) & \registrador[7]~DUPLICATE_q\)) # (registrador(9)) ) ) # ( !detector_esq(1) & ( registrador(9) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111000000001111111100001010111111110000101011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_detector_esq(2),
	datac => \ALT_INV_registrador[7]~DUPLICATE_q\,
	datad => ALT_INV_registrador(9),
	dataf => ALT_INV_detector_esq(1),
	combout => \registrador~9_combout\);

-- Location: FF_X60_Y1_N11
\registrador[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \registrador~9_combout\,
	ena => \registrador[1]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => registrador(8));

-- Location: LABCELL_X60_Y1_N27
\registrador[9]~10\ : cyclonev_lcell_comb
-- Equation(s):
-- \registrador[9]~10_combout\ = ( \always1~0_combout\ & ( ((!\always1~1_combout\ & registrador(9))) # (registrador(8)) ) ) # ( !\always1~0_combout\ & ( (!\always1~1_combout\ & registrador(9)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000010101010000000001010101000001111101011110000111110101111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_always1~1_combout\,
	datac => ALT_INV_registrador(8),
	datad => ALT_INV_registrador(9),
	dataf => \ALT_INV_always1~0_combout\,
	combout => \registrador[9]~10_combout\);

-- Location: FF_X60_Y1_N29
\registrador[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \registrador[9]~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => registrador(9));

-- Location: LABCELL_X60_Y1_N15
\always1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \always1~0_combout\ = ( !detector_esq(2) & ( (detector_esq(1) & !registrador(9)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100000000000011110000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_detector_esq(1),
	datad => ALT_INV_registrador(9),
	dataf => ALT_INV_detector_esq(2),
	combout => \always1~0_combout\);

-- Location: LABCELL_X60_Y1_N48
\registrador~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \registrador~0_combout\ = ( registrador(0) & ( registrador(1) & ( !\always1~0_combout\ ) ) ) # ( !registrador(0) & ( registrador(1) & ( (!detector_dir(2) & (!\always1~0_combout\ & detector_dir(1))) ) ) ) # ( registrador(0) & ( !registrador(1) & ( 
-- !\always1~0_combout\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000110011001100110000001000000010001100110011001100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_detector_dir(2),
	datab => \ALT_INV_always1~0_combout\,
	datac => ALT_INV_detector_dir(1),
	datae => ALT_INV_registrador(0),
	dataf => ALT_INV_registrador(1),
	combout => \registrador~0_combout\);

-- Location: FF_X60_Y1_N49
\registrador[0]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \registrador~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \registrador[0]~DUPLICATE_q\);

-- Location: FF_X60_Y1_N25
\LEDR[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	asdata => \registrador[0]~DUPLICATE_q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \LEDR[0]~reg0_q\);

-- Location: MLABCELL_X59_Y1_N48
\LEDR[1]~reg0feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \LEDR[1]~reg0feeder_combout\ = ( registrador(1) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => ALT_INV_registrador(1),
	combout => \LEDR[1]~reg0feeder_combout\);

-- Location: FF_X59_Y1_N49
\LEDR[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \LEDR[1]~reg0feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \LEDR[1]~reg0_q\);

-- Location: LABCELL_X60_Y1_N24
\LEDR[2]~reg0feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \LEDR[2]~reg0feeder_combout\ = registrador(2)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000011110000111100001111000011110000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_registrador(2),
	combout => \LEDR[2]~reg0feeder_combout\);

-- Location: FF_X60_Y1_N26
\LEDR[2]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \LEDR[2]~reg0feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \LEDR[2]~reg0_q\);

-- Location: FF_X60_Y1_N31
\LEDR[3]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	asdata => \registrador[3]~DUPLICATE_q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \LEDR[3]~reg0_q\);

-- Location: FF_X60_Y1_N53
\LEDR[4]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	asdata => registrador(4),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \LEDR[4]~reg0_q\);

-- Location: FF_X60_Y1_N37
\registrador[5]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \registrador~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \registrador[5]~DUPLICATE_q\);

-- Location: LABCELL_X71_Y1_N12
\LEDR[5]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \LEDR[5]~0_combout\ = ( !\registrador[5]~DUPLICATE_q\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_registrador[5]~DUPLICATE_q\,
	combout => \LEDR[5]~0_combout\);

-- Location: FF_X71_Y1_N13
\LEDR[5]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \LEDR[5]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \LEDR[5]~reg0_q\);

-- Location: FF_X60_Y1_N13
\registrador[6]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \registrador~7_combout\,
	ena => \registrador[1]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \registrador[6]~DUPLICATE_q\);

-- Location: LABCELL_X66_Y1_N39
\LEDR[6]~reg0feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \LEDR[6]~reg0feeder_combout\ = ( \registrador[6]~DUPLICATE_q\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_registrador[6]~DUPLICATE_q\,
	combout => \LEDR[6]~reg0feeder_combout\);

-- Location: FF_X66_Y1_N40
\LEDR[6]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \LEDR[6]~reg0feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \LEDR[6]~reg0_q\);

-- Location: FF_X59_Y1_N31
\LEDR[7]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	asdata => \registrador[7]~DUPLICATE_q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \LEDR[7]~reg0_q\);

-- Location: FF_X60_Y1_N10
\registrador[8]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \registrador~9_combout\,
	ena => \registrador[1]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \registrador[8]~DUPLICATE_q\);

-- Location: FF_X60_Y1_N19
\LEDR[8]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	asdata => \registrador[8]~DUPLICATE_q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \LEDR[8]~reg0_q\);

-- Location: FF_X60_Y1_N28
\registrador[9]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \registrador[9]~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \registrador[9]~DUPLICATE_q\);

-- Location: LABCELL_X60_Y5_N51
\LEDR[9]~reg0feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \LEDR[9]~reg0feeder_combout\ = ( \registrador[9]~DUPLICATE_q\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_registrador[9]~DUPLICATE_q\,
	combout => \LEDR[9]~reg0feeder_combout\);

-- Location: FF_X60_Y5_N52
\LEDR[9]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \LEDR[9]~reg0feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \LEDR[9]~reg0_q\);

-- Location: IOIBUF_X36_Y0_N18
\KEY[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_KEY(1),
	o => \KEY[1]~input_o\);

-- Location: IOIBUF_X40_Y0_N1
\KEY[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_KEY(2),
	o => \KEY[2]~input_o\);

-- Location: LABCELL_X46_Y34_N0
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;


