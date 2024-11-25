module lift_controller (
    input clk, reset,
    // I/O
    input [1:0] door_sensor,
    input [1:0] btn_door, btn_call_up_floor, btn_call_down_floor,
    input [3:1] btn_select_floor,
    output [1:0] led_btn_door, led_btn_call_up_floor, led_btn_call_down_floor,
    output [3:1] led_btn_select_floor,
    output [1:0] direction_led,
    output [6:0] seg,
    output [3:0] anode,
    output [3:0] lift_door
);

// Define states
typedef enum logic [3:0] {
    IDLE = 4'b0000,
    MOVING_UP = 4'b0001,
    MOVING_DOWN = 4'b0010,
    DOOR_OPEN = 4'b0011,
    DOOR_CLOSED = 4'b0100
    // Add other states as needed
} state_t;

state_t current_state, next_state;

// Store values for state machine
reg [3:0] current_floor;
reg [1:0] lift_stage;
reg [1:0] direction;
// Signal form door
wire door_status;
wire [1:0] door_signal;
// Signal from panel button
wire [1:0] btn_door_signal, btn_call_up_floor_signal, btn_call_down_floor_signal;
wire [3:1] btn_select_floor_signal;
// Signal to panel led to turn off
reg [1:0] led_btn_door_off, led_btn_call_up_floor_off, led_btn_call_down_floor_off;
reg [3:1] led_btn_select_floor_off;

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
    .btn_select_floor_out(btn_select_floor_signal)
);

lift_door door1(
    .clk(clk),
    .reset(reset),
    .door_open_in(door_signal[0]),        // door open signal
    .door_close_in(door_signal[1]),       // door close signal
    .current_floor(current_floor),       // current floor
    .lift_stage(lift_stage),          // lift stage output
    .sensor(door_sensor),   // sensor signal
    .door(lift_door),       // door signal output
    .door_status()          // door status output
);

seven_seg_decoder decoder1(
    .value(current_floor),   
    .seg(seg)
);

assign anode = 4'b1110;

direction_display direction1(
    .clk(clk),
    .reset(reset),
    .direction(direction),
    .led(direction_led)
);

// Initialize state
initial begin
    current_state = IDLE;
    current_floor = 4'b0001;
    lift_stage = 2'b00;
    direction = 2'b00;
end

// State transition logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= IDLE;
        current_floor <= 4'b0001;
        lift_stage <= 2'b00;
        direction <= 2'b00;
    end else begin
        current_state <= next_state;
    end
end

// Next state logic
always @(*) begin
    // Default next state
    next_state = current_state;

    case (current_state)
        IDLE: begin
            if (btn_call_up_floor_signal || btn_call_down_floor_signal || btn_select_floor_signal) begin
                next_state = (direction == 2'b01) ? MOVING_UP : MOVING_DOWN;
            end
        end
        MOVING_UP: begin
            if (current_floor < 4'b0011) begin // top floor is 3rd 
                current_floor = current_floor + 1;
            end
            if (btn_door_signal) begin
                next_state = DOOR_OPEN;
            end
        end
        MOVING_DOWN: begin
            if (current_floor > 4'b0001) begin // buttom floor is 1st
                current_floor = current_floor - 1;
            end
            if (btn_door_signal) begin
                next_state = DOOR_OPEN;
            end
        end
        DOOR_OPEN: begin
            if (door_sensor == 2'b01) begin
                next_state = DOOR_CLOSED;
            end
        end
        DOOR_CLOSED: begin
            if (door_sensor == 2'b10) begin
                next_state = IDLE;
            end
        end
        // Add other states and transitions as needed
    endcase
end

endmodule