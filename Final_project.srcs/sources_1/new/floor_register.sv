module floor_register (
    input wire clk,
    input wire reset,
    input wire [1:0] btn_call_up_floor_signal,
    input wire [1:0] btn_call_down_floor_signal,
    input wire [3:1] btn_select_floor_signal,
    input wire [3:1] floor_remove,
    output reg [3:1] floor_request,
    output reg [3:1] floor_request_led
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        floor_request <= 3'b000; // Reset all floor requests
        floor_request_led <= 3'b000; // Reset all floor request LEDs
    end else begin
        // Process call up floor signals
        if (btn_call_up_floor_signal[0]) begin // Up button at 1st floor
            floor_request[1] <= 1'b1; 
            floor_request_led[1] <= 1'b1; 
            end

        if (btn_call_up_floor_signal[1]) begin // Up button at 2nd floor
            floor_request[2] <= 1'b1; 
            floor_request_led[2] <= 1'b1;
            end

        // Process call down floor signals
        if (btn_call_down_floor_signal[0]) begin // Down button at 2nd floor
            floor_request[2] <= 1'b1; 
            floor_request_led[2] <= 1'b1;
            end

        if (btn_call_down_floor_signal[1]) begin // Down button at 3rd floor
            floor_request[3] <= 1'b1; 
            floor_request_led[3] <= 1'b1;
            end
        
        // Process floor selection signals
        if (btn_select_floor_signal[1]) begin // Select 1st floor
            floor_request[1] <= 1'b1; 
            floor_request_led[1] <= 1'b1;
            end

        if (btn_select_floor_signal[2]) begin // Select 2nd floor
            floor_request[2] <= 1'b1; 
            floor_request_led[2] <= 1'b1;
            end

        if (btn_select_floor_signal[3]) begin // Select 3rd floor
            floor_request[3] <= 1'b1; 
            floor_request_led[3] <= 1'b1;
            end
        
        // Process floor removal signals
        if (floor_remove[1]) begin // Remove 1st floor
            floor_request[1] <= 1'b0; 
            floor_request_led[1] <= 1'b0;
            end
        if (floor_remove[2]) begin // Remove 2nd floor
            floor_request[2] <= 1'b0; 
            floor_request_led[2] <= 1'b0;
            end
        if (floor_remove[3]) begin // Remove 3rd floor
            floor_request[3] <= 1'b0; 
            floor_request_led[3] <= 1'b0;
            end
    end
end
endmodule
