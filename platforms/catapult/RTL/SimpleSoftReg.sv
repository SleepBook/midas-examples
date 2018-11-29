/*
Name: SimpleSoftReg.sv
Description: Converts UMI memory requests to SimpleDRAM memory requests. Simplifies flow control.

Copyright (c) Microsoft Corporation
 
All rights reserved. 
 
MIT License
 
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated 
documentation files (the ""Software""), to deal in the Software without restriction, including without limitation 
the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and 
to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
THE SOFTWARE IS PROVIDED *AS IS*, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE 
WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR 
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, 
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
 
import ShellTypes::*;

module SimpleSoftReg
(
    input                               clk,
    input                               rst,

    // Soft shell register interface    
    input                               softreg_read_in,
    input                               softreg_write_in,
    input  [31:0]                       softreg_addr_in,
    input  [63:0]                       softreg_wrdata_in,
    output logic [63:0]                 softreg_rddata_out,
    output logic                        softreg_rdvalid_out,

    // midas interface
    input                               io_softreg_req_ready,
    output                              io_softreg_req_valid,
    output  [31:0]                      io_softreg_req_bits_addr,
    output  [63:0]                      io_softreg_req_bits_wdata,
    output                              io_softreg_req_bits_wr,
    output                              io_softreg_resp_ready,
    input                               io_softreg_resp_valid,
    input [63:0]                        io_softreg_resp_bits_rdata
);

    wire        reqQ_enq;
    wire [96:0] reqQ_in;
    wire        reqQ_full;
    wire [96:0] reqQ_out;
    wire        reqQ_empty;
    reg         reqQ_deq;

    assign reqQ_in[96] = softreg_write_in;
    assign reqQ_in[95:64] = softreg_addr_in;
    assign reqQ_in[63:0] = softreg_wrdata_in;

    assign reqQ_enq = (softreg_read_in || softreg_write_in) && !reqQ_full;

    FIFO
    #(
        .WIDTH                  (97),
        .LOG_DEPTH              (8)
    )
    softRegReqQ
    (
        .clock                  (clk),
        .reset_n                (~rst),
        .wrreq                  (reqQ_enq),
        .data                   (reqQ_in),
        .full                   (reqQ_full),
        .q                      (reqQ_out),
        .empty                  (reqQ_empty),
        .rdreq                  (reqQ_deq)
    );

endmodule // SimpleSoftReg