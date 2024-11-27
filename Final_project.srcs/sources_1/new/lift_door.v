`timescale 1ns / 1ps
module lift_door (
    input clk, reset,
    input wire door_open_in,
    input wire door_close_in,
    input wire [3:0] current_floor,
    input wire [1:0] lift_stage, // 00 is stop, 01 is up, 10 is down
    input wire [1:0] sensor,
    output wire [3:0]door, // close 0, open 1
    output wire door_status // 0: close, 1: open
);
// 0 is car door, 1 is 1st floor door, 2 is 2nd floor door, 3 is 3rd floor door
// door_open_in higher priority than door_close_in
// sensor 0 is safe to close door after if door is open
reg [32:0] counter0;
reg [3:0] door_reg;
reg door_status_reg;

assign door = door_reg;
assign door_status = door_status_reg;

always @(posedge clk or posedge reset) begin
    if (reset == 1'b1) begin
        counter0 = 0;
        door_reg <= 4'b0000;
        door_status_reg <= 1'b0;
    end else begin
        if(door_open_in == 1'b1 && lift_stage == 2'b00) begin
            case(current_floor)
                4'b0001: door_reg <= 4'b0011;
                4'b0010: door_reg <= 4'b0101;
                4'b0011: door_reg <= 4'b1001;
                default: door_reg <= 4'b0000;
            endcase
            door_status_reg <= 1'b1;
        end else if(door_close_in == 1'b1 && sensor == 2'b00) begin
            door_reg <= 4'b0000;
            door_status_reg <= 1'b0;
        end else if(door_status_reg == 1'b1 && sensor == 2'b00) begin
            counter0 <= counter0 + 1;
            if(counter0 == 99) begin
                door_reg <= 4'b0000;
                door_status_reg <= 1'b0;
                counter0 <= 0;
            end
        end
    end
end
endmodule