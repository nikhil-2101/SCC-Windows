module EX(1LD, Special_encoding, 2LD, ALU_OC, B_cond, dest_reg, pointer_reg, op_1_reg_value, op_2_reg_value, immediate, offset, flags, ALU_results )


    //just the outputs of decode 
    input wire [1:0]        1LD;                    
    input wire              Special_encoding;
    input wire [3:0]        2LD;
    input wire [2:0]        ALU_OC;
    input wire [3:0]        B_cond;
    input wire [2:0]        dest_reg;
    input wire [2:0]        pointer_reg;
    input wire [15:0]       op_1_reg_value;
    input wire [15:0]       op_2_reg_value;
    input wire [15:0]       immediate;
    input wire [15:0]       offset;
    input wire [3:0]        flags;

    output wire [15:0]      ALU_results

    
    // 3 Commands to implement Add_Immediate, Add_Regs, and NOP
    // module ALU

    if(Special_encoding)            // Ironically Special Encoding high means ALU so this is ALU FUNCTIONS
        begin
        case (ALU_OC[2:0])
            3'b001:                  // ADD Control Command
               // Retrieve dest_reg 
               // Retrieve op_1_reg
               
                if(1LD[0] == 1'b0)   // If first level decode lsb = 1 ---> Immediate is being used
                    begin
                       assign  ALU_results = op_1_reg_value + immediate;
                    end
                else                 // Else aka first level decode lsb = 0 ---> Register is being used
                    begin
                       assign  ALU_results = op_1_reg_value + op_2_reg_value;
                    end
            3'b010:                  // SUB Control Command
                if(1LD[0] == 1'b0)   // If first level decode lsb = 1 ---> Immediate is being used
                    begin
                       assign  ALU_results = op_1_reg_value - immediate;
                    end
                else                 // Else aka first level decode lsb = 0 ---> Register is being used
                    begin
                       assign  ALU_results = op_1_reg_value - op_2_reg_value;
                    end
            3'b011:                  // AND Control Command
                if(1LD[0] == 1'b0)   // If first level decode lsb = 1 ---> Immediate is being used
                    begin
                       assign ALU_results = op_1_reg_value & immediate;
                    end
                else                 // Else aka first level decode lsb = 0 ---> Register is being used
                    begin
                       assign ALU_results = op_1_reg_value & op_2_reg_value;
                    end
            3'b100:                  // OR Control Command
                if(1LD[0] == 1'b0)   // If first level decode lsb = 1 ---> Immediate is being used
                    begin
                       assign ALU_results = op_1_reg_value | immediate;
                    end
                else                 // Else aka first level decode lsb = 0 ---> Register is being used
                    begin
                       assign ALU_results = op_1_reg_value | op_2_reg_value;
                    end
            3'b101:                  // XOR Control Command
                if(1LD[0] == 1'b0)   // If first level decode lsb = 1 ---> Immediate is being used
                    begin
                       assign ALU_results = op_1_reg_value ^ immediate;
                    end
                else                 // Else aka first level decode lsb = 0 ---> Register is being used
                    begin
                       assign ALU_results = op_1_reg_value ^ op_2_reg_value;
                    end
            3'b110:                  // NOT Control Command
                if(1LD[0] == 1'b0)   // If first level decode lsb = 1 ---> Immediate is being used
                    begin
                       assign ALU_results = ~op_1_reg_value; 
                    end
                else                 // Else aka first level decode lsb = 0 ---> Register is being used
                    begin
                       assign ALU_results = ~op_1_reg_value;
                    end
        endcase
        end
    else if (1LD[1:0] = 2'b00)        //NON ALU FUNCTIONS With REG   ****LSL DOCUMENTATION IS WRONG LSL OP is 27-25 [1,0,0] not the same as mov****
        begin
        case (ALU_OC[2:0])
             3'b000:                  // MOV Command
            
             3'b001:                  // MOVT commands

             3'b100:                  //LSL

             3'b101:                  //LSR
             
             3'b010:                  //CLR

             3'b011:                  //SET

        end
    else                            //Branching and System calls deafult
        begin
            case (ALU_OC[2:0])
             3'b000:                  // Branch command   b
            
             3'b001:                  // Branch conditional

             3'b010:                  // Branch command br

             deafult:                  // NOP

        end


    endmodule   
    
