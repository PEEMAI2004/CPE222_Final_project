module lift_controller (
    input wire clk, reset,
    // I/O
    input [1:0] door_sensor,
    input [1:0] btn_door, btn_call_up_floor, btn_call_down_floor,
    input [3:1] btn_select_floor,
    input emergency_stop, debug, show_key,
    // Access control
    input access_control_bypass, 
    input [7:0] JC,
    output led_access_control_status,
    output reg led_keypad_status,
    output wire [1:0] led_btn_door, led_btn_call_up_floor, led_btn_call_down_floor,
    output [3:1] led_btn_select_floor,
    output reg [3:1] led_floor_request,
    output [1:0] direction_led,
    output [6:0] seg,
    output [3:0] anode,
    output reg [3:0] lift_door,
    output reg arrival_notification,
    output reg [1:0] direction_led_panel, door_sensor_led_panel
);

// Define states
typedef enum logic [3:0] {
    IDLE = 4'b0000,
    MOVING_UP = 4'b0001,
    MOVING_DOWN = 4'b0010,
    DOOR_OPEN = 4'b0011,
    DOOR_CLOSED = 4'b0100,
    EMERGENCY_STOP = 4'b0101
} state_t;

state_t current_state, next_state;

// Store values for state machine
reg [3:0] current_floor;
// reg [1:0] lift_stage;
reg direction_control_activation;
reg [1:0] direction;
reg emergency_stopped;
reg [32:0] door_timer;
reg [32:0] moving_timer;

reg [13:0] display_number;

wire [1:0] target_floor;
wire [1:0] next_direction;

// Floor request register
wire [3:1] requests;       // lift service 3 floors 1st, 2nd, 3rd
wire [3:1] request_remove; // remove request from register

// // Signal form door
// wire door_status;
// // Signal to door
// reg [1:0] door_signal;
// Signal from panel button
wire [1:0] btn_door_signal, btn_call_up_floor_signal, btn_call_down_floor_signal;
wire [3:1] btn_select_floor_signal;
// Signal to panel led to turn off
reg [1:0] led_btn_door_off, led_btn_call_up_floor_off, led_btn_call_down_floor_off;
reg [3:1] led_btn_select_floor_off;

// Access control

wire [6:0] seg_access_control;
wire [3:0] anode_access_control;
wire access_control_status;
wire keypad_status;
wire reset_access_control;
wire [3:0] keypad_key;

// Access control module
Accesscontrol access_control1(
    .clk(clk),
    .reset(reset_access_control),
    .JC(JC),
    .seg(seg_access_control),
    .anode(anode_access_control),
    .accesscontrol(access_control_status),
    .keypad_status(keypad_status),
    .keypad_key(keypad_key)
);

// Init modules
lift_button_panel panels1(
    .reset(reset),
    // Button inputs
    .btn_door(btn_door),
    .btn_call_up_floor(btn_call_up_floor),
    .btn_call_down_floor(btn_call_down_floor),
    .btn_select_floor(btn_select_floor),
    // Button led off
    .btn_door_led_off(led_btn_door_off),
    .btn_call_up_floor_led_off(led_btn_call_up_floor_off),
    .btn_call_down_floor_led_off(led_btn_call_down_floor_off),
    .btn_select_floor_led_off(led_btn_select_floor_off),
    // Button led
    .btn_door_led(led_btn_door),
    .btn_call_up_floor_led(led_btn_call_up_floor),
    .btn_call_down_floor_led(led_btn_call_down_floor),
    .btn_select_floor_led(led_btn_select_floor),
    // Signal outputs
    .btn_door_out(btn_door_signal),
    .btn_call_up_floor_out(btn_call_up_floor_signal),
    .btn_call_down_floor_out(btn_call_down_floor_signal),
    .btn_select_floor_out(btn_select_floor_signal),
    // Access control
    .access_control(access_control_status),
    .access_control_by_pass(access_control_bypass),
    .led_access_control_status(led_access_control_status),
    .reset_access_control(reset_access_control),
    .current_state(current_state)
);

// 7-segment displays
seven_seg_anode_control display1(
    .clk(clk),
    .number(display_number), // Display current floor
    .debug(debug),
    .seg(seg),
    .an(anode)
);

direction_display direction1(
    .clk(clk),
    .reset(reset),
    .direction(direction),
    .led(direction_led)
);

floor_register register1(
    .clk(clk),
    .reset(reset),
    // Button signals0
    .btn_call_up_floor_signal(btn_call_up_floor_signal),
    .btn_call_down_floor_signal(btn_call_down_floor_signal),
    .btn_select_floor_signal(btn_select_floor_signal),
    // Signal to remove floor request from register
    .floor_remove(request_remove),
    // Register output
    .floor_request(requests),
    .floor_request_led(led_floor_request)
);

