module SpiSlave(
  input  cs,
  input  clk,
  input  mosi_,
  output reg miso_ = 1
);

    reg [31:0] cmd;
    reg [23:0] addr;

    reg [5:0] bits_in;
    reg [5:0] bits_out;
    reg [31:0] bytes_sent;

    reg [7:0] mem['h1000000];
    reg [7:0] buffer;

    always @(negedge cs) begin
        cmd <= 0;
        bits_in <= 0;
        bits_out <= 0;
        bytes_sent <= 'x;
    end

    always @(posedge clk) begin
        if (!cs) begin
            if (bits_in < 32) begin
                cmd = (cmd << 1) | mosi_;
                addr = cmd[23:0];
                bits_in = bits_in + 1;
            end else begin
                if (bits_out == 0) begin
                    bytes_sent = 0;
                    buffer = mem[addr];
                end else if (bits_out % 8 == 0) begin
                    addr = addr + 1;
                    buffer = mem[addr];
                    bytes_sent = bytes_sent + 1;
                end else begin
                    buffer = buffer << 1;
                end

                miso_ = buffer[7];
                bits_out <= bits_out + 1;
            end
        end
    end

    initial begin
        $readmemh("flash.hex", mem);
    end

endmodule
