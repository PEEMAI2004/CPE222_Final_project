module lift_controller(
    input reset,
    input clk, // 100 MHz clock for 7-segment display
    // Input from button panels
    input [1:0] btn_call_up_floor, btn_call_down_floor, btn_door,
    input [3:0] btn_select_floor,
    // Output to button panels (LED control)
    output [1:0] led_btn_call_up_floor, led_btn_call_down_floor, led_btn_door,
    output [3:0] led_btn_select_floor,
    // Input from door sensor
    input [1:0] door_sensor,
    // Output to doors
    output reg [3:0] lift_door,
    // Input from access control system
    input access_control_system,
    // Outputs for 7-segment display (current floor)
    output [6:0] seg,
    output [3:0] anode
);

    // Registers for current and target floors
    reg [3:0] current_floor = 4'b0010; // 0010 = 1st floor, 0100 = 2nd floor, 1000 = 3rd floor
    reg [3:0] primary_target_floor = 4'b0000; // 0010 = 1st floor, 0010 = 2nd floor, 0010 = 3rd floor
    reg [3:0] secondary_target_floor = 4'b0000; // 0010 = 1st floor, 0010 = 2nd floor, 0010 = 3rd floor
    reg [1:0] direction = 2'b00; // 00 = stop, 01 = up, 10 = down

    // Signals for LED resets
    reg [1:0] call_button_up_led_reset = 2'b00;
    reg [1:0] call_button_down_led_reset = 2'b00;
    reg [3:0] floor_button_led_reset = 4'b0000;
    reg [1:0] door_button_led_reset = 2'b00; // Added for door LED control

    // Button signals processed from `lift_buttons`
    wire [1:0] call_button_up_out, call_button_down_out;
    wire [3:0] floor_select_button_out;
    wire [1:0] door_button_out;

    // Instance of `lift_buttons`
    lift_buttons lift_buttons_inst (
        .reset(reset),
        .btn_call_up_floor(btn_call_up_floor),
        .btn_call_down_floor(btn_call_down_floor),
        .btn_select_floor(btn_select_floor),
        .btn_door(btn_door),
        .call_button_up_led_reset(call_button_up_led_reset),
        .call_button_down_led_reset(call_button_down_led_reset),
        .floor_button_led_reset(floor_button_led_reset),
        .door_button_led_reset(door_button_led_reset), // Connect door LED reset
        .led_btn_call_up_floor(led_btn_call_up_floor),
        .led_btn_call_down_floor(led_btn_call_down_floor),
        .led_btn_select_floor(led_btn_select_floor),
        .led_btn_door(led_btn_door),
        .call_button_up_out(call_button_up_out),
        .call_button_down_out(call_button_down_out),
        .floor_select_button_out(floor_select_button_out),
        .door_button_out(door_button_out)
    );

    // Logic to handle lift movement, door, and LED resets
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_floor <= 4'b0010; // Start at 1st floor
            primary_target_floor <= 4'b0000;
            lift_door <= 4'b0000; // All doors closed
            call_button_up_led_reset <= 2'b00;
            call_button_down_led_reset <= 2'b00;
            floor_button_led_reset <= 4'b0000;
            door_button_led_reset <= 2'b00; // Reset door LEDs
            direction <= 2'b00; // Stop lift
        end else begin
            // reset call button, floor button if the lift is at the target floor
            
            // Floor button logic
            // assign to target floor
            if (floor_select_button_out[0]) begin
                primary_target_floor[1] <= 1'b1; // Set target floor to 1st floor
                led_btn_select_floor[0] <= 1'b1; // Turn on LED for 1st floor button
                end
            if (floor_select_button_out[1]) begin
                primary_target_floor[2] <= 1'b1; // Set target floor to 2nd floor
                led_btn_select_floor[1] <= 1'b1; // Turn on LED for 2nd floor button
                end
            if (floor_select_button_out[2]) begin
                primary_target_floor[3] <= 1'b1; // Set target floor to 3rd floor
                led_btn_select_floor[2] <= 1'b1; // Turn on LED for 3rd floor button
                end

            // Call button logic
            // assing to target floor
            if (call_button_up_out[0]) begin
                primary_target_floor[1] <= 1'b1; // Set target floor to 1st floor
                led_btn_call_up_floor[0] <= 1'b1; // Turn on LED for 1st floor call button
                end
            if (call_button_up_out[1]) begin
                primary_target_floor[2] <= 1'b1; // Set target floor to 2nd floor
                led_btn_call_up_floor[1] <= 1'b1; // Turn on LED for 2nd floor call button
                end
            if (call_button_down_out[0]) begin
                primary_target_floor[1] <= 1'b1; // Set target floor to 1st floor
                led_btn_call_down_floor[0] <= 1'b1; // Turn on LED for 1st floor call button
                end
            if (call_button_down_out[1]) begin
                primary_target_floor[0] <= 1'b1; // Set target floor to 3rd floor
                led_btn_call_down_floor[1] <= 1'b1; // Turn on LED for 3rd floor call button
                end
            
                
        end
    end

    // Instance of `seven_seg_anode_control` to display the current floor
    seven_seg_anode_control display_floor (
        .clk(clk),
        .number({5'b0, (current_floor + 1'b1)}), // Display floors as 1, 2, 3
        .seg(seg),
        .anode(anode)
    );

endmodule