// Direction control module
direction_control direction_control1(
    .activation(direction_control_activation),
    .current_floor(current_floor),
    .current_direction(direction),
    .next_direction(next_direction),
    .requests(requests),
    .request_remove(request_remove),
    .target_floor(target_floor),
    // Turn off led on button panel
    .led_btn_select_floor_off(led_btn_select_floor_off),
    .led_btn_call_down_floor_off(led_btn_call_down_floor_off),
    .led_btn_call_up_floor_off(led_btn_call_up_floor_off)
);

// Initialize state
initial begin
    current_state = IDLE;
    current_floor = 4'b0001;
    direction_control_activation = 1'b0;
    // door_signal = 2'b00;
    // lift_stage = 2'b00;
    direction = 2'b00;
    emergency_stopped = 1'b0;
    door_timer = 32'b0;
    lift_door <= 4'b0000;
end

// State transition logic
always @(posedge clk) begin
    if (reset) begin
        current_state <= IDLE;
        current_floor <= 4'b0001;
        // lift_stage <= 2'b00;
        direction_control_activation <= 1'b0;
        direction <= 2'b00;
        emergency_stopped <= 1'b0;
        door_timer <= 32'b0;
        lift_door <= 4'b0000;
    end else begin
        current_state <= next_state;
    end

    // Emergency stop
    if (emergency_stop) begin
        current_state = EMERGENCY_STOP;
    end

    // Default next state
    // next_state = current_state;
    direction = next_direction;

    // Display Number
    if (debug) begin
        display_number = current_floor + current_state * 10 + next_direction * 100 +  target_floor * 1000; 
    end else if (show_key) begin
        display_number = keypad_key;
    end else begin
        display_number = current_floor;
    end

    case (current_state)
        IDLE: begin // 0
            door_timer = 32'b0;
            if (btn_door_signal[0] == 1'b1) begin
                next_state = DOOR_OPEN; // Open door when stationary
                // Turn off led on door button, button panel   
                led_btn_door_off = 2'b11; // Turn signal on
                #100;
                led_btn_door_off = 2'b00; // Trun back the signal
            end else if (request_remove == current_floor) begin // If the button same as current floor is pressed
                next_state = DOOR_OPEN;
            end else if (requests != 3'b0) begin
                case (next_direction)
                    2'b00: next_state = IDLE;        // Stay stationary
                    2'b01: next_state = MOVING_UP;   // Move up
                    2'b10: next_state = MOVING_DOWN; // Move down
                endcase
            end
        end
        MOVING_UP: begin // 1
            direction = 2'b01;
            if (current_floor < target_floor) begin // top floor is 3rd
                if (moving_timer < 500000000) begin
                    moving_timer = moving_timer + 1;
                end else begin
                    current_floor = current_floor + 1;
                    moving_timer = 32'b0;
                end
            end
            // current_floor <= current_floor + 1;
            if (current_floor == target_floor) begin
                next_state = DOOR_OPEN; // Open door when at target floor
            end
        end
        MOVING_DOWN: begin // 2
            direction = 2'b10;
            if (current_floor > target_floor && target_floor != 0) begin // bottom floor is 1st
                if (moving_timer < 500000000) begin
                    moving_timer = moving_timer + 1;
                end else begin
                    current_floor = current_floor - 1;
                    moving_timer = 32'b0;
                end
            end
            if (current_floor == target_floor) begin
            next_state = DOOR_OPEN; // Open door when at target floor
            end
        end
        DOOR_OPEN: begin // 3
            arrival_notification = 1'b1;
            // wait for 1 second before opening the door
            if (door_timer < 100000000) begin
            door_timer = door_timer + 1;
            end else begin
            case (current_floor)
                4'b0001: lift_door <= 4'b0011; // 1st floor
                4'b0010: lift_door <= 4'b0101; // 2nd floor
                4'b0011: lift_door <= 4'b1001; // 3rd floor
            endcase
            arrival_notification = 1'b0;
            // wait for 5 seconds
            if (door_timer < 600000000) begin
                door_timer = door_timer + 1;
                if (btn_door_signal == 2'b10 && door_sensor == 2'b00) begin
                    // Turn off the corresponding led on the door button panel
                    led_btn_door_off = 2'b11; // Turn signal on
                    next_state = DOOR_CLOSED; // Close door when button is pressed
                end
            end else if (door_sensor == 2'b00) begin
                door_timer = 32'b0;
                next_state = DOOR_CLOSED;
            end else begin
                door_timer = 32'b0;
            end
        end
        end
        DOOR_CLOSED: begin // 4
            if (door_timer < 100000000) begin
                door_timer = door_timer + 1;
            end else begin
                arrival_notification = 1'b0;
                led_btn_door_off = 2'b11; // Turn signal on
                lift_door = 4'b0000;
                door_timer = 32'b0;
                next_state = IDLE; // Return to idle after door is closed
            end
        end
        EMERGENCY_STOP: begin // 5
            emergency_stopped = 1'b1;
            next_state = IDLE; // Return to idle after emergency stop
        end
        default: next_state = IDLE; // Default state
    endcase
    door_sensor_led_panel = door_sensor;
    direction_led_panel = direction_led;
    led_keypad_status = keypad_status;
end

endmodule
