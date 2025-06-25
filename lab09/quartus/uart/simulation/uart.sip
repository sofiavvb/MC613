set_global_assignment -entity "uart" -library "lib_uart" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "uart" -library "lib_uart" -name IP_TOOL_VERSION "17.1"
set_global_assignment -entity "uart" -library "lib_uart" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_uart" -name SPD_FILE [file join $::quartus(sip_path) "../uart.spd"]
set_global_assignment -library "lib_uart" -name MISC_FILE [file join $::quartus(sip_path) "../../uart.qsys"]

set_global_assignment -library "lib_uart" -name MISC_FILE [file join $::quartus(sip_path) "uart.v"]
set_global_assignment -library "lib_uart" -name MISC_FILE [file join $::quartus(sip_path) "submodules/uart_jtag_uart_0.v"]
