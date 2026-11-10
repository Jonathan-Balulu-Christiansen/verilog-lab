module traffic_light ( //each color is represented by a bit in the output
    input logic clk,
    input logic rst,
    output logic red,
    output logic yellow,
    output logic green
);

typedef enum logic [1:0] {
    RED = 2'b00,
    YELLOW = 2'b01,
    GREEN = 2'b10
} state_t;

state_t state, next_state;
logic [2:0] timer;

always_ff @(posedge clk) begin
    if (rst)
        state <= RED;
    else
        state <= next_state;
end

always_comb begin
    next_state = state; // default to stay in the same state
    case (state)
        RED: if (timer == 3'd3) next_state = GREEN;
        GREEN: if (timer == 3'd4) next_state = YELLOW;
        YELLOW: if (timer == 3'd1) next_state = RED;
        default: next_state = RED; // default case to handle unexpected states
    endcase
end

always_ff @(posedge clk) begin
    if (rst || next_state != state)
        timer <= 3'd0;
    else
        timer <= timer + 1;
end

assign red = (state == RED);
assign yellow = (state == YELLOW);
assign green = (state == GREEN);

endmodule
