module alu_tb;
reg [31:0] operand_a;
reg [31:0] operand_b;
reg [3:0] alu_op;
reg clk;
reg reset;
reg [31:0] instruction;
reg [31:0] reg_file [0:31];
wire [31:0] alu_result;

control_logic control_logic_instance (
    .clk(clk),
    .reset(reset),
    .instruction(instruction),
    .reg_file(reg_file),
    .alu_result(alu_result)
);

// Clock generation
always #5 clk = ~clk; // 10 time units clock period

initial begin
    // Initialize Inputs
    clk = 0;
    reset = 0;
    instruction = 32'b0;
    operand_a = 32'b0;
    operand_b = 32'b0;
    alu_op = 4'b0;

    // Initialize register file with some values
    reg_file[0] = 32'd0;
    reg_file[1] = 32'd10;
    reg_file[2] = 32'd20;
    reg_file[3] = 32'd30;
    //initialise all other registers of register file with some value
    // Apply reset
    reset = 1;
    #10 reset = 0;

  //ADD TEST CASES 

  
    $finish;
end

endmodule
