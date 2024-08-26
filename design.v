module alu (
    input [31:0] operand_a,
    input [31:0] operand_b,
    input [3:0] alu_op,
    output reg [31:0] result
);

always @(*) begin
    case (alu_op)
        4'b0000: result = operand_a + operand_b; // ADD
        4'b0001: result = operand_a - operand_b; // SUB
        4'b0010: result = operand_a & operand_b; // AND
        4'b0011: result = operand_a | operand_b; // OR
        4'b0100: result = operand_a ^ operand_b; // XOR
        4'b0101: result = operand_a << operand_b[4:0]; // SLL
        4'b0110: result = operand_a >> operand_b[4:0]; // SRL
        4'b0111: result = $signed(operand_a) >>> operand_b[4:0]; // SRA
        4'b1000: begin   // SLT OPERATION
          if ($signed(operand_a) < $signed(operand_b))
                    result = 32'b1;
                else
                    result = 32'b0; 
                 end
        4'b1001: begin // SLTU OPERATION
          if (operand_a < operand_b)
                    result = 32'b1;
                else
                    result = 32'b0;
        end
        default: result = 32'b0;
    endcase
end

endmodule

module control_logic (
    input clk,
    input reset,
    input [31:0] instruction, // Input instruction
    input [31:0] reg_file [0:31], // Register file
    output reg [31:0] alu_result // Output ALU result
);

reg [31:0] fetch_instruction;
reg [4:0] decode_rd, decode_rs1, decode_rs2;
reg [31:0] decode_operand_a, decode_operand_b;
reg [31:0] decode_imm_operand;
reg [3:0] decode_alu_operation;
reg [6:0] decode_opcode;

reg [31:0] execute_operand_a, execute_operand_b;
reg [3:0] execute_alu_operation;
reg [7:0] execute_opcode;
wire [31:0] execute_result;

// Instantiate ALU
alu alu_instance (
    .operand_a(execute_operand_a),
    .operand_b(execute_operand_b),
    .alu_op(execute_alu_operation),
    .result(execute_result)
);

// Fetch Stage
always @(posedge clk or posedge reset) begin
    if (reset) begin
        fetch_instruction <= 32'b0;
    end else begin
        fetch_instruction <= instruction; // Fetch the instruction
    end
end

// Decode Stage
always @(posedge clk or posedge reset) begin
    if (reset) begin
        decode_rd <= 5'b0;
        decode_rs1 <= 5'b0;
        decode_rs2 <= 5'b0;
        decode_operand_a <= 32'b0;
        decode_operand_b <= 32'b0;
      	decode_opcode <= 7'b0;
        decode_alu_operation <= 4'b0;
    end else begin
      case(fetch_instruction[6:0])
        7'b0110011 : begin decode_rd <= fetch_instruction[11:7];     //opcode for R type instruction
       	                   decode_rs1 <= fetch_instruction[19:15];
                           decode_rs2 <= fetch_instruction[24:20];
                           decode_opcode <= fetch_instruction[6:0];
       						
                     // Fetch operands from register file
                     decode_operand_a <= reg_file[decode_rs1];
                     decode_operand_b <= reg_file[decode_rs2];
             
                     // Determinining ALU operation resgister to register operation
                       case (fetch_instruction[14:12])  //checking funct3 from instruction
                         3'b000: begin
                                   if (fetch_instruction[31:25] == 7'b0000000)  //checking funct7 for funct3 = 3'b000
                                      decode_alu_operation <= 4'b0000; // ADD OPERATION
                                   else if (fetch_instruction[31:25] == 7'b0100000)
                                      decode_alu_operation <= 4'b0001; // SUB OPERATION
                                 end
                         3'b111: decode_alu_operation <= 4'b0010; // AND OPERATION
                         3'b110: decode_alu_operation <= 4'b0011; // OR OPERATION
                         3'b100: decode_alu_operation <= 4'b0100; // XOR OPERATION
                         3'b001: decode_alu_operation <= 4'b0101; // SLL OPERATION
                         3'b010: decode_alu_operation <= 4'b1000; //SLT OPERATION
                         3'b011: decode_alu_operation <= 4'b1001; //SLTU OPERATION
                         3'b101: begin
                                   if (fetch_instruction[31:25] == 7'b0000000)   //Again checking funct7 for funct3 = 3'b101
                                     decode_alu_operation <= 4'b0110; // SRL OPERATION
                                   else if (fetch_instruction[31:25] == 7'b0100000)
                                       decode_alu_operation <= 4'b0111; // SRA OPERATION
                                 end
                      endcase
                end
        7'b0010011 : begin decode_rd <= fetch_instruction[11:7];    //opcode for I type(immidiate)instructions
                           decode_rs1 <= fetch_instruction[19:15];  //first operand that is stored in specified register
          				   decode_rs2 <= 5'b0;
                           decode_opcode <= fetch_instruction[6:0];
          
                           // Fetch operands from register file
                           decode_operand_a <= reg_file[decode_rs1];
                           decode_operand_b <= fetch_instruction[31:20];  //second operand is embedded on instruction
          
                           // Determinining ALU operation resgister to immidiate operation
                           case (fetch_instruction[14:12])  //checking funct3 from instruction
                             3'b000 : begin
                                       if(fetch_instruction[31:25] == 7'b0000000)
                                        decode_alu_operation <= 4'b0000; // ADD OPERATION
                                       else if(fetch_instruction[31:25] == 7'b0100000)
                                        decode_alu_operation <= 4'b0001; // SUB OPERATION 
                                      end
                             3'b001 : decode_alu_operation <= 4'b0101; // SLL OPERATION
                             3'b010 : decode_alu_operation <= 4'b1000; // SLT OPERATION
                             3'b011 : decode_alu_operation <= 4'b1001; // SLTU OPERATION
                             3'b100 : decode_alu_operation <= 4'b0100; // XOR OPERATION
                             3'b110 : decode_alu_operation <= 4'b0011; // OR OPERATION
                             3'b111 : decode_alu_operation <= 4'b0010; // AND OPERATION
                             3'b101 : begin
                               if(fetch_instruction[31:25] == 7'b0000000)
                                 decode_alu_operation <= 4'b0110; // SRL OPERATION
                               else if(fetch_instruction[31:25] == 7'b0100000)
                                  decode_alu_operation <= 4'b0111; // SRA OPERATION 
                             end
                           endcase
                      end
        endcase
    end
end

// Execute Stage
always @(posedge clk or posedge reset) begin
    if (reset) begin
        execute_operand_a <= 32'b0;
        execute_operand_b <= 32'b0;
        execute_alu_op <= 3'b0;
    end else begin
        execute_operand_a <= decode_operand_a;
        execute_operand_b <= decode_operand_b;
        execute_alu_operation <= decode_alu_operation;
      	execute_opcode <= decode_opcode;
    end
end

// Write back the result
always @(posedge clk or posedge reset) begin
    if (reset) begin
        alu_result <= 32'b0;
    end else begin
        alu_result <= execute_result;
    end
end

endmodule
