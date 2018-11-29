/*
Name: SimpleRole.sv
Description: Catapult PCIe loopback test, demonstrates basic Catapult functionality

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
import SL3Types::*;

module SimpleRole
(
    // User clock and reset
    input                               clk,
    input                               rst, 

    // Simplified Memory interface
    output MemReq                       mem_reqs        [1:0],
    input                               mem_req_grants  [1:0],
    input MemResp                       mem_resps       [1:0],
    output                              mem_resp_grants [1:0],

    // PCIe Slot DMA interface
    input PCIEPacket                    pcie_packet_in,
    output                              pcie_full_out,

    output PCIEPacket                   pcie_packet_out,
    input                               pcie_grant_in,

    // Soft shell register interface    
    input                               softreg_read_in,
    input                               softreg_write_in,
    input  [31:0]                       softreg_addr_in,
    input  [63:0]                       softreg_wrdata_in,
    output logic [63:0]                 softreg_rddata_out,
    output logic                        softreg_rdvalid_out,
    
    // SerialLite III interface
    output SL3DataInterface             sl_tx_out           [3:0],
    input                               sl_tx_full_in       [3:0],
    output SL3OOBInterface              sl_tx_oob_out       [3:0],
    input                               sl_tx_oob_full_in   [3:0],

    input SL3DataInterface              sl_rx_in            [3:0],
    output                              sl_rx_grant_out     [3:0],
    input SL3OOBInterface               sl_rx_oob_in        [3:0],
    output                              sl_rx_oob_grant_out [3:0]
);
    
    // Disable DRAM
    assign mem_reqs[0] = '{valid: 1'b0, isWrite: 1'b0, addr: 64'b0, data: 512'b0};
    assign mem_resp_grants[0] = 1'b0;
    assign mem_reqs[1] = '{valid: 1'b0, isWrite: 1'b0, addr: 64'b0, data: 512'b0};
    assign mem_resp_grants[1] = 1'b0;
    
    // Disable SL3
    genvar i;
    generate
        for(i = 0; i < 4; i=i+1) begin: disableSL3
            assign sl_tx_out[i] = '{valid: 1'b0, data: 128'b0, last: 1'b0};
            assign sl_tx_oob_out[i] = '{valid: 1'b0, data: 15'b0};
            
            assign sl_rx_grant_out[i] = 1'b0;
            assign sl_rx_oob_grant_out[i] = 1'b0;
        end
    endgenerate

    //Disable PCIe stream
    assign pcie_packet_out = '{valid: 1'b0, data: 128'b0, slot: 6'b0, pad: 4'b0, last: 1'b0};
    assign pcie_full_out = 1'b0;

    // wire       loopbackQ_enq;
    // PCIEPacket loopbackQ_in;
    // wire       loopbackQ_full;
    // PCIEPacket loopbackQ_out;
    // wire       loopbackQ_empty;
    // wire       loopbackQ_deq;
    
    // assign loopbackQ_enq = pcie_packet_in.valid && !loopbackQ_full;
    // assign loopbackQ_in = pcie_packet_in;
    // assign loopbackQ_deq = !loopbackQ_empty && pcie_grant_in;
    
    // assign pcie_packet_out = '{valid: !loopbackQ_empty, data: loopbackQ_out.data, slot: loopbackQ_out.slot, pad: loopbackQ_out.pad, last: loopbackQ_out.last};
    // assign pcie_full_out = loopbackQ_full;
    
    // always@(negedge clk) begin
    
    //     if(pcie_packet_in.valid) begin
    //         $display("%0d: PCIe packet incoming slot %0d data %x last %d", $time, pcie_packet_in.slot, pcie_packet_in.data, pcie_packet_in.last);
    //     end
    // end
    
    // FIFO
    // #(
    //     .WIDTH     ($bits(PCIEPacket)),
    //     .LOG_DEPTH (9)
    // )
    // LoopbackQ
    // (
    //     .clock     (clk),
    //     .reset_n   (~rst),
    //     .wrreq     (loopbackQ_enq),
    //     .data      (loopbackQ_in),
    //     .full      (loopbackQ_full),
    //     .q         (loopbackQ_out),
    //     .empty     (loopbackQ_empty),
    //     .rdreq     (loopbackQ_deq)
    // );

    interplay_top i_interplay_top
    (
        .clock(clk),
        .reset(rst),

        .softreg_read_in(softreg_read_in),
        .softreg_write_in(softreg_write_in),
        .softreg_addr_in(softreg_addr_in),
        .softreg_wrdata_in(softreg_wrdata_in),
        .softreg_rddata_out(softreg_rddata_out),
        .softreg_rdvalid_out(softreg_rdvalid_out)
    );
    
endmodule
