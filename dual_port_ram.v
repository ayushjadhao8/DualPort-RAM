module dual_port_ram #(
    parameter DATA_WIDTH = 8,  
    parameter ADDR_WIDTH = 4   
)(
    input  wire                    clk,
    input  wire                    we_a,  
    input  wire                    we_b,  
    input  wire [ADDR_WIDTH-1:0]    addr_a, 
    input  wire [ADDR_WIDTH-1:0]    addr_b, 
    input  wire [DATA_WIDTH-1:0]    din_a,  
    input  wire [DATA_WIDTH-1:0]    din_b,  
    output reg  [DATA_WIDTH-1:0]    dout_a, 
    output reg  [DATA_WIDTH-1:0]    dout_b  
);

    // Declare memory array
    reg [DATA_WIDTH-1:0] ram [0:(1<<ADDR_WIDTH)-1];

    always @(posedge clk) begin
        // Port A operations
        if (we_a) 
            ram[addr_a] <= din_a; // Write when enabled
        else 
            dout_a <= ram[addr_a]; // Read when not writing

        // Port B operations
        if (we_b) 
            ram[addr_b] <= din_b; // Write when enabled
        else 
            dout_b <= ram[addr_b]; // Read when not writing
    end

endmodule
