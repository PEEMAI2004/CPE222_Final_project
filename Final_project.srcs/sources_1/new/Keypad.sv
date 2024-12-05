module Keypad_Decoder(
    input clk,
    input [3:0] row,
    input reset,
    output reg [3:0] col,
    output reg [3:0] key_out,
    output reg isPressed
);
reg [19:0] count;
reg pressed_flag;

always @(posedge clk) begin
    if (reset) begin
        count <= 20'b00000000000000000000;
        col <= 4'b1111;
        key_out <= 4'b1111;
        isPressed <= 0;
        pressed_flag <= 0;
    end
    // 1ms
    if (count == 20'b00011000011010100000) begin
        //C1
        col <= 4'b0111;
        count <= count + 1'b1;
    end
    
    // check row pins
    else if(count == 20'b00011000011010101000) begin
        //R1
        if (row == 4'b0111) begin
            key_out <= 4'b0001;		//1
        end
        //R2
        else if(row == 4'b1011) begin
            key_out <= 4'b0100; 		//4
        end
        //R3
        else if(row == 4'b1101) begin
            key_out <= 4'b0111; 		//7
        end
        //R4
        else if(row == 4'b1110) begin
            key_out <= 4'b0000; 		//0
        end
        if (row != 4'b1111) begin
            pressed_flag <= 1;
        end
        count <= count + 1'b1;
    end

    // 2ms
    else if(count == 20'b00110000110101000000) begin
        //C2
        col<= 4'b1011;
        count <= count + 1'b1;
    end
    
    // check row pins
    else if(count == 20'b00110000110101001000) begin
        //R1
        if (row == 4'b0111) begin
            key_out <= 4'b0010; 		//2
        end
        //R2
        else if(row == 4'b1011) begin
            key_out <= 4'b0101; 		//5
        end
        //R3
        else if(row == 4'b1101) begin
            key_out <= 4'b1000; 		//8
        end
        //R4
        else if(row == 4'b1110) begin
            key_out <= 4'b1111; 		//F
        end
        if (row != 4'b1111) begin
            pressed_flag <= 1;
        end
        count <= count + 1'b1;
    end

    //3ms
    else if(count == 20'b01001001001111100000) begin
        //C3
        col<= 4'b1101;
        count <= count + 1'b1;
    end
    
    // check row pins
    else if(count == 20'b01001001001111101000) begin
        //R1
        if(row == 4'b0111) begin
            key_out <= 4'b0011; 		//3	
        end
        //R2
        else if(row == 4'b1011) begin
            key_out <= 4'b0110; 		//6
        end
        //R3
        else if(row == 4'b1101) begin
            key_out <= 4'b1001; 		//9
        end
        //R4
        else if(row == 4'b1110) begin
            key_out <= 4'b1110; 		//E
        end
        if (row != 4'b1111) begin
            pressed_flag <= 1;
        end
        count <= count + 1'b1;
    end

    //4ms
    else if(count == 20'b01100001101010000000) begin
        //C4
        col<= 4'b1110;
        count <= count + 1'b1;
    end

    // Check row pins
    else if(count == 20'b01100001101010001000) begin
        //R1
        if(row == 4'b0111) begin
            key_out <= 4'b1010; //A
        end
        //R2
        else if(row == 4'b1011) begin
            key_out <= 4'b1011; //B
        end
        //R3
        else if(row == 4'b1101) begin
            key_out <= 4'b1100; //C
        end
        //R4
        else if(row == 4'b1110) begin
            key_out <= 4'b1101; //D
        end
        if (row != 4'b1111) begin
            pressed_flag <= 1;
        end
        count <= 20'b00000000000000000000;
    end 
    // check if the key is pressed or not
    else if (count == 20'b00000000000000000000) begin
        if (pressed_flag == 1) begin
            isPressed <= 1;
        end else begin
            isPressed <= 0;
        end
        pressed_flag <= 0;
        count <= count + 1'b1;
    end
    
    else begin
        count <= count + 1'b1;
    end	
end
endmodule