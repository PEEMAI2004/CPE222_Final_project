module lift_controller (
    input clk, reset,

    // Input all the buttons
    input [1:0] btn_door, btn_call_up_floor, btn_call_down_floor,
    input [3:1] btn_select_floor,

    // Input sensor signal
    input [1:0] door_sensor,

    // Output direction LED
    output reg [1:0] direction_led,

    // Output LED signals for the buttons
    output reg [1:0] led_btn_door, led_btn_call_up_floor, led_btn_call_down_floor,
    output reg [3:1] led_btn_select_floor,

    // Output lift door signal
    output reg [3:1] lift_door,

    // Output 7-segment display
    output [6:0] seg,
    output [3:0] anode
);

    // Define the current floor
    // 1 is the first floor, 3 is the top floor
    reg [3:0] current_floor;

    // Define the direction
    reg [1:0] direction; // 00 = stop, 01 = up, 10 = down

    // State machine states
    localparam IDLE = 3'b000;
    localparam MOVING_UP = 3'b001;
    localparam MOVING_DOWN = 3'b010;
    localparam DOOR_OPENING = 3'b011;
    localparam DOOR_CLOSING = 3'b100;

    reg [2:0] current_state, next_state;

    // Instantiate the lift_buttons module
    lift_buttons lift_buttons_inst (
        .btn_door(btn_door),
        .btn_call_up_floor(btn_call_up_floor),
        .btn_call_down_floor(btn_call_down_floor),
        .btn_select_floor(btn_select_floor),
        .led_btn_door(led_btn_door),
        .led_btn_call_up_floor(led_btn_call_up_floor),
        .led_btn_call_down_floor(led_btn_call_down_floor),
        .led_btn_select_floor(led_btn_select_floor)
    );

    // Instantiate the seven_seg_anode_control module
    seven_seg_anode_control seven_seg_anode_control_inst (
        .clk(clk),
        .number(current_floor),
        .seg(seg),
        .anode(anode)
    );

    // Instantiate the direction_display module
    direction_display direction_display_inst (
        .clk(clk),
        .reset(reset),
        .direction(direction),
        .led(direction_led)
    );

    // Instantiate the lift_door module
    liftdoor_control lift_door_inst (
        .clk(clk),
        .reset(reset),
        .internal_door_trigger(x),
        .btn_door(btn_door),
        .door_sensor(door_sensor),
        .direction(direction),
        .current_floor(current_floor),
        .lift_door(lift_door)
    );

    // Sequential logic for the current state
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            current_floor <= 4'b0001; // Start at floor 1
            direction <= 2'b00; // Stop
            led_btn_door <= 2'b00;
            led_btn_call_up_floor <= 2'b00;
            led_btn_call_down_floor <= 2'b00;
            led_btn_select_floor <= 4'b0000;
            lift_door <= 4'b0000;
        end else begin
            current_state <= next_state;
        end
    end

    

endmodule
