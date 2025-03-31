`timescale 1ns / 1ps

module dual_port_ram_tb;

    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 4;

    reg clk;
    reg we_a, we_b;
    reg [ADDR_WIDTH-1:0] addr_a, addr_b;
    reg [DATA_WIDTH-1:0] din_a, din_b;
    wire [DATA_WIDTH-1:0] dout_a, dout_b;

    dual_port_ram #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) uut (
        .clk(clk),
        .we_a(we_a),
        .we_b(we_b),
        .addr_a(addr_a),
        .addr_b(addr_b),
        .din_a(din_a),
        .din_b(din_b),
        .dout_a(dout_a),
        .dout_b(dout_b)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("dual_port_ram.vcd");
        $dumpvars(0, dual_port_ram_tb);

        clk = 0;
        we_a = 0;
        we_b = 0;
        addr_a = 0;
        addr_b = 0;
        din_a = 0;
        din_b = 0;

        // Write to Port A
        #10 we_a = 1; addr_a = 4; din_a = 8'hAA;
        #10 we_a = 0;  // Stop writing

        // Read from Port A
        #10 $display("Port A Read: Addr=%d, Data=%h", addr_a, dout_a);

        // Write to Port B
        #10 we_b = 1; addr_b = 6; din_b = 8'hBB;
        #10 we_b = 0;  // Stop writing

        // Read from Port B
        #10 $display("Port B Read: Addr=%d, Data=%h", addr_b, dout_b);

        // Simultaneous read after writing
        #10 addr_a = 4; addr_b = 6;
        #10 $display("Port A Read: Addr=%d, Data=%h", addr_a, dout_a);
        #10 $display("Port B Read: Addr=%d, Data=%h", addr_b, dout_b);

        #10 $finish;
    end

endmodule
