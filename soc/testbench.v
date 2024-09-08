module Testbench();
  reg i = 0;
  initial begin
    $dumpfile("build/out.vcd");
    $dumpvars(0, top);
    $dumpvars(0, counter);
  end

  reg clock = 1'b0;
  reg miso = 1'b1;
  reg switch0 = 1'b1;

  reg [31:0] counter = 32'b0;

  always #(5) clock = !clock;

  reg reset = 1;

  always @(posedge clock) begin
    if (counter > 1) begin
      reset = 0;
    end else begin
      reset = 1;
    end
  end

  reg valid = 0;
  reg [3:0] strb = 4'b0000;

  MemorySubsystem top(
    .clock(clock),
    .reset(reset),
    .mem__mem_valid(valid),
    .mem__mem_instr(1'b0),
    .mem__mem_addr(32'h20000000),
    .mem__mem_wdata(32'h1234abcd),
    .mem__mem_wstrb(strb)
  );

  always @(posedge clock) begin
    counter <= counter + 32'b1;
    if (counter == 32'd3) begin
        valid <= 1;
        strb <= 4'b1111;
    end

    if (counter == 32'd7) begin
        valid <= 0;
        strb <= 4'b0;
    end

    if (counter == 32'd10) begin
        valid <= 1;
        strb <= 4'b0;
    end

    if (counter == 32'd14) begin
        valid <= 0;
    end

    if (counter == 32'd100000) begin
        $finish;
    end
  end
endmodule
