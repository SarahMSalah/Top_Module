module Top_Module (                         //Top_Module input & output ports
input wire [7:0] DATA,
input wire WR_EN, RD_EN, 
input wire CLK, RST,
output wire SER_OUT        
//driven by another module’s output
//it must be declared as a wire in the top module.
);

wire [7:0] REG0, REG1, REG2, Enc_out;       //internal connections 

REG_FILE U_regfile (
.rst(RST),                    // connected to top module input port "RST"
.clk(CLK),                    // connected to top module input port "CLK"
.data(DATA),                  // connected to top module input port "DATA"
.wr_en(WR_EN),                // connected to top module input port "WR_EN"
.rd_en(RD_EN),                // connected to top module input port "RD_EN"
.reg0(REG0),                  // connected to encoder
.reg1(REG1),                  // connected to encoder
.reg2(REG2)                   // connected to serializer
);

ENCODER U_encoder (
.rst(RST),                    // connected to top module input port "RST"
.clk(CLK),                    // connected to top module input port "CLK"
.data(DATA),                  // connected to top module input port "DATA"
.reg0(REG0),                  // connected to register file
.reg1(REG1),                  // connected to register file
.encoded_out(Enc_out)         // connected to serializer
); 

SERIALIZER U_serializer (
.rst(RST),                    // connected to top module input port "RST"
.clk(CLK),                    // connected to top module input port "CLK"
.reg2(REG2),                  // connected to register file
.ser_in(Enc_out),             // connected to encoder
.ser_out(SER_OUT)             // connected to top module output port "SER_OUT"
); 

endmodule
