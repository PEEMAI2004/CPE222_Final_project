`timescale 1ns / 1ps
module Keypad_Decoder(
    input clk,                
    input [3:0] row,
    input reset,        
    output reg [3:0] col,    
    output reg [3:0] key,
    output reg isPressed    
    );
    // Count register
    reg [19:0] count;
    reg [32:0] timer;

    always @(posedge clk) begin
        if (reset) begin
            count <= 20'b0;
            isPressed <= 1'b0;
            timer <= 33'b0;
        end else begin
            case(count)
                20'b00011000011010100000: begin
                    //C1
                    col <= 4'b0111;
                    count <= count + 1;
                end
                
                // check row pins
                20'b00011000011010101000: begin
                    case (row)
                        4'b0111: key <= 4'b0001; // 1
                        4'b1011: key <= 4'b0100; // 4
                        4'b1101: key <= 4'b0111; // 7
                        4'b1110: key <= 4'b1111; // F
                    endcase
                    if (row != 4'b1111) begin
                        isPressed <= 1'b1;
                    end 
                    count <= count + 1;
                end

                // 2ms
                20'b00110000110101000000: begin
                    //C2
                    col <= 4'b1011;
                    count <= count + 1;
                end
                
                // check row pins
                20'b00110000110101001000: begin
                    case (row)
                        4'b0111: key <= 4'b0010; // 2
                        4'b1011: key <= 4'b0101; // 5
                        4'b1101: key <= 4'b1000; // 8
                        4'b1110: key <= 4'b0000; // 0
                    endcase
                    if (row != 4'b1111) begin
                        isPressed <= 1'b1;
                    end
                    count <= count + 1;
                end

                // 3ms
                20'b01001001001111100000: begin
                    //C3
                    col <= 4'b1101;
                    count <= count + 1;
                end
                
                // check row pins
                20'b01001001001111101000: begin
                    case (row)
                        4'b0111: key <= 4'b0011; // 3
                        4'b1011: key <= 4'b0110; // 6
                        4'b1101: key <= 4'b1001; // 9
                        4'b1110: key <= 4'b1110; // E
                    endcase
                    if (row != 4'b1111) begin
                        isPressed <= 1'b1;
                    end
                    count <= count + 1;
                end

                // 4ms
                20'b01100001101010000000: begin
                    //C4
                    col <= 4'b1110;
                    count <= count + 1;
                end

                // Check row pins
                20'b01100001101010001000: begin
                    case (row)
                        4'b0111: key <= 4'b1010; // A
                        4'b1011: key <= 4'b1011; // B
                        4'b1101: key <= 4'b1100; // C
                        4'b1110: key <= 4'b1101; // D
                    endcase
                    if (row != 4'b1111) begin
                        isPressed <= 1'b1;
                    end
                    count <= 20'b00000000000000000000;
                end

                // Otherwise increment
                default: begin
                    count <= count + 1;
                end
            endcase
        end

        // Timer for debouncing 1 second
        if (isPressed) begin
            if (timer < 100_000_000) begin
                timer <= timer + 1;
            end else begin
                timer <= 33'b0;
                isPressed <= 1'b0;
            end
        end else begin
            timer <= 33'b0;
        end
    end
endmodule