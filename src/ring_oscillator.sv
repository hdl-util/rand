module ring_oscillator #(
    parameter int WIDTH
) (
    output logic [WIDTH-1:0] state
);

integer i;
generate
always_comb
begin
    if (WIDTH == 1)
        state[0] = ~state[0];
    else if (WIDTH == 2)
    begin
        state[0] = state[0] ^~ state[1];
        state[1] = state[0] ^ state[1];
    end
    else
    begin
        state[0] = ~(state[0] ^ state[1] ^ state[WIDTH - 1]);
        for (i = 1; i < WIDTH - 1; i++)
        begin
            state[i] = state[i - 1] ^ state[i] ^ state[i + 1];
        end
        state[WIDTH - 1] = state[WIDTH - 2] ^ state[WIDTH - 1] ^ state[0];
    end
end
endgenerate

endmodule
