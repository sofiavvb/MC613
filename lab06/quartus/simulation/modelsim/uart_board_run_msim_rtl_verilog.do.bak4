transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/c-ec2022/ra248220/Documents/MC613/MC613/lab06 {/home/c-ec2022/ra248220/Documents/MC613/MC613/lab06/tx.sv}
vlog -sv -work work +incdir+/home/c-ec2022/ra248220/Documents/MC613/MC613/lab06 {/home/c-ec2022/ra248220/Documents/MC613/MC613/lab06/rx.sv}
vlog -sv -work work +incdir+/home/c-ec2022/ra248220/Documents/MC613/MC613/lab06 {/home/c-ec2022/ra248220/Documents/MC613/MC613/lab06/div_clock.sv}
vlog -sv -work work +incdir+/home/c-ec2022/ra248220/Documents/MC613/MC613/lab06 {/home/c-ec2022/ra248220/Documents/MC613/MC613/lab06/uart_tb.sv}
vlog -sv -work work +incdir+/home/c-ec2022/ra248220/Documents/MC613/MC613/lab06 {/home/c-ec2022/ra248220/Documents/MC613/MC613/lab06/uart.sv}

vlog -sv -work work +incdir+/home/c-ec2022/ra248220/Documents/MC613/MC613/lab06/quartus/.. {/home/c-ec2022/ra248220/Documents/MC613/MC613/lab06/quartus/../uart_tb.sv}
vlog -sv -work work +incdir+/home/c-ec2022/ra248220/Documents/MC613/MC613/lab06/quartus/.. {/home/c-ec2022/ra248220/Documents/MC613/MC613/lab06/quartus/../div_clock.sv}
vlog -sv -work work +incdir+/home/c-ec2022/ra248220/Documents/MC613/MC613/lab06/quartus/.. {/home/c-ec2022/ra248220/Documents/MC613/MC613/lab06/quartus/../rx.sv}
vlog -sv -work work +incdir+/home/c-ec2022/ra248220/Documents/MC613/MC613/lab06/quartus/.. {/home/c-ec2022/ra248220/Documents/MC613/MC613/lab06/quartus/../tx.sv}
vlog -sv -work work +incdir+/home/c-ec2022/ra248220/Documents/MC613/MC613/lab06/quartus/.. {/home/c-ec2022/ra248220/Documents/MC613/MC613/lab06/quartus/../uart.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  uart_tb

add wave *
view structure
view signals
run -all
