module liftdoor_control (
    input clk, reset,
    input internal_door_trigger,
    input [1:0] btn_door, door_sensor, direction,
    input [3:0] current_floor,
    output reg [3:0] lift_door
);
    // lift_door is high when the door is open
    // door 0 is car door
    // door 1 is 1st floor door
    // door 2 is 2nd floor door
    // door 3 is 3rd floor door
    
    // btn_door[0] is open btn, btn_door[1] is close btn
    integer i;
    always @(posedge clk or posedge reset) begin
        if (reset)
            lift_door <= 4'b0000;
        else if ((internal_door_trigger || btn_door[0]) && direction == 2'b00) begin
            if (door_sensor == 2'b00) begin
                case (current_floor)
                    4'b0001: lift_door <= 4'b0011;
                    4'b0010: lift_door <= 4'b0101;
                    4'b0011: lift_door <= 4'b1001;
                    default: lift_door <= 4'b0001;
                endcase
                // wait for 5 seconds or close btn is pressed to close the door
                for (i = 0; i < 500000000; i = i + 1) begin
                    @(posedge clk);
                    if (btn_door[1]) begin
                        lift_door <= 4'b0000;
                        i = 500000000;
                    end
                end
                if (!btn_door[1]) begin
                    lift_door <= 4'b0000;
                end
            end else begin
                // wait for 5 seconds
                repeat (500000000) @(posedge clk);
            end
        end
    end
endmodule