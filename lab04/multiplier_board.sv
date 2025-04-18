module multiplier_board (
    input logic [9:0] SW,
    input logic KEY,
    input logic CLOCK_50,
    output logic [6:0] HEX2,  
    output logic [6:0] HEX1,  
    output logic [6:0] HEX0  
);

    //sinais de controle
    logic set; 
    logic [1:0] detector;
    logic [4:0] A, B, B_mul; 
    logic [9:0] R, A_mul;


    //detector de borda para o set com o clock
    assign set = ~detector[1] & detector[0];

    always_ff @(posedge CLOCK_50) begin
        detector <= {detector[0], ~KEY};
    end

    //inputs
    assign A = SW[9:5];
    assign B = SW[4:0];

    //multiplicador
    always_ff @(posedge CLOCK_50) begin
        if (~KEY == 1 && set) begin
            R <= 0;
            A_mul <= {5'b00000, A}; //ele joga na parte baixa
            B_mul <= B;  
        end else begin 
            if(B_mul[0] == 1) begin
                R <= R + A_mul;
            end
            A_mul <= A_mul << 1; 
            B_mul <= B_mul >> 1;  
        end
    end

    //outputs para seguimentos
    hex_7seg display0 (
        .bin(R[3:0]),
        .segs(HEX0)
    );

    hex_7seg display1 (
        .bin(R[7:4]),
        .segs(HEX1)
    );

    hex_7seg display2 (
        .bin({2'b0, R[9:8]}),
        .segs(HEX2)
    );


endmodule

/*  erro mais recente

*** Fatal Error: Segment Violation at 0xfffffffffffffff8
Module: quartus_map
Stack Trace:
    0xbdae3: std::string::swap(std::string&) + 0x3 (stdc++.so.6)
   0x17decf: HDB_SOURCE_FILE::get_filename() const + 0xaf (db_hdb)
    0xeb234: SGN_PROCESS_INFO::is_duplicate_file(HDB_SOURCE_FILE*) + 0x294 (synth_sgn)
    0xeba74: SGN_ANALYZER::analyze() + 0x234 (synth_sgn)
   0x18c8f3: SGN_ANALYZER::search_and_analyze(HDB_INSTANCE_NAME*, bool, unsigned long, bool) + 0x1143 (synth_sgn)
   0x18de02: SGN_EXTRACTOR::find_target_entity(HDB_INSTANCE_NAME*, char const*, unsigned long, bool) const + 0x2a2 (synth_sgn)
   0x18e15c: SGN_EXTRACTOR::recursive_extraction(HDB_INSTANCE_NAME*, SGN_WRAPPER_INFO*, char const*) + 0x3c (synth_sgn)
   0x18f2d6: SGN_EXTRACTOR::recurse_into_newly_extracted_netlist(HDB_ENTITY*, HDB_INSTANCE_NAME*, unsigned long, SGN_WRAPPER_INFO*) + 0x546 (synth_sgn)
   0x18e3fc: SGN_EXTRACTOR::recursive_extraction(HDB_INSTANCE_NAME*, SGN_WRAPPER_INFO*, char const*) + 0x2dc (synth_sgn)
   0x1945e3: SGN_EXTRACTOR::extract() + 0x3a3 (synth_sgn)
   0x1a4f70: sgn_qic_full(CMP_FACADE*, std::vector<std::string, std::allocator<std::string> >&, std::vector<double, std::allocator<double> >&) + 0x440 (synth_sgn)
    0x1c3b9: qsyn_execute_sgn(CMP_FACADE*, std::vector<std::string, std::allocator<std::string> >&, std::string const&, THR_NAMED_PIPE*, THR_NAMED_PIPE*) + 0x159 (quartus_map)
    0x37d61: QSYN_FRAMEWORK::execute_core(THR_NAMED_PIPE*, THR_NAMED_PIPE*) + 0x231 (quartus_map)
    0x3bcec: QSYN_FRAMEWORK::execute() + 0xc4c (quartus_map)
    0x1c75b: qexe_standard_main(QEXE_FRAMEWORK*, QEXE_OPTION_DEFINITION const**, int, char const**) + 0x888 (comp_qexe)
    0x3025c: qsyn_main(int, char const**) + 0x13c (quartus_map)
    0x40720: msg_main_thread(void*) + 0x10 (ccl_msg)
     0x602c: thr_final_wrapper + 0xc (ccl_thr)
    0x407df: msg_thread_wrapper(void* (*)(void*), void*) + 0x62 (ccl_msg)
     0xa559: mem_thread_wrapper(void* (*)(void*), void*) + 0x99 (ccl_mem)
     0x8f92: err_thread_wrapper(void* (*)(void*), void*) + 0x27 (ccl_err)
     0x63f2: thr_thread_wrapper + 0x15 (ccl_thr)
    0x427e2: msg_exe_main(int, char const**, int (*)(int, char const**)) + 0xa3 (ccl_msg)
     0x3248: __libc_start_call_main + 0x78 (c.so.6)
     0x330b: __libc_start_main + 0x8b (c.so.6)


End-trace

Error: Flow compile (for project /home/c-ec2022/ra248220/Documents/MC613 - git/MC613/lab04/lab04) was not successful
Error: ERROR: Error(s) found while running an executable. See report file(s) for error message(s). Message log indicates which executable was run last.

Error (23031): Evaluation of Tcl script /opt/altera/17.1/quartus/common/tcl/internal/qsh_flow.tcl unsuccessful
Error: Quartus Prime Shell was unsuccessful. 3 errors, 2 warnings
    Error: Peak virtual memory: 1141 megabytes
    Error: Processing ended: Wed Apr 16 18:54:39 2025
    Error: Elapsed time: 00:00:09
    Error: Total CPU time (on all processors): 00:00:25

*/