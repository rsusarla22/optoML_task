`timescale 1ns / 1ps

 module pipeline_reg #(
        parameter DATA_WIDTH = 8
 )(
        input logic clk, 
        input logic rst_n, 
        
        input logic [DATA_WIDTH-1:0] data_in,
        input logic in_valid, 
        input logic in_ready,
        
        output logic [DATA_WIDTH-1:0] data_out, 
        output logic out_valid
    );
    
    always_ff @(posedge clk or negedge rst_n) begin
        // reset condition 
        if(!rst_n) begin 
            data_out <= '0; 
            out_valid <= 0; 
        end else begin  
        // data transfer when in_ready & in_valid are HIGH and set out_valid for one clock cycle
            if(in_ready && in_valid) begin 
                data_out <= data_in;
                out_valid <= 1;
            end else begin 
                out_valid <= 0;
            end
        end     
    end 

 endmodule
