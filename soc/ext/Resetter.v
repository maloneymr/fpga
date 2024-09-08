module Resetter(
    input clock,
    output reg out = 1
);
    reg has_reset = 0;

    always @(posedge(clock)) begin
        if (!has_reset) begin
            has_reset <= 1;
            out <= 1;
        end else begin
            out <= 0;
        end
    end
endmodule
