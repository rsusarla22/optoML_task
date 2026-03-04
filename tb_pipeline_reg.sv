`timescale 1ns / 1ps

 module tb_pipeline_reg;
    parameter DATA_WIDTH = 8;
    
    logic clk;
    logic rst_n;
    logic [DATA_WIDTH-1:0] data_in;
    logic in_valid;
    logic in_ready;
    logic [DATA_WIDTH-1:0] data_out;
    logic out_valid;
    
    pipeline_reg #(
        .DATA_WIDTH(DATA_WIDTH)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(data_in),
        .in_valid(in_valid),
        .in_ready(in_ready),
        .data_out(data_out),
        .out_valid(out_valid)
    );
    
    always #5 clk = ~clk;
    
    initial begin
    
        clk = 0;
        rst_n = 0;
        data_in = 0;
        in_valid = 0;
        in_ready = 0;
    
        repeat(2) @(posedge clk);
        rst_n = 1;
    
        @(posedge clk);
    
        // Test-1: valid=1, ready=1
        // data_out should be 57, then next clock cycle 20
        in_valid = 1;
        in_ready = 1;
        data_in  = 8'd57;
        @(posedge clk);
        data_in  = 8'd20;
        @(posedge clk);
     
        // Test-2: valid=1, ready=0
        // data_out should remain at 20
        in_ready = 0;
        data_in  = 8'd35;
        @(posedge clk);

        // Test-3: valid=0, ready=1
        // data_out should remain at 20
        in_ready = 1;
        in_valid = 0;
        data_in  = 8'd40;
        @(posedge clk);
    
        // Test-4: valid=1, ready=1 (back to data transfer)
        // data_out should change to 50
        in_valid = 1;
        data_in  = 8'd50;
        repeat(3) @(posedge clk);
    
        $finish;
    
    end
    
 endmodule